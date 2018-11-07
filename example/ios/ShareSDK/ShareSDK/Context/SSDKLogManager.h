//
//  SSDKLogService.h
//  ShareSDK
//
//  Created by Max on 2018/5/11.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBFoundation/MOBFLogService.h>

/**
 *  发送日志延时
 */
static const NSTimeInterval SendLogDelay = 2.0;

@interface SSDKLogManager : NSObject

@property (strong, nonatomic) MOBFLogService *service;

@property (weak, nonatomic) NSString *appkey;

@property (weak, nonatomic) NSString *duid;

// 服务器时间戳
@property (assign, nonatomic) NSTimeInterval timestamp;

//统计设备信息开关
@property (nonatomic, assign) BOOL statDeviceOn;

//统计分享信息开关
@property (nonatomic, assign) BOOL statShareOn;

//统计授权信息开关
@property (nonatomic, assign) BOOL statAuthOn;

/**
 日志发送队列
 */
@property (strong, nonatomic) dispatch_queue_t logQueue;

/**
 日志发送信号量
 */
@property (strong, nonatomic) dispatch_semaphore_t semaphore;

+ (instancetype)defaultManager;

/**
 需要等待服务器下发请求地址
 */
- (void)unlockSend;

/**
 *  发送启动日志
 */
- (void)sendRunLog;

/**
 *  发送退出日志
 */
- (void)sendExitLog;

/**
 *  发送授权日志
 *
 *  @param user 用户信息
 */
- (void)sendAuthLog:(SSDKUser *)user;

/**
 *  发送分享日志
 *
 *  @param platformType  平台类型
 *  @param contentEntity 内容实体
 *  @param user          用户信息
 *  @param target        标识
 */
- (void)sendShareLog:(SSDKPlatformType)platformType
       contentEntity:(SSDKContentEntity *)contentEntity
                user:(SSDKUser *)user
              target:(NSString *)target;

/**
 记录分享行为事件
 
 @param platformType 平台
 @param eventType 事件类型
 */
- (void)recordShareEventWithPlatform:(SSDKPlatformType)platformType eventType:(SSDKShareEventType)eventType;

/**
 *  发送API日志
 *
 *  @param platformType 平台类型
 *  @param api          请求API路径
 */
- (void)sendApiLog:(SSDKPlatformType)platformType
               api:(NSString *)api;

/**
 转短链接口，写在这边因为这边的队列控制，并且断链也有日志统计
 
 @param urls 需要转换的链接
 @param user 当前授权用户
 @param platformType 平台类型
 @param result 转换结果
 */
- (void)getShortUrls:(NSArray *)urls
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result;


@end
