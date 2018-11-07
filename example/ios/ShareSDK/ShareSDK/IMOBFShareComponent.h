//
//  IMOBFShareComponent.h
//  ShareSDK
//
//  Created by Max on 2018/9/29.
//  Copyright © 2018 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSDKSession;
@protocol SSDKRegisterProtocol;
@protocol SSDKUserProtocol;
@protocol SSDKCredentialProtocol;
@protocol SSDKContentEntityProtocol;

@protocol IMOBFShareComponent

+ (void)registPlatforms:(void(^)(id<SSDKRegisterProtocol> platformsRegister))importHandler;

+ (SSDKSession *)authorize:(NSUInteger)platformType
                  settings:(NSDictionary *)settings
            onStateChanged:(void(^) (SSDKResponseState state, id <SSDKUserProtocol>user, NSError *error))stateChangedHandler;

+ (BOOL)hasAuthorized:(NSInteger)platformType;

+ (void)cancelAuthorize:(NSUInteger)platformType result:(void(^)(NSError *error))result;

+ (SSDKSession *)getUserInfo:(NSInteger)platformType
              onStateChanged:(void(^) (SSDKResponseState state, id <SSDKUserProtocol>user, NSError *error))stateChangedHandler;

+ (SSDKSession *)share:(NSUInteger)platformType
            parameters:(NSMutableDictionary *)parameters
        onStateChanged:(void(^) (SSDKResponseState state, NSDictionary *userData, id<SSDKContentEntityProtocol> contentEntity,  NSError *error))stateChangedHandler;

+ (NSMutableArray *)activePlatforms;

@end

#pragma mark - SSDKCredential

@protocol SSDKCredentialProtocol

/**
 *  授权码，用于请求token,只在获取token条件不足时返回 （例：微信平台未配置appsecret）
 */
@property (nonatomic, copy) NSString *authCode;

/**
 *  用户标识
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  用户令牌
 */
@property (nonatomic, copy) NSString *token;

/**
 *  用户令牌密钥
 */
@property (nonatomic, copy) NSString *secret;

/**
 *  过期时间
 */
@property (nonatomic, assign) NSTimeInterval expired;

/**
 *  授权类型
 */
@property (nonatomic) NSInteger type;

/**
 *  原始数据
 */
@property (nonatomic, strong) NSDictionary *rawData;

/**
 *  标识授权是否可用，YES 可用， NO 已过期
 */
@property (nonatomic, readonly) BOOL available;

@end

#pragma mark - SSDKUser

@protocol SSDKUserProtocol

/**
 *  平台类型
 */
@property (nonatomic) NSUInteger platformType;

/**
 *  授权凭证， 为nil则表示尚未授权
 */
@property (nonatomic, strong) id<SSDKCredentialProtocol> credential;

/**
 *  用户标识
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  性别
 */
@property (nonatomic) NSInteger gender;

/**
 *  用户主页
 */
@property (nonatomic, copy) NSString *url;

/**
 *  用户简介
 */
@property (nonatomic, copy) NSString *aboutMe;

/**
 *  认证用户类型
 */
@property (nonatomic) NSInteger verifyType;

/**
 *  认证描述
 */
@property (nonatomic, copy) NSString *verifyReason;

/**
 *  生日
 */
@property (nonatomic, strong) NSDate *birthday;

/**
 *  粉丝数
 */
@property (nonatomic) NSInteger followerCount;

/**
 *  好友数
 */
@property (nonatomic) NSInteger friendCount;

/**
 *  分享数
 */
@property (nonatomic) NSInteger shareCount;

/**
 *  注册时间
 */
@property (nonatomic) NSTimeInterval regAt;

/**
 *  用户等级
 */
@property (nonatomic) NSInteger level;

/**
 *  教育信息
 */
@property (nonatomic, retain) NSArray *educations;

/**
 *  职业信息
 */
@property (nonatomic, retain) NSArray *works;

/**
 *  原始数据
 */
@property (strong, nonatomic) NSDictionary *rawData;

@end


#pragma mark - SSDKContentEntity

@protocol SSDKContentEntityProtocol
@property (nonatomic, strong) id cid;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *urls;
@property (nonatomic, retain) NSDictionary *rawData;
@end

#pragma mark - SSDKRegisterProtocol

@protocol SSDKRegisterProtocol

@property (strong, nonatomic, readonly) NSMutableDictionary *platformsInfo;

- (void)setupSinaWeiboWithAppkey:(NSString *)appkey
                       appSecret:(NSString *)appSecret
                     redirectUrl:(NSString *)redirectUrl;

- (void)setupWeChatWithAppId:(NSString *)appId
                   appSecret:(NSString *)appSecret;

- (void)setupQQWithAppId:(NSString *)appId
                  appkey:(NSString *)appkey;

- (void)setupTwitterWithKey:(NSString *)key
                     secret:(NSString *)secret
                redirectUrl:(NSString *)redirectUrl;

- (void)setupFacebookWithAppkey:(NSString *)appkey
                      appSecret:(NSString *)appSecret
                    displayName:(NSString *)displayName;


@end
