//
//  SSDKJsProxy.m
//  ShareSDK
//
//  Created by Max on 2018/5/18.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKJsProxy.h"
#import <MOBFoundation/MOBFJSContext.h>
#import <MOBFoundation/MOBFComponentManager.h>
#import "SSDKContext.h"
#import "SSDKLogManager.h"
#import "SSDKAuthViewManager.h"
#import "SSDKImage.h"
#import "SSDKData.h"
#import "SSDKConnectorProtocol.h"

@implementation SSDKJsProxy

+ (instancetype)defaultProxy
{
    static SSDKJsProxy *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKJsProxy alloc] init];
    });
    
    return singleton;
}

- (void)registJsMethod
{
    [self _registConvertUrl];
    [self _registerCallApiMethod];
    [self _registOpenAuthUrlMethod];
//    [self _registerAuthMethod];
    [self _registerGetImageDataMethod];
    [self _registerDeviceModel];
}

- (void)_registConvertUrl
{
    [[MOBFJSContext defaultContext] registerJSMethod:@"ssdk_getShortUrls" block:^(NSArray *arguments) {
        
        NSArray *urls = nil;
        SSDKUser *user = nil;
        SSDKPlatformType type = SSDKPlatformTypeUnknown;
        NSString *callback = nil;
        
        if (arguments.count > 0 && [arguments[0] isKindOfClass:[NSNumber class]])
        {
            type = [arguments[0] integerValue];
        }
        if (arguments.count > 1 && [arguments[1] isKindOfClass:[NSArray class]])
        {
            urls = arguments[1];
        }
        if (arguments.count > 2 && [arguments[2] isKindOfClass:[NSDictionary class]])
        {
            user = [[SSDKUser alloc] initWithDict:arguments[2]];
        }
        if (arguments.count > 3 && [arguments[3] isKindOfClass:[NSString class]])
        {
            callback = arguments[3];
        }
        
        [[SSDKContext defaultContext] getShortUrls:urls user:user platformType:type result:^(NSArray *shortUrls, NSError *error) {
            
             NSMutableDictionary *result= [NSMutableDictionary dictionary];
             if (error)
             {
                 [result setObject:@(error.code) forKey:@"error_code"];
                 [result setObject:error.localizedDescription forKey:@"error_message"];
             }
             else
             {
                 result[@"urls"] = shortUrls;
             }
             
             if (callback)
             {
                 [[MOBFJSContext defaultContext] runScript:[NSString stringWithFormat:@"%@(%@)", callback, [MOBFJson jsonStringFromObject:result]]];
             }
         }];
    }];
}

/**
 *  注册调用API方法
 */
- (void)_registerCallApiMethod
{
    [[MOBFJSContext defaultContext] registerJSMethod:@"ssdk_callHTTPApi" block:^(NSArray *arguments) {
        
        SSDKPlatformType platformType = SSDKPlatformTypeUnknown;
        NSString *name = nil;
        NSString *url = nil;
        if (arguments.count > 0 && [arguments[0] isKindOfClass:[NSNumber class]])
        {
            platformType = [arguments[0] integerValue];
        }
        if (arguments.count > 1 && [arguments[1] isKindOfClass:[NSString class]])
        {
            name = arguments[1];
        }
        if (arguments.count > 2 && [arguments[2] isKindOfClass:[NSString class]])
        {
            url = arguments[2];
        }
        //记录日志
        [MobSDK waitForLogAuth:^{
            NSURL *URL = [NSURL URLWithString:url];
            NSString *api = name ? name : URL.path;
            [[SSDKLogManager defaultManager] sendApiLog:platformType api:api];
        }];
        //重新组织参数进行HTTP调用
        NSMutableArray *httpArgs = [NSMutableArray array];
        for (int i = 2; i < arguments.count; i++)
        {
            id temp = arguments[i];
            if(temp == nil)
            {
                [httpArgs addObject:[NSNull null]];
            }
            else
            {
                [httpArgs addObject:temp];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[MOBFJSContext defaultContext] callJSMethod:@"$mob.native.http" arguments:httpArgs];
            
        });
    }];
}

- (void)_registOpenAuthUrlMethod
{
    [[MOBFJSContext defaultContext] registerJSMethod:@"ssdk_openAuthUrl" block:^(NSArray *arguments) {
        
        SSDKPlatformType platformType = SSDKPlatformTypeUnknown;
        NSString *url = nil;
        NSString *redirectUrl = nil;
        NSString *callback = nil;
        
        if ([arguments.firstObject isKindOfClass:NSNumber.class])
        {
            platformType = [arguments.firstObject integerValue];
        }
        
        if (arguments.count > 1 && [arguments[1] isKindOfClass:NSString.class])
        {
            url = arguments[1];
        }
        
        if (arguments.count > 2 && [arguments[2] isKindOfClass:NSString.class])
        {
            redirectUrl = arguments[2];
        }
        
        if (arguments.count > 3 && [arguments[3] isKindOfClass:NSString.class])
        {
            callback = arguments[3];
        }
        
        [[SSDKAuthViewManager defaultManager] showAuthViewWithPlatform:platformType authUrl:url redirectUrl:redirectUrl callback:callback];
    }];
}

