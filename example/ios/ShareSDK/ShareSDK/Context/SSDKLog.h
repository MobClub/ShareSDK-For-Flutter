//
//  SSDKLog.h
//  ShareSDK
//
//  Created by Max on 2018/5/11.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBFoundation/MOBFDataModel.h>

//日志类型
typedef NS_ENUM(NSUInteger, SSDKLogType) {
    SSDKLogTypeRun,
    SSDKLogTypeExist,
    SSDKLogTypeShare,
    SSDKLogTypeAuth,
    SSDKLogTypeEvent,
    SSDKLogTypeApi
};

@interface SSDKLog : MOBFDataModel

// 日志类型
@property (assign, nonatomic) SSDKLogType type;

// 日志类型对应的 字符串标识
@property (nonatomic, copy) NSString *typeSign;

// 转换过得日志内容，用于上传
@property (nonatomic, copy, readonly) NSString *content;

// 用户信息，授权log和分享log参数
@property (strong, nonatomic) SSDKUser *user;

// 分享内容，分享log参数
@property (strong, nonatomic) SSDKContentEntity *contentEntity;

// 分享平台，分享log参数
@property (assign, nonatomic) SSDKPlatformType platformType;

// 目标数据，不知道干啥的，分享log参数
@property (nonatomic, copy) NSString *target;

// 事件id 事件log参数
@property (nonatomic, copy) NSString *eventId;

// 事件target 事件log参数
@property (nonatomic, copy) NSString *eventTarget;

// 事件参数 事件log参数
@property (nonatomic, copy) NSString *eventParams;

// apiLog 参数
@property (nonatomic, copy) NSString *api;

+ (instancetype)logWithType:(SSDKLogType)type;

// 获取日志内容
- (void)getContent:(void(^)(NSString *content))result;

@end
