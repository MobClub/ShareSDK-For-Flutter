//
//  SSDKHelper.h
//  ShareSDK
//
//  Created by Max on 2018/5/8.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSDKHelper : NSObject

@property (assign, nonatomic) NSTimeInterval startTime;

+ (instancetype)shareHelper;

- (SSDKPlatformType)convertPlatformType:(SSDKPlatformType)type;

- (void)shareParams:(NSMutableDictionary *)parameters fillSceneWithPlatformsType:(SSDKPlatformType)platformType;

- (NSString *)currentNetworkType;

- (NSInteger)versionNumber;

- (NSString *)screenResolution;

- (NSTimeInterval)runDuration;

- (void)setCacheUser:(SSDKUser *)user platformType:(SSDKPlatformType)platformType key:(NSString *)platformKey;

- (SSDKUser *)cachedUserWithPlatform:(SSDKPlatformType)platformType key:(NSString *)platformKey;

@end
