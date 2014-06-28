//
//  ImageData.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 26.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "MediaData.h"

@implementation MediaData

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _imageLowResUrl              = [[[attributes valueForKeyPath:@"images"]  valueForKeyPath:@"low_resolution"]      valueForKeyPath:@"url"];
    _imageThumbnailUrl           = [[[attributes valueForKeyPath:@"images"]  valueForKeyPath:@"thumbnail"]           valueForKeyPath:@"url"];
    _imageStandardUrl            = [[[attributes valueForKeyPath:@"images"]  valueForKeyPath:@"standard_resolution"] valueForKeyPath:@"url"];
    _imageStandardSize           = [[[[attributes valueForKeyPath:@"images"]  valueForKeyPath:@"standard_resolution"] valueForKeyPath:@"width"]integerValue];
    
    _caption                = [[attributes valueForKeyPath:@"caption"]  valueForKeyPath:@"text"];
    // Check if there is a caption
    if ( ([_caption  isEqual: @""]) || ([[attributes valueForKeyPath:@"caption"]  valueForKeyPath:@"text"] == [NSNull null]) )
        _caption = nil;
    
    _likes                  = [[[attributes objectForKey:@"likes"]      valueForKey:@"count"]                   integerValue];
    
    _commentsNo             = [[[attributes objectForKey:@"comments"]   valueForKey:@"count"]                   integerValue];
    _comments               = [[attributes valueForKeyPath:@"comments"] valueForKeyPath:@"data"];
    if (_commentsNo>0) {
    _commentsFirstComment   = [_comments[0] valueForKeyPath:@"text"];
    } else _comments = nil;
    
    
    _location               = [attributes valueForKeyPath:@"location"];
    // Check if there are location values
    if ([_location valueForKeyPath:@"latitude"]  == [NSNull null]
     || [_location valueForKeyPath:@"longitude"]  == [NSNull null]) {
        _location = nil;
    } else {
        _locationLatitude  = [_location valueForKeyPath:@"latitude"];
        _locationLongitude = [_location valueForKeyPath:@"longitude"];
        if ([_location valueForKeyPath:@"name"] != [NSNull null]) _locationName = [_location valueForKeyPath:@"name"];
    }

    return self;
}

@end
