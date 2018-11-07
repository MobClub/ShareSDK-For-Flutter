//
//  SSDKHelper.m
//  ShareSDK
//
//  Created by Max on 2018/5/8.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKHelper.h"
#import <MOBFoundation/MobSDK_Private.h>
#import "SSDKCredential.h"
#import <Photos/Photos.h>

@implementation SSDKHelper

+ (instancetype)shareHelper
{
    static SSDKHelper *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKHelper alloc] init];
    });
    
    return singleton;
}

- (SSDKPlatformType)convertPlatformType:(SSDKPlatformType)type
{
    switch (type)
    {
        case SSDKPlatformSubTypeWechatSession:
        case SSDKPlatformSubTypeWechatTimeline:
        case SSDKPlatformSubTypeWechatFav:
            
            type = SSDKPlatformTypeWechat;
            
            break;
        case SSDKPlatformSubTypeQZone:
        case SSDKPlatformSubTypeQQFriend:
            
            type = SSDKPlatformTypeQQ;
            
            break;
        case SSDKPlatformSubTypeKakaoTalk:
        case SSDKPlatformSubTypeKakaoStory:
            
            type = SSDKPlatformTypeKakao;
            
            break;
        case SSDKPlatformSubTypeYiXinSession:
        case SSDKPlatformSubTypeYiXinTimeline:
        case SSDKPlatformSubTypeYiXinFav:
            
            type = SSDKPlatformTypeYiXin;
            
            break;
        case SSDKPlatformTypeAliSocial:
        case SSDKPlatformTypeAliSocialTimeline:
            
            type = SSDKPlatformTypeAliSocial;
            
            break;
        case SSDKPlatformTypeFacebookMessenger:
        case SSDKPlatformTypeFacebookAccount:
            type = SSDKPlatformTypeFacebook;
            break;
            
        case SSDKPlatformTypeEvernote:
            type = SSDKPlatformTypeYinXiang;
            break;
        default:
            break;
    }
    
    return type;
}

- (void)shareParams:(NSMutableDictionary *)parameters fillSceneWithPlatformsType:(SSDKPlatformType)platformType
{
    switch (platformType)
    {
        case SSDKPlatformSubTypeWechatSession:
            [parameters setObject:@(0) forKey:@"wechat_scene"];
            break;
        case SSDKPlatformSubTypeWechatTimeline:
            [parameters setObject:@(1) forKey:@"wechat_scene"];
            break;
        case SSDKPlatformSubTypeWechatFav:
            [parameters setObject:@(2) forKey:@"wechat_scene"];
            break;
        case SSDKPlatformSubTypeQQFriend:
            [parameters setObject:@(0) forKey:@"qq_scene"];
            break;
        case SSDKPlatformSubTypeQZone:
            [parameters setObject:@(1) forKey:@"qq_scene"];
            break;
        case SSDKPlatformSubTypeKakaoTalk:
            [parameters setObject:@(0) forKey:@"kakao_scene"];
            break;
        case SSDKPlatformSubTypeKakaoStory:
            [parameters setObject:@(1) forKey:@"kakao_scene"];
            break;
        case SSDKPlatformSubTypeYiXinSession:
            [parameters setObject:@(0) forKey:@"yixin_scene"];
            break;
        case SSDKPlatformSubTypeYiXinTimeline:
            [parameters setObject:@(1) forKey:@"yixin_scene"];
            break;
        case SSDKPlatformSubTypeYiXinFav:
            [parameters setObject:@(2) forKey:@"yixin_scene"];
            break;
        case SSDKPlatformTypeAliSocial:
            [parameters setObject:@(0) forKey:@"apsocial_scene"];
            break;
        case SSDKPlatformTypeAliSocialTimeline:
            [parameters setObject:@(1) forKey:@"apsocial_scene"];
            break;
        case SSDKPlatformTypeYinXiang:
            [parameters setObject:@(0) forKey:@"evernote_scene"];
            break;
        case SSDKPlatformTypeEvernote:
            [parameters setObject:@(1) forKey:@"evernote_scene"];
            break;
        default:
            break;
    }
}

