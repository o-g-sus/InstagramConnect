//
//  CarTableViewCell.h
//  TableViewStory
//
//  Created by Neil Smyth on 9/24/12.
//  Copyright (c) 2012 Neil Smyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mediaImage;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *LikesNo;

@end
