//
//  CarTableViewCell.m
//  TableViewStory
//
//  Created by Neil Smyth on 9/24/12.
//  Copyright (c) 2012 Neil Smyth. All rights reserved.
//

#import "MediaTableViewCell.h"

@implementation MediaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