- (NSString *)currentNetworkType
{
    NSString *network = @"none";
    switch ([MOBFDevice currentNetworkType])
    {
        case MOBFNetworkTypeCellular:
            network = @"cell";
            break;
        case MOBFNetworkTypeWifi:
            network = @"wifi";
            break;
        case MOBFNetworkTypeCellular2G:
            network = @"2g";
            break;
        case MOBFNetworkTypeCellular3G:
            network = @"3g";
            break;
        case MOBFNetworkTypeCellular4G:
            network = @"4g";
            break;
        default:
            break;
    }
    
    return network;
}

- (NSString *)screenResolution
{
    CGSize screenSize = [MOBFDevice nativeScreenSize];
    if (UIInterfaceOrientationIsLandscape([MobSDK statusBarOrientation]))
    {
        if (screenSize.width < screenSize.height)
        {
            CGFloat tmp = screenSize.width;
            screenSize.width = screenSize.height;
            screenSize.height = tmp;
        }
    }
    
    return [NSString stringWithFormat:@"%.0fx%.0f", screenSize.width, screenSize.height];
}

- (NSInteger)versionNumber
{
    static NSInteger versionNumber = 0;
    if (!versionNumber)
    {
        NSArray *comp = [SSDKVersionString componentsSeparatedByString:@"."];
        versionNumber = [comp[0] integerValue]*10000 + [comp[1] integerValue]*100 + [comp[2] integerValue];
    }
    return versionNumber;
}

- (NSTimeInterval)runDuration
{
    return [[NSDate date] timeIntervalSince1970] - self.startTime;
}

- (void)setCacheUser:(SSDKUser *)user platformType:(SSDKPlatformType)platformType key:(NSString *)platformKey
{
    NSString *domain = [NSString stringWithFormat:@"SSDK-Platform-%lu-%@",(unsigned long)platformType,platformKey];
    [[MOBFDataService sharedInstance] setCacheData:user forKey:@"currentUser" domain:domain];
}

- (SSDKUser *)cachedUserWithPlatform:(SSDKPlatformType)platformType key:(NSString *)platformKey
{
    NSString *domain = [NSString stringWithFormat:@"SSDK-Platform-%lu-%@",(unsigned long)platformType,platformKey];
    
    id user = [[MOBFDataService sharedInstance] cacheDataForKey:@"currentUser"  domain:domain];
    
    if ([user isKindOfClass:SSDKUser.class])
    {
        if ([user credential].available)
        {
            return user;
        }
    }
    
    //旧版本兼容代码 @since v4.1.4
    if ([user isKindOfClass:NSDictionary.class] && [user[@"credential"] isKindOfClass:NSDictionary.class])
    {
        NSDictionary *credentialInfo = user[@"credential"];
        
        NSMutableDictionary *credential = [NSMutableDictionary dictionary];
        credential[@"rawData"] = credentialInfo[@"raw_data"];
        credential[@"expired"] = credentialInfo[@"expired"];
        credential[@"token"] = credentialInfo[@"token"];
        credential[@"type"] = credentialInfo[@"type"];
        
        if (credentialInfo[@"raw_data"][@"unionid"])
        {
            credential[@"uid"] = credentialInfo[@"raw_data"][@"unionid"];
        }
        else
        {
            credential[@"uid"] = credentialInfo[@"raw_data"][@"openid"];
        }
        
        NSDictionary *userInfo = @{
                                   @"platformType":user[@"platformType"]?:@(0),
                                   @"credential":credential
                                   };
        
        SSDKUser *user = [[SSDKUser alloc] initWithDict:userInfo];
        
        if (user.credential.available)
        {
            return user;
        }
    }
    
    return nil;
}

@end
