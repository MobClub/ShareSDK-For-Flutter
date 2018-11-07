//
//  SSDKDataService.m
//  ShareSDK
//
//  Created by Max on 2018/5/7.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKDataService.h"


@interface SSDKDataService()

@end

@implementation SSDKDataService

+ (instancetype)shareService
{
    static SSDKDataService *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKDataService alloc] init];
    });
    
    return singleton;
}

- (void)cacheServerConnectPermission:(BOOL)allow
{
    [[MOBFDataService sharedInstance] setCacheData:@(allow) forKey:@"server_connect_permission" domain:SSDKCacheDataDomain];
}

- (BOOL)isAllowedConnectServer
{
    NSNumber *data = [[MOBFDataService sharedInstance] cacheDataForKey:@"server_connect_permission" domain:SSDKCacheDataDomain];

    if ([data isKindOfClass:NSNumber.class])
    {
        return data.boolValue;
    }
    
    return NO;
}

- (void)cacheQueryServerConnectPermissionTime
{
    [[MOBFDataService sharedInstance] setCacheData:[NSDate date] forKey:@"query_connect_permission_time" domain:SSDKCacheDataDomain];
}

- (BOOL)needQueryServerConnectPermission
{
    NSDate *date = [[MOBFDataService sharedInstance] cacheDataForKey:@"query_connect_permission_time" domain:SSDKCacheDataDomain];
    
    return (!date || [date timeIntervalSinceNow] > 86400);
}

#pragma mark -  app配置

- (void)cacheAppConfig:(NSDictionary *)appConfig
{
    [[MOBFDataService sharedInstance] setCacheData:appConfig forKey:@"server_app_config" domain:SSDKCacheDataDomain];
}

- (NSDictionary *)appConfig
{
   NSDictionary *config = [[MOBFDataService sharedInstance] cacheDataForKey:@"server_app_config" domain:SSDKCacheDataDomain];
    
    if ([config isKindOfClass:NSDictionary.class])
    {
        return config;
    }
    
    return nil;
}

#pragma mark - 服务器平台设置

- (void)cachePlatformConfigs:(NSArray *)settings
{
    [[MOBFDataService sharedInstance] setCacheData:settings forKey:@"server_platforms_config" domain:SSDKCacheDataDomain];
}

- (NSArray *)platformConfigs
{
    NSArray *data = [[MOBFDataService sharedInstance] cacheDataForKey:@"server_platforms_config" domain:SSDKCacheDataDomain];
    if ([data isKindOfClass:NSArray.class])
    {
        return data;
    }
    return nil;
}

#pragma mark - 最后一次启动时间

- (NSTimeInterval)lastSendRunLogTime
{
    return [[[MOBFDataService sharedInstance] cacheDataForKey:@"last_send_runLog_time" domain:SSDKCacheDataDomain] doubleValue];
}

- (void)cacheSendRunLogTime
{
    [[MOBFDataService sharedInstance] setCacheData:@([[NSDate date] timeIntervalSince1970]) forKey:@"last_send_runLog_time" domain:SSDKCacheDataDomain];
}

@end
