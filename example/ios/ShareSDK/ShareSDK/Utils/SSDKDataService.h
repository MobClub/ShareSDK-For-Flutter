//
//  SSDKDataService.h
//  ShareSDK
//
//  Created by Max on 2018/5/7.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSDKDataService : NSObject

+ (instancetype)shareService;

// 请求服务器连接权限
- (void)cacheServerConnectPermission:(BOOL)allow;
- (BOOL)isAllowedConnectServer;
- (void)cacheQueryServerConnectPermissionTime;
- (BOOL)needQueryServerConnectPermission;

// app配置
- (void)cacheAppConfig:(NSDictionary *)appConfig;
- (NSDictionary *)appConfig;

// 服务器平台设置
- (void)cachePlatformConfigs:(NSArray *)settings;
- (NSArray *)platformConfigs;

// 发送启动日志时间
- (NSTimeInterval)lastSendRunLogTime;
- (void)cacheSendRunLogTime;

@end
