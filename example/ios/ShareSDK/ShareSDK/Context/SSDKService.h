//
//  SSDKService.h
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/10.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSDKTypeDefine.h"

@class SSDKUser;

/**
 *  服务对象，用于与服务器交互
 */
@interface SSDKService : NSObject

//短链服务开关（回流）
@property (nonatomic, assign) BOOL backflowOn;

/**
 *  获取配置信息
 */
- (void)getAppConfigWithAppkey:(NSString *)appkey duid:(NSString *)duid result:(void(^)(BOOL statDeviceOn, BOOL statShareOn, BOOL statAuthOn, BOOL backflowOn, NSTimeInterval timestamp, NSError *error))result;

/**
 *  获取平台应用配置
 */
- (void)getPlatformConfigsWithAppkey:(NSString *)appkey duid:(NSString *)duid result:(void(^)(NSArray *configs, NSError *error))result;

/**
 *  上传分享图片
 */
- (void)uploadSharedImage:(NSString *)filePath
                   appkey:(NSString *)appkey
                 onResult:(void(^)(NSString *imageUrl, NSError *error))resultHandler;

/**
 *  发送日志信息
 */
- (void)sendLogs:(NSArray *)logs appkey:(NSString *)appkey onResult:(void(^)(NSError *error))resultHandler;

/**
 *  获取转换后的短链接
 */
- (void)getShortUrls:(NSArray *)urls
              appkey:(NSString *)appkey
                duid:(NSString *)duid
        statDeviceOn:(BOOL)statDeviceOn
          statAuthOn:(BOOL)statAuthOn
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
            onResult:(void(^)(NSArray *shortUrls, NSError *error))resultHandler;

/**
 *  是否允许连接服务器
 */
- (void)getServerConnectPermissionWithAppkey:(NSString *)appkey result:(void(^)(BOOL allow, NSError *error))result;

/**
 *  获取共享的服务对象
 *
 *  @return 服务对象
 */
+ (SSDKService *)sharedService;

@end
