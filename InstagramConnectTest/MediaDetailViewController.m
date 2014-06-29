//
//  MediaDetailViewController.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 27.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "MediaDetailViewController.h"

#import "HintHelper.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MediaDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end



@implementation MediaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Fullscreen";
    
    // @Annotation
    // here a background queue for image loading makes no since, because you want to immediately see the picture when layover opens
    
    NSURL * imageURL = [NSURL URLWithString:_mediaData.imageStandardUrl];
    NSData * imgData = [NSData dataWithContentsOfURL:imageURL];
    _imageView.image = [UIImage imageWithData:imgData];
    
    _imageView.frame = _scrollView.bounds;
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    _scrollView.contentSize = CGSizeMake(_imageView.frame.size.width, _imageView.frame.size.height);
    _scrollView.maximumZoomScale = 4.0;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.delegate = self;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Email"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(sendEmailClicked:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SEND A FRIEND

- (void)sendEmailClicked:(id)sender {
    
    // http://www.appcoda.com/ios-programming-101-send-email-iphone-app/
    
    // Email Subject
    //NSArray *toRecipents = [NSArray arrayWithObject:@"info@o-g-sus.de"];
    
    NSString *emailTitle = @"My Instagram picture";
    NSString *messageBody = [NSString stringWithFormat:@"Hi, look at my Instagram picture: <a href='%@'>Instagram image</a>", _mediaData.imageStandardUrl];
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:emailTitle];
    [mailComposer setMessageBody:messageBody isHTML:YES];
    
    // Present mail view controller on screen
    [self presentViewController:mailComposer animated:YES completion:NULL];
    
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            [HintHelper showHintWithTitle:@"Email preset" andMessage:@"Mail sent"];
            break;
        case MFMailComposeResultFailed:
            [HintHelper showHintWithTitle:@"Email preset" andMessage:@"Mail sent failure"];
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
