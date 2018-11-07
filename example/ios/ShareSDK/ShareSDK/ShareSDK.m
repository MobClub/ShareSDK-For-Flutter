//
//  ShareSDK.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/5.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "ShareSDK.h"
#import "SSDKContext.h"
#import <MOBFoundation/MobSDK.h>
#import <MOBFoundation/IMOBFServiceComponent.h>
#import "IMOBFShareComponent.h"
#import "ShareSDK+Base.h"

@interface ShareSDK() <IMOBFServiceComponent,IMOBFShareComponent>

@end

@implementation ShareSDK

+ (void)registPlatforms:(void(^)(SSDKRegister *platformsRegister))importHandler
{
    [[SSDKContext defaultContext] registPlatforms:importHandler];
}

+ (SSDKSession *)share:(SSDKPlatformType)platformType
            parameters:(NSMutableDictionary *)parameters
        onStateChanged:(SSDKShareStateChangedHandler)stateChangedHandler
{
    return [[SSDKContext defaultContext] shareWithContent:parameters platform:platformType stateChanged:stateChangedHandler];
}

+ (SSDKSession *)authorize:(SSDKPlatformType)platformType
                  settings:(NSDictionary *)settings
            onStateChanged:(SSDKAuthorizeStateChangedHandler)stateChangedHandler
{
    return [[SSDKContext defaultContext] authorize:platformType settings:settings stateChanged:stateChangedHandler];
}

+ (BOOL)hasAuthorized:(SSDKPlatformType)platformType
{
    return [[SSDKContext defaultContext] hasAuthorized:platformType];
}

+ (void)cancelAuthorize:(SSDKPlatformType)platformType result:(void(^)(NSError *error))result;
{
    [[SSDKContext defaultContext] cancelAuthorize:platformType result:result];
}

+  (void)cancelAuthorize:(SSDKPlatformType)platformType
{
     [[SSDKContext defaultContext] cancelAuthorize:platformType result:nil];
}

+ (SSDKSession *)getUserInfo:(SSDKPlatformType)platformType
              onStateChanged:(SSDKGetUserStateChangedHandler)stateChangedHandler
{
    return [self getUserInfo:platformType condition:nil onStateChanged:stateChangedHandler];
}

+ (void)registerActivePlatforms:(NSArray *)activePlatforms
                       onImport:(SSDKImportHandler)importHandler
                onConfiguration:(SSDKConfigurationHandler)configurationHandler
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        NSMutableDictionary *configs = [NSMutableDictionary dictionary];
        for (NSNumber *obj in activePlatforms)
        {
            SSDKPlatformType type = [obj integerValue];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            configurationHandler(type, dic);
            NSString *platformKey = [NSString stringWithFormat:@"%lu",(unsigned long)type];
            configs[platformKey] = dic;
        }
        
        [platformsRegister setValue:configs forKey:@"platformsInfo"];
    }];
}

#pragma mark - IMOBFServiceComponent

+ (NSString *)componentName
{
    return @"SHARESDK";
}

+ (NSString *)componentVersion
{
    return SSDKVersionString;
}

+ (void)onReg:(NSString *)duid
{
    [[SSDKContext defaultContext] awakeFromMOBFoundationWithAppkey:MobSDK.appKey duid:duid];
}

@end
