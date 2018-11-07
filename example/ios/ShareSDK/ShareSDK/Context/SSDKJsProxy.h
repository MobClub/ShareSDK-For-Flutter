//
//  SSDKJsProxy.h
//  ShareSDK
//
//  Created by Max on 2018/5/18.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSDKJsProxy : NSObject

+ (instancetype)defaultProxy;

- (void)registJsMethod;

- (void)checkUrlSchemes:(NSArray <NSString *>*)urlScheme result:(void(^)(BOOL exist, NSString *urlScheme))result;

- (void)getShortUrls:(NSArray *)urls
            platform:(SSDKPlatformType)platformType
                user:(SSDKUser *)user
              result:(void(^)(NSArray *shortUrls, NSError *error))result;

@end
