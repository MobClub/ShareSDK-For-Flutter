//
//  SSDKContext.h
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/5.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSDKRegister;
@protocol SSDKConnectorProtocol;
@class SSDKSession;
@class SSDKUserQueryCondition;

/**
 *  上下文对象, 用于整个SDK中的配置信息、资源的维护
 */
@interface SSDKContext : NSObject

/**
 *  应用标识
 */
@property (nonatomic, copy) NSString *appKey;

/**
 *  设备标识
 */
@property (nonatomic, copy) NSString *duid;

/**
 用户代码注册的平台信息
 */
@property (strong, nonatomic, readonly) SSDKRegister *regist;

/**
 服务器下发各平台的配置
 */
@property (strong, nonatomic) NSArray *serverPlatformConfigs;

/**
 意向分享开关，发送 SHARESDK_EDIT_SHARE 事件 默认初始化为YES
 */
@property (assign, nonatomic) BOOL recordIntentionShare;

/**
 操作队列
 */
@property (strong, nonatomic) dispatch_queue_t mainQueue;

/**
 操作信号量
 */
@property (strong, nonatomic) dispatch_semaphore_t semaphore;

/**
 激活的平台列表
 */
@property (strong, nonatomic) NSMutableArray *activePlatforms;

/**
 *  获取默认上下文对象
 */
+ (SSDKContext *)defaultContext;

/**
 * 初始化
 */
- (void)awakeFromMOBFoundationWithAppkey:(NSString *)appkey duid:(NSString *)duid;

/**
 * 注册平台
 */
- (void)registPlatforms:(void(^)(SSDKRegister *platformsRegister))importHandler;

#pragma mark - 分享与授权

- (SSDKSession *)shareWithContent:(NSMutableDictionary *)parameters
                         platform:(SSDKPlatformType)platformTyoe
                     stateChanged:(SSDKShareStateChangedHandler)stateChangedHandler;

- (SSDKSession *)authorize:(SSDKPlatformType)platformType
                  settings:(NSDictionary *)settings
              stateChanged:(SSDKAuthorizeStateChangedHandler)stateChangedHandler;

- (SSDKSession *)getUserInfo:(SSDKPlatformType)platformType
                   condition:(SSDKUserQueryCondition *)condition
                stateChanged:(SSDKGetUserStateChangedHandler)stateChangedHandler;

- (BOOL)hasAuthorized:(SSDKPlatformType)platformType;

- (void)cancelAuthorize:(SSDKPlatformType)platformType result:(void(^)(NSError *error))result;

- (NSDictionary *)configWithPlatform:(SSDKPlatformType)platform;

#pragma mark - Privite headers

- (void)handleCallbackWithUrl:(NSURL *)url;

- (void)getShortUrls:(NSArray *)urls
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result;

/**
 获取connector 暴露给extension使用
 */
- (id <SSDKConnectorProtocol>)connectorWithPlatform:(SSDKPlatformType)platformType;

/**
 operation队列 暴露给extension使用
 */
- (void)waitForInit:(void(^)(BOOL isJsExist))operation;

@end
