//
//  MediaDetailViewController.h
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 27.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MediaData.h"

@interface MediaDetailViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) MediaData *mediaData;

@end
