//
//  MediaData.h
//  InstagramConnectTest
//
//  Created by Oliver Greschke on 25.06.14.
//  Copyright (c) 2014 Oliver Greschke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramDataManager : NSObject


@property (strong, nonatomic) NSMutableArray* mediaDataArray;
@property (strong, nonatomic) NSArray* mediaDataReversedArray;

+ (InstagramDataManager *)sharedData;

- (void)loadRequestForMediaDataWithToken:(NSString*)token andEndpoint:(NSString*)endpoint;

@end
