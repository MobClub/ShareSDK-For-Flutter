//
//  ShareSDK+Base.m
//  ShareSDK
//
//  Created by Max on 2018/5/10.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "ShareSDK+Base.h"
#import "SSDKContext.h"
#import "SSDKLogManager.h"

@implementation ShareSDK (Base)

+ (NSString *)sdkVersion
{
    return SSDKVersionString;
}

+ (NSDictionary *)configWithPlatform:(SSDKPlatformType)platform
{
    return [[SSDKContext defaultContext] configWithPlatform:platform];
}

+ (void)getShortUrls:(NSArray *)urls
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result
{
    [[SSDKContext defaultContext] getShortUrls:urls user:user platformType:platformType result:result];
}

+ (void)getShortUrls:(NSArray *)urls
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result
{
    [[SSDKContext defaultContext] getShortUrls:urls user:nil platformType:platformType result:result];
}

+ (SSDKSession *)getUserInfo:(SSDKPlatformType)platformType
                   condition:(SSDKUserQueryCondition *)condition
              onStateChanged:(SSDKGetUserStateChangedHandler)stateChangedHandler
{
    return [[SSDKContext defaultContext] getUserInfo:platformType condition:condition stateChanged:stateChangedHandler];
}

+ (void)enableAutomaticRecordingEvent:(BOOL)record
{
    [SSDKContext defaultContext].recordIntentionShare = record;
}

+ (void)recordShareEventWithPlatform:(SSDKPlatformType)platformType eventType:(SSDKShareEventType)eventType
{
     [[SSDKLogManager defaultManager] recordShareEventWithPlatform:platformType eventType:eventType];
}

+ (NSMutableArray *)activePlatforms
{
    return [[SSDKContext defaultContext] activePlatforms];
}

+ (void)authorize:(SSDKPlatformType)platformType
         settings:(NSDictionary *)settings
    onViewDisplay:(SSDKAuthorizeViewDisplayHandler)viewDisplayHandler
   onStateChanged:(SSDKAuthorizeStateChangedHandler)stateChangedHandler
{
    [self authorize:platformType settings:settings onStateChanged:stateChangedHandler];
}

+ (void)getUserInfo:(SSDKPlatformType)platformType
        conditional:(SSDKUserQueryCondition *)conditional
        onAuthorize:(SSDKNeedAuthorizeHandler)authorizeHandler
     onStateChanged:(SSDKGetUserStateChangedHandler)stateChangedHandler
{
    [self getUserInfo:platformType onStateChanged:stateChangedHandler];
}

+ (void)share:(SSDKPlatformType)platformType
   parameters:(NSMutableDictionary *)parameters
  onAuthorize:(SSDKNeedAuthorizeHandler)authorizeHandler
onStateChanged:(SSDKShareStateChangedHandler)stateChangedHandler
{
    [self share:platformType parameters:parameters onStateChanged:stateChangedHandler];
}

@end
