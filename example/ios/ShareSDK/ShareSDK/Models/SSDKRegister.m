//
//  SSDKRegister.m
//  ShareSDK
//
//  Created by Max on 2018/5/7.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKRegister.h"

@implementation SSDKRegister

- (instancetype)init
{
    if (self = [super init])
    {
        _platformsInfo = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)setupSinaWeiboWithAppkey:(NSString *)appkey
                       appSecret:(NSString *)appSecret
                     redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeSinaWeibo];
    _platformsInfo[platform] = dictionary;
}

- (void)setupWeChatWithAppId:(NSString *)appId
                   appSecret:(NSString *)appSecret
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appId;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
        
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeWechat];
    _platformsInfo[platform] = dictionary;
}

- (void)setupQQWithAppId:(NSString *)appId
                  appkey:(NSString *)appkey
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appId;
    }
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeQQ];
    _platformsInfo[platform] = dictionary;
}

- (void)setupTwitterWithKey:(NSString *)key
                     secret:(NSString *)secret
                redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([key isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerKey] = key;
    }
    
    if ([secret isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerSecret] = secret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeTwitter];
    _platformsInfo[platform] = dictionary;
}

- (void)setupFacebookWithAppkey:(NSString *)appkey
                      appSecret:(NSString *)appSecret
                    displayName:(NSString *)displayName
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKApikey] = appkey;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([displayName isKindOfClass:NSString.class])
    {
        dictionary[SSDKDisplayName] = displayName;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeFacebook];
    _platformsInfo[platform] = dictionary;
}

- (void)setupTencentWeiboWithAppkey:(NSString *)appkey
                          appSecret:(NSString *)appSecret
                        redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeTencentWeibo];
    _platformsInfo[platform] = dictionary;
}

- (void)setupYiXinByAppId:(NSString *)appId
                appSecret:(NSString *)appSecret
              redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppId] = appId;
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:[NSString class]])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeYiXin];
    _platformsInfo[platform] = dictionary;
}

- (void)setupEvernoteByConsumerKey:(NSString *)consumerKey
                    consumerSecret:(NSString *)consumerSecret
                           sandbox:(BOOL)sandbox
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        dictionary[SSDKConsumerKey] = consumerKey;
    }
    
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        dictionary[SSDKConsumerSecret] = consumerSecret;
    }
    
    dictionary[SSDKSandbox] = @(sandbox);
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeYinXiang];
    _platformsInfo[platform] = dictionary;
}

- (void)setupDouBanWithApikey:(NSString *)apikey
                    appSecret:(NSString *)appSecret
                  redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([apikey isKindOfClass:NSString.class])
    {
        dictionary[SSDKApikey] = apikey;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeDouBan];
    _platformsInfo[platform] = dictionary;
}

- (void)setupRenRenWithAppId:(NSString *)appId
                      appKey:(NSString *)appKey
                   secretKey:(NSString *)secretKey
                    authType:(SSDKAuthorizeType)authType
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appId;
    }
    
    if ([appKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appKey;
    }
    
    if ([secretKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKSecretKey] = secretKey;
    }
    
    dictionary[SSDKAuthTypeKey] = @(authType);
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeRenren];
    _platformsInfo[platform] = dictionary;
}

- (void)setupKaiXinByApiKey:(NSString *)apiKey
                  secretKey:(NSString *)secretKey
                redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([apiKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKApikey] = apiKey;
    }
    
    if ([secretKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKSecretKey] = secretKey;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeKaixin];
    _platformsInfo[platform] = dictionary;
}

- (void)setupPocketWithConsumerKey:(NSString *)consumerKey
                       redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([consumerKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerKey] = consumerKey;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
        
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypePocket];
    _platformsInfo[platform] = dictionary;
}

- (void)setupGooglePlusByClientID:(NSString *)clientId
                     clientSecret:(NSString *)clientSecret
                      redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([clientId isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientId] = clientId;
    }
    
    if ([clientSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientSecret] = clientSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeGooglePlus];
    _platformsInfo[platform] = dictionary;
}

- (void)setupInstagramWithClientId:(NSString *)clientId
                      clientSecret:(NSString *)clientSecret
                       redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([clientId isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientId] = clientId;
    }
    
    if ([clientSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientSecret] = clientSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeInstagram];
    _platformsInfo[platform] = dictionary;
}

- (void)setupLinkedInByApiKey:(NSString *)apiKey
                    secretKey:(NSString *)secretKey
                  redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([apiKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKApikey] = apiKey;
    }
    
    if ([secretKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKSecretKey] = secretKey;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[@"redirect_url"] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeLinkedIn];
    _platformsInfo[platform] = dictionary;
}

- (void)setupTumblrByConsumerKey:(NSString *)consumerKey
                  consumerSecret:(NSString *)consumerSecret
                     redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([consumerKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerKey] = consumerKey;
    }
    
    if ([consumerSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerSecret] = consumerSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[@"callback_url"] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeTumblr];
    _platformsInfo[platform] = dictionary;
}

- (void)setupFlickrWithApiKey:(NSString *)apiKey
                    apiSecret:(NSString *)apiSecret
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([apiKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKApikey] = apiKey;
    }
    
    if ([apiSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKApiSecret] = apiSecret;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeFlickr];
    _platformsInfo[platform] = dictionary;
}

