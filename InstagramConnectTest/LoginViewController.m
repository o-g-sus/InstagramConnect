//
//  ViewController.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 17.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "LoginViewController.h"

#import "Constants.h"
#import "InstagramDataManager.h"
#import "MediaListViewController.h"
#import "UIColor+IG.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *myMediaButton;
@property (weak, nonatomic) IBOutlet UIButton *popularMediaButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *loggedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectContentLabel;

@property (strong, nonatomic) NSString *accessToken;

- (IBAction)logout:(id)sender;

@end



@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Login/Select";

    [self checkLoggedIn];
}

#pragma mark - Login

// @Annotation
// Login based on:
// http://technet.weblineindia.com/mobile/instagram-api-integration-in-ios-application/2/
// http://joshuaoiknine.com/post/47541512095/instagram-oauth-login-for-ios-objective-c
// could not get OAuth2Client to work :( (No notifications were received in my testproject)

- (void) checkLoggedIn {
    
    _myMediaButton.hidden = _popularMediaButton.hidden = _logoutButton.hidden = _selectContentLabel.hidden = YES;
    
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@/?client_id=%@&redirect_uri=%@&scope=%@&response_type=token&display=touch",
                                   kOAuth2AuthorizationURL,
                                   kOAuth2ClientId,
                                   kOAuth2RedirectURL,
                                   kOAuth2Scope
                                   ];
    
    NSURL *url = [NSURL URLWithString:fullAuthUrlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:requestObj];
    _webView.hidden = NO;
    _webView.delegate = self;
    _loggedOutLabel.textColor = _selectContentLabel.textColor =[UIColor igBlue];
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString* urlString = [[request URL] absoluteString];

    if ([urlString hasPrefix:kOAuth2RedirectURL]) {
        NSRange tokenParam = [urlString rangeOfString: @"access_token="];
        if (tokenParam.location != NSNotFound) {
            NSString* token = [urlString substringFromIndex: NSMaxRange(tokenParam)];
            
            // If there are more args, don't include them in the token:
            NSRange endRange = [token rangeOfString: @"&"];
            if (endRange.location != NSNotFound)
                token = [token substringToIndex: endRange.location];
            
            NSLog(@"access token %@ %lu", token, (unsigned long)[token length]);
            if ([token length] > 0 ) {
                _accessToken = token;
            
                NSString* redirectUrl = [[NSString alloc] initWithFormat:@"%@?access_token=%@", kOAuth2Endpoint_users_self, _accessToken];
                NSLog(@"%@ - redirectUrl %@", NSStringFromClass([self class]), redirectUrl );
                [self showMediaListButtons];
            }
        }
        else {
            // Handle the access rejected case here.
            NSLog(@"rejected case, user denied request");
        }
        return NO;
    }
    return YES;
}

-(void)showMediaListButtons {
    [self webViewDidFinishLoad:nil];
    _webView.hidden = YES;
    _myMediaButton.hidden = _popularMediaButton.hidden = _logoutButton.hidden = _selectContentLabel.hidden = NO;
}

#pragma mark - IB Actions

// @Annotation
// Because my Instagram profile is rather new and empty, I use another endpoint to get more content shown for testing

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MediaListViewController *viewController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"ShowMyMedia"]) {
        [[InstagramDataManager sharedData] loadRequestForMediaDataWithToken:_accessToken andEndpoint:kOAuth2Endpoint_users_self_media_recent];
        viewController.title = @"My media";
    }
    if ([[segue identifier] isEqualToString:@"ShowPopularMedia"]) {
        [[InstagramDataManager sharedData] loadRequestForMediaDataWithToken:_accessToken andEndpoint:kOAuth2Endpoint_media_popular];
        viewController.title = @"Popular media";
    }
}

- (IBAction)logout:(id)sender {
    _accessToken = nil;
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* instagramCookies = [cookies cookiesForURL:[NSURL URLWithString:kBaseURL]];
    
    for (NSHTTPCookie* cookie in instagramCookies) {
        [cookies deleteCookie:cookie];
    }
    [self checkLoggedIn];
}

#pragma mark - WebView delegates

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicator startAnimating];
    _activityIndicator.hidden = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator stopAnimating];
    _activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
