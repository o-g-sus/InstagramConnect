//
//  ImageData.h
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 26.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaData : NSObject

@property (nonatomic, strong) NSString* imageLowResUrl;
@property (nonatomic, strong) NSString* imageThumbnailUrl;
@property (nonatomic, strong) NSString* imageStandardUrl;
@property (nonatomic, assign) NSUInteger imageStandardSize;
@property (nonatomic, strong) NSString* caption;

@property (nonatomic, assign) NSUInteger likes;

@property (nonatomic, assign) NSUInteger commentsNo;
@property (nonatomic, strong) NSMutableArray * comments;
@property (nonatomic, strong) NSString * commentsFirstComment;

@property (nonatomic, strong) NSMutableDictionary * location;
@property (nonatomic, strong) NSString * locationName;
@property (nonatomic, assign) NSNumber * locationLatitude;
@property (nonatomic, assign) NSNumber * locationLongitude;


- (id)initWithAttributes:(NSDictionary *)attributes;

@end
