//
//  HintView.m
//
//  Created by Oliver Greschke on 18.04.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "HintHelper.h"

@implementation HintHelper


+ (void) showHintWithTitle:(NSString*)myTitle andMessage:(NSString*)myMessage
{
    NSLog(@"%@ - showHintWithTitle", NSStringFromClass([self class]) );
    
    UIAlertView *alertView;
    alertView = [[UIAlertView alloc] initWithTitle:myTitle
                                                message:myMessage
                                               delegate:self
                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                      otherButtonTitles:nil, nil];
    
    [alertView show];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:alertView
                                   selector:@selector(dismissWithClickedButtonIndex:animated:)
                                   userInfo:nil
                                    repeats:NO];

}



@end
