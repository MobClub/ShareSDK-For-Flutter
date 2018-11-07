//
//  SSDKConnectorProtocol.h
//  ShareSDK
//
//  Created by Max on 2018/5/8.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBFoundation/IMOBFServiceComponent.h>

@class SSDKShareSession;
@class SSDKAuthSession;
@class SSDKCallApiSession;
@class SSDKGetFriendsSession;
@class SSDKAddFriendSession;

@protocol SSDKConnectorProtocol <IMOBFComponent>

/**
 判断是不是该平台的connector
 */
+ (BOOL)isConnectorForPlatformType:(SSDKPlatformType)platformType;

/**
 更新平台信息
 */
+ (void)updatePlatformConfigWithInfo:(NSDictionary *)info;

/**
 主动加载该平台的Js,一般用于extension framework直接调用js的需求
 */
+ (NSString *)loadJs;

@optional

/**
 分享
 */
+ (void)share:(SSDKShareSession *)shareSession;

/**
 授权
 */
+ (void)authorize:(SSDKAuthSession *)authSession;

/**
 获取用户信息
 */
+ (void)getUserInfo:(SSDKAuthSession *)authSession;

/**
 回调URL
 */
+ (void)handleOpenUrl:(NSURL *)url;

/**
 平台当前授权的用户
 */
+ (SSDKUser *)currentUser;

/**
 取消授权
 */
+ (void)cancelAuth:(void(^)(NSError *error))result;


@end
