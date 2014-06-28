//
//  IGButton.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 26.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "IGButton.h"

#import "UIColor+IG.h"

@implementation IGButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];        
    }
    return self;
}

- (void) awakeFromNib
{
    [self setup];
}

- (void) setup {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected ];
    
    self.backgroundColor = [UIColor igBlue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
