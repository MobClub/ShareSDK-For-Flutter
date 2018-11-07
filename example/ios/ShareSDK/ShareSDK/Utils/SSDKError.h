 //
//  SSDKError.h
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/26.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  错误域
 */
extern NSString *const SSDKErrorDomain;

/**
 错误

 - SSDKErrorTypeUninitPlatform: 未初始化平台
 - SSDKErrorTypeParams: 参数错误
 - SSDKErrorTypeUnsupportContentType: 不支持的分享类型
 - SSDKErrorTypeUnsetURLScheme: 尚未设置URL Scheme
 - SSDKErrorTypeClientNotInstall: 尚未安装客户端
 - SSDKErrorTypeUnsupportFeature: 不支持的功能
 - SSDKErrorTypeSDKNotInstall: SDK集成错误，缺少必要文件
 - SSDKErrorTypeSDKsApi: 第三方SDK Api返回错误
 - SSDKErrorTypeSDKsCallback: 第三方SDK 回调错误
 - SSDKErrorTypeAPIRequestFail: API请求失败
 - SSDKErrorTypeMethodException: try块捕捉到异常
 - SSDKErrorTypePermissionDenied: 权限拒绝
 - SSDKErrorTypeUserUnauth: 用户尚未授权
 */
typedef NS_ENUM(NSUInteger, SSDKErrorType) {
    SSDKErrorUnknown = 0,
    SSDKErrorTypeUninitPlatform = 100,
    SSDKErrorTypeParams = 101,
    SSDKErrorTypeUnsupportContentType = 102,
    SSDKErrorTypeUnsetURLScheme = 103,
    SSDKErrorTypeClientNotInstall = 104,
    SSDKErrorTypeUnsupportFeature = 105,
    SSDKErrorTypeSDKNotInstall = 201,
    SSDKErrorTypeTokenExpired = 204,
    SSDKErrorTypeUserUnauth = 205,
    SSDKErrorTypeSDKsApi = 300,
    SSDKErrorTypeSDKsCallback = 301,
    SSDKErrorTypeAPIRequestFail = 302,
    SSDKErrorTypeMethodException = 303,
    SSDKErrorTypePermissionDenied = 500
};

/**
 *  错误信息
 */
@interface SSDKError : NSError

/**
 源错误码
 */
@property (assign, nonatomic, readonly) SSDKErrorType type;

/**
 根据字典创建error

 @param info {"error_code":exm,"error_message":exm}
 @return SSDKError对象
 */
+ (instancetype)errorWithInfo:(NSDictionary *)info;

/**
 权限拒绝
 */
+ (instancetype)permissionDeniedWithDescription:(NSString *)description;

/**
 平台配置错误
 */
+ (instancetype)platformUninitWithDescription:(NSString *)desciption;

/**
 不支持的分享类型
 */
+ (instancetype)unSupportContentType;

/**
 未设置scheme
 */
+ (instancetype)UnsetURLScheme:(NSString *)scheme;

/**
 参数错误
 */
+ (instancetype)paramsErrorWithDescription:(NSString *)desciption;

/**
 网络请求失败
 */
+ (instancetype)requestFailedWithInfo:(NSDictionary *)info;

/**
 客户端未安装
 */
+ (instancetype)clientNotInstall;

/**
 不支持的功能
 */
+ (instancetype)unsupportFeature;

/**
 文件未加载
 */
+ (instancetype)unloadedFile:(NSString *)filename;

/**
 第三方sdk接口报错
 */
+ (instancetype)apiOfClientSDK:(NSString *)api errorInfo:(NSDictionary *)info;

/**
 第三方sdk回调报错
 */
+ (instancetype)clientSDKCallbackErrorWithInfo:(NSDictionary *)info;

/**
 catch到异常
 */
+ (instancetype)errorWithException:(NSException *)exception;

@end