- (void)_registerGetImageDataMethod
{
    [[MOBFJSContext defaultContext] registerJSMethod:@"ssdk_plugin_getImageData"
                                               block:^(NSArray *arguments)
     {
         NSString *imagePath = nil;
         NSString *thumbImagePath = nil;
         NSString *callback = nil;
         
         if (arguments.count > 0 && [arguments[0] isKindOfClass:[NSString class]])
         {
             imagePath = arguments[0];
         }
         
         if (arguments.count > 1 && [arguments[1] isKindOfClass:[NSString class]])
         {
             thumbImagePath = arguments[1];
         }
         
         if (arguments.count > 3 && [arguments[3] isKindOfClass:[NSString class]])
         {
             callback = arguments[3];
         }
         
         if (imagePath || thumbImagePath)
         {
             [SSDKImage getImage:imagePath
                  thumbImagePath:thumbImagePath
                          result:^(NSData *thumbImage, NSData *image) {
                              
                              NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                              
                              //根据平台直接考虑需不需要检测缩略图
                              if (thumbImage)
                              {
                                  thumbImage = [SSDKImage checkThumbImageSize:thumbImage];
                                  dic[@"thumbImage"] = [[SSDKData alloc] initWithData:thumbImage];
                              }
                              
                              if (image)
                              {
                                  dic[@"image"] = [[SSDKData alloc] initWithData:image];
                              }
                              
                              [[MOBFJSContext defaultContext] runScript:[NSString stringWithFormat:@"%@(%@)", callback, [MOBFJson jsonStringFromObject:dic]]];
                          }];
         }
     }];
}

-(void)_registerDeviceModel
{
    [[MOBFJSContext defaultContext] registerJSMethod:@"ssdk_plugin_deviceModel" block:^(NSArray *arguments) {
        NSString *callback = nil;
        if (arguments.count > 0 && [arguments[0] isKindOfClass:[NSString class]])
        {
            callback = arguments[0];
        }
        [[MOBFJSContext defaultContext] runScript:[NSString stringWithFormat:@"%@(%@)", callback, [MOBFJson jsonStringFromObject:@{@"deviceModel": [MOBFDevice deviceModel]}]]];
    }];
}

- (void)checkUrlSchemes:(NSArray <NSString *>*)urlSchemes result:(void(^)(BOOL exist, NSString *urlScheme))result
{
    NSString *randomStr = [MOBFString md5String:[NSUUID UUID].UUIDString];
    NSString *methodName = [NSString stringWithFormat:@"ShareSDK_checkUrlScheme_%@",randomStr];
    NSString *callback = [NSString stringWithFormat:@"$mob.native.%@",methodName];
    
    [[MOBFJSContext defaultContext] registerJSMethod:methodName block:^(NSArray *arguments) {
        
        BOOL exist = NO;
        NSString *scheme = nil;
        
        if (arguments.firstObject && [arguments.firstObject isKindOfClass:NSNumber.class])
        {
            exist = [arguments.firstObject boolValue];
        }
        
        if (arguments.count > 1 && [arguments[1] isKindOfClass:NSString.class])
        {
            scheme = arguments[1];
        }
        
        if (result)
        {
            result(exist, scheme);
        }
        
        [[MOBFJSContext defaultContext] runScript:[NSString stringWithFormat:@"delete %@; %@ = null;",callback, callback]];
    }];
    
    [[MOBFJSContext defaultContext] callJSMethod:@"$mob.shareSDK.checkUrlScheme" arguments:@[urlSchemes, callback]];
}

- (void)getShortUrls:(NSArray *)urls
            platform:(SSDKPlatformType)platformType
                user:(SSDKUser *)user
              result:(void(^)(NSArray *shortUrls, NSError *error))result
{
    NSString *randomStr = [MOBFString md5String:[NSUUID UUID].UUIDString];
    NSString *methodName = [NSString stringWithFormat:@"ShareSDK_convertUrl_%@",randomStr];
    NSString *callback = [NSString stringWithFormat:@"$mob.native.%@",methodName];
    
    [[MOBFJSContext defaultContext] registerJSMethod:methodName block:^(NSArray *arguments) {
        
        if (arguments.count && [arguments.firstObject isKindOfClass:NSDictionary.class])
        {
            NSArray *urls = arguments.firstObject[@"result"];
            result(urls, nil);
        }
        else
        {
            result(nil,[SSDKError requestFailedWithInfo:nil]);
        }
        
        [[MOBFJSContext defaultContext] runScript:[NSString stringWithFormat:@"delete %@; %@ = null;",callback, callback]];
    }];
    
    [[MOBFJSContext defaultContext] callJSMethod:@"$mob.shareSDK.convertUrl" arguments:@[@(platformType), user.dictionaryValue?:[NSNull null], urls, callback]];
}

@end
