//
//  SSDKError.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/26.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKError.h"

/**
 *  错误域
 */
NSString *const SSDKErrorDomain = @"ShareSDKErrorDomain";

@implementation SSDKError

- (instancetype)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict
{
    if (code < 200000)
    {
        code += 200000;
    }

    NSMutableDictionary *errorDic = dict.mutableCopy;
    errorDic[@"error_code"] = @(code);
    
    return [super initWithDomain:domain code:code userInfo:errorDic];
}

+ (instancetype)errorWithInfo:(NSDictionary *)info
{
    if ([info isKindOfClass:NSDictionary.class])
    {
        NSInteger code = [info[@"error_code"] integerValue];
        
        return [SSDKError errorWithDomain:SSDKErrorDomain code:code userInfo:info];
    }
    
    return nil;
}

/**
 权限拒绝
 */
+ (instancetype)permissionDeniedWithDescription:(NSString *)description;
{
    NSString *des = SSDKLocalized(@"ShareSDK_permissionDenied");
    NSMutableDictionary *info = @{@"description":des?:@""}.mutableCopy;
    info[@"detail"] = description?:@"";
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypePermissionDenied userInfo:info];
}

/**
 平台配置错误
 */
+ (instancetype)platformUninitWithDescription:(NSString *)description;
{
    NSString *des = SSDKLocalized(@"ShareSDK_platformUninit");
    des = [des stringByAppendingFormat:@":%@",description];
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeUninitPlatform userInfo:@{@"description":des?:@""}];
}

/**
 不支持的分享类型
 */
+ (instancetype)unSupportContentType
{
    NSString *des = SSDKLocalized(@"ShareSDK_unSupportContentType");
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeUnsupportContentType userInfo:@{@"description":des?:@""}];
}

/**
 未设置scheme
 */
+ (instancetype)UnsetURLScheme:(NSString *)scheme
{
    NSString *des = SSDKLocalized(@"ShareSDK_unsetURLScheme");
    des = [des stringByAppendingFormat:@":%@",scheme];
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeUnsetURLScheme userInfo:@{@"description":des?:@""}];
}

/**
 参数错误
 */
+ (instancetype)paramsErrorWithDescription:(NSString *)desciption
{
    NSString *des = SSDKLocalized(@"ShareSDK_paramsError");
    des = [des stringByAppendingFormat:@"：%@",desciption];
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeParams userInfo:@{@"description":des?:@""}];
}

/**
 客户端未安装
 */
+ (instancetype)clientNotInstall
{
    NSString *des = SSDKLocalized(@"ShareSDK_clientNotInstall");
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeClientNotInstall userInfo:@{@"description":des?:@""}];
}

+ (instancetype)unsupportFeature
{
    NSString *des = SSDKLocalized(@"ShareSDK_unsupportFeature");
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeUnsupportFeature userInfo:@{@"description":des?:@""}];
}

/**
 网络请求失败
 */
+ (instancetype)requestFailedWithInfo:(NSDictionary *)info
{
    NSString *des = SSDKLocalized(@"ShareSDK_apiRequestFail");
    NSMutableDictionary *userInfo = nil;
    if ([info isKindOfClass:NSDictionary.class])
    {
        userInfo = info.mutableCopy;
    }
    else
    {
        userInfo = [NSMutableDictionary dictionary];
    }
    
    userInfo[@"description"] = des;
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeAPIRequestFail userInfo:userInfo?:@{}];
}

/**
 文件未加载
 */
+ (instancetype)unloadedFile:(NSString *)filename
{
    NSString *des = SSDKLocalized(@"ShareSDK_fileNotLoaded");
    des = [des stringByAppendingFormat:@" :%@",filename];
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeSDKNotInstall userInfo:@{@"description":des?:@""}];
}

/**
 第三方sdk报错
 */
+ (instancetype)apiOfClientSDK:(NSString *)api errorInfo:(NSDictionary *)info
{
    NSMutableDictionary *userInfo = @{@"SEL":api?:@""}.mutableCopy;
    [userInfo setValuesForKeysWithDictionary:info];
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeSDKsApi userInfo:userInfo];
}

+ (instancetype)clientSDKCallbackErrorWithInfo:(NSDictionary *)info
{
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeSDKsCallback userInfo:info];
}

+ (instancetype)errorWithException:(NSException *)exception
{
    return [SSDKError errorWithDomain:SSDKErrorDomain code:SSDKErrorTypeMethodException userInfo:@{@"exception":exception?:@""}];
}

- (SSDKErrorType)type
{
    return self.code - 200000;
}
@end