- (void)setupYouDaoNoteWithConsumerKey:(NSString *)consumerKey
                        consumerSecret:(NSString *)consumerSecret
                         oauthCallback:(NSString *)oauthCallback
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([consumerKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerKey] = consumerKey;
    }
    
    if ([consumerSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerSecret] = consumerSecret;
    }
    
    if ([oauthCallback isKindOfClass:NSString.class])
    {
        dictionary[SSDKOAuthCallback] = oauthCallback;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeYouDaoNote];
    _platformsInfo[platform] = dictionary;
}

/**
 设置支付宝好友应用信息
 
 @param appId 应用标识
 */
- (void)setupAliSocialWithAppId:(NSString *)appId
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appId;
    }

    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeAliSocial];
    _platformsInfo[platform] = dictionary;
}

- (void)setupPinterestByClientId:(NSString *)clientId;
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([clientId isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientId] = clientId;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypePinterest];
    _platformsInfo[platform] = dictionary;
}

- (void)setupKaKaoWithAppkey:(NSString *)appkey
                  restApiKey:(NSString *)restApiKey
                 redirectUrl:(NSString *)redirectUrl;
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    if ([restApiKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKRestApiKey] = restApiKey;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
        
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeKakao];
    _platformsInfo[platform] = dictionary;
}

- (void)setupDropboxWithAppKey:(NSString *)appId
                     appSecret:(NSString *)appSecret
                   redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appId;
    }
    
    if ([appSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKOAuthCallback] = redirectUrl;
    }

    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeDropbox];
    _platformsInfo[platform] = dictionary;
}

- (void)setupVKontakteWithApplicationId:(NSString *)applicationId
                              secretKey:(NSString *)secretKey
                               authType:(SSDKAuthorizeType)authType
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([applicationId isKindOfClass:NSString.class])
    {
        dictionary[SSDKApplicationId] = applicationId;
    }
    
    if ([secretKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKSecretKey] = secretKey;
    }
    
    dictionary[SSDKAuthTypeKey] = @(authType);
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeVKontakte];
    _platformsInfo[platform] = dictionary;
}

- (void)setupInstapaperWithConsumerKey:(NSString *)consumerKey
                        consumerSecret:(NSString *)consumerSecret
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([consumerKey isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerKey] = consumerKey;
    }
    
    if ([consumerSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKConsumerSecret] = consumerSecret;
    }

    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeInstapaper];
    _platformsInfo[platform] = dictionary;
}

- (void)setupDingTalkWithAppId:(NSString *)appId
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appId isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appId;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeDingTalk];
    _platformsInfo[platform] = dictionary;
}

- (void)setupMeiPaiWithAppkey:(NSString *)appkey
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeMeiPai];
    _platformsInfo[platform] = dictionary;
}

- (void)setupYouTubeWithClientId:(NSString *)clientId
                    clientSecret:(NSString *)clientSecret
                     redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([clientId isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientId] = clientId;
    }
    
    if ([clientSecret isKindOfClass:NSString.class])
    {
        dictionary[SSDKClientSecret] = clientSecret;
    }
    
    if ([redirectUrl isKindOfClass:NSString.class])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeYouTube];
    _platformsInfo[platform] = dictionary;
}

- (void)setupLineAuthType:(SSDKAuthorizeType)authType
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    dictionary[SSDKAuthTypeKey] = @(authType);
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeLine];
    _platformsInfo[platform] = dictionary;
}

- (void)setupSMSOpenCountryList:(BOOL)open
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    dictionary[SSDKOpenCountryList] = @(open);
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeSMS];
    _platformsInfo[platform] = dictionary;
}

- (void)setupMingDaoByAppKey:(NSString *)appKey
                   appSecret:(NSString *)appSecret
                 redirectUrl:(NSString *)redirectUrl
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if ([appKey isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppkey] = appKey;
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    
    if ([redirectUrl isKindOfClass:[NSString class]])
    {
        dictionary[SSDKRedirectUrl] = redirectUrl;
    }
    
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeMingDao];
    _platformsInfo[platform] = dictionary;
}

- (void)setupCMCCByAppId:(NSString *)appid
                  appKey:(NSString *)appkey
               displayUI:(BOOL)displayUI
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([appid isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppId] = appid;
    }
    
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    
    dictionary[SSDKDisplayUI] = @(displayUI);
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeCMCC];
    _platformsInfo[platform] = dictionary;
}

- (void)setupTelegramByBotToken:(NSString *)botToken
                      botDomain:(NSString *)botDomain
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([botToken isKindOfClass:NSString.class])
    {
        dictionary[@"bot_token"] = botToken;
    }
    if ([botDomain isKindOfClass:[NSString class]])
    {
        dictionary[@"bot_domain"] = botDomain;
    }
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeTelegram];
    _platformsInfo[platform] = dictionary;
}

- (void)setupRedditByAppKey:(NSString *)appkey
                redirectUri:(NSString *)redirectUri
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        dictionary[SSDKRedirectUrl] = redirectUri;
    }
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeReddit];
    _platformsInfo[platform] = dictionary;
}

- (void)setupESurfingByAppKey:(NSString *)appkey
                    appSecret:(NSString *)appSecret
                      appName:(NSString *)appName
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if ([appkey isKindOfClass:NSString.class])
    {
        dictionary[SSDKAppkey] = appkey;
    }
    if ([appSecret isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppSecret] = appSecret;
    }
    if ([appName isKindOfClass:[NSString class]])
    {
        dictionary[SSDKAppName] = appName;
    }
    NSString *platform = [NSString stringWithFormat:@"%lu",(unsigned long)SSDKPlatformTypeESurfing];
    _platformsInfo[platform] = dictionary;
}

@end
