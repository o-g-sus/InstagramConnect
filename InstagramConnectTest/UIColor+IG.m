//
//  UIColor+IG.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 26.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "UIColor+IG.h"

@implementation UIColor (IG)

+ (UIColor*) colorWithHexColor:(int)hex alpha:(CGFloat)alpha
{
    
    int r = (hex & 0xff0000) >> 16;
    int g = (hex & 0x00ff00) >> 8;
    int b = (hex & 0x0000ff);
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
+ (UIColor*) colorWithHexColor:(int)hex
{
    return [self colorWithHexColor:hex alpha:1.0];
}



+ (UIColor*) igBlue
{
    static UIColor *color = nil;
    if (!color) color = [UIColor colorWithHexColor:0x427097];
    return color;
}


@end
