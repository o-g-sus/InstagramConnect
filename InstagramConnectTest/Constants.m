//
//  Constants.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 25.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//


// Example URL's
// https://api.instagram.com/v1/users/self/feed?access_token=11464534.7e744dc.619ed6689fee4b79bf711c9f21ebec7c
// https://api.instagram.com/v1/users/self/media/recent?access_token=11464534.7e744dc.619ed6689fee4b79bf711c9f21ebec7c

#import "Constants.h"

NSString * const kOAuth2AuthorizationURL                    = @"https://api.instagram.com/oauth/authorize";
NSString * const kOAuth2TokenURL                            = @"https://api.instagram.com/oauth/access_token";

NSString * const kOAuth2ClientId                            = @"7e744dcbc44f4f34a90a367493c68449";
NSString * const kOAuth2ClientSecret                        = @"7aa9a159241a4a689c1cb13891a6ccfe";
NSString * const kOAuth2RedirectURL                         = @"http://www.o-g-sus.de";

NSString * const kOAuth2Scope                               = @"comments+relationships+likes";

NSString * const kBaseURL                                   = @"https://instagram.com/";
NSString * const kOAuth2ApiURL                              = @"https://api.instagram.com/v1/";


NSString * const kOAuth2Endpoint_users_self                 = @"https://api.instagram.com/v1/users/self";
NSString * const kOAuth2Endpoint_users_self_media           = @"https://api.instagram.com/v1/users/self/media";
NSString * const kOAuth2Endpoint_users_self_media_recent    = @"https://api.instagram.com/v1/users/self/media/recent";
NSString * const kOAuth2Endpoint_users_self_feed            = @"https://api.instagram.com/v1/users/self/feed";
NSString * const kOAuth2Endpoint_users_self_followedby      = @"https://api.instagram.com/v1/users/self/followed-by";

NSString * const kOAuth2Endpoint_media_popular              = @"https://api.instagram.com/v1/media/popular";