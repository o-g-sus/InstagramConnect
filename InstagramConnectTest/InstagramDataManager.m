//
//  MediaData.m
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 25.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import "InstagramDataManager.h"

#import "Constants.h"
#import "MediaData.h"

@interface InstagramDataManager ()

@end



@implementation InstagramDataManager

+ (InstagramDataManager *)sharedData
{
    static InstagramDataManager * _sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedData = [[self alloc] init];
    });
    return _sharedData;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}



-(void)loadRequestForMediaDataWithToken:(NSString*)token andEndpoint:(NSString*)endpoint {
    
    NSString * url = [NSString stringWithFormat:@"%@?access_token=%@",endpoint,token];
    //NSLog(@"%@ 1 - url %@", NSStringFromClass([self class]), url );
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //NSLog(@"%@ 2 - data %@", NSStringFromClass([self class]), data );
    
    // @Annotation
    // Serialization here needs some time ... there were some faster options:
    // https://github.com/johnezang/JSONKit
    // BUT: looks like NSJSONSerialization got improved, even AFNetworking, one of the fastest and highly recommended web-libraries,
    // is using NSJSONSerialization
    // http://stackoverflow.com/questions/22070724/alternative-to-jsonrepresentation-in-afnetworking
    // So, it looks there is no need to replace this with something else

    NSDictionary * dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //NSLog(@"%@ 3 - dictResponse %@", NSStringFromClass([self class]), dictResponse );
   
    NSArray * responseDataArray = (NSArray*)[dictResponse objectForKey:@"data"];
    //NSLog(@"%@ 4 - responseDataArray %@", NSStringFromClass([self class]), responseDataArray );
    
    _mediaDataArray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<responseDataArray.count; i++) {
        MediaData * mediaDataRef = [[MediaData alloc]initWithAttributes:responseDataArray[i]];
        [_mediaDataArray addObject:mediaDataRef];
    }
    
    // @Annotation
    // Reverse order of data, so that lists start with the very first image posted
    _mediaDataReversedArray = [[_mediaDataArray reverseObjectEnumerator] allObjects];
}


@end
