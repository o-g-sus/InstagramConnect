//
//  MediaDetailViewController.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 27.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "MediaDetailViewController.h"

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


@end
