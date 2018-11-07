//
//  NSMutableDictionary+ShareSDK.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/6.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "NSMutableDictionary+SSDKInit.h"

NSString *const SSDKAuthTypeBoth        = @"both";
NSString *const SSDKAuthTypeSSO         = @"sso";
NSString *const SSDKAuthTypeWeb         = @"web";

@implementation NSMutableDictionary (SSDKInit)

- (void)SSDKSetAuthSettings:(NSArray *)authSettings
{
    if (authSettings && [authSettings isKindOfClass:[NSArray class]])
    {
        [self setObject:[authSettings componentsJoinedByString:@","] forKey:@"auth_scopes"];
    }
}

- (void)SSDKSetupSinaWeiboByAppKey:(NSString *)appKey
                         appSecret:(NSString *)appSecret
                       redirectUri:(NSString *)redirectUri
                          authType:(NSString *)authType
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKeyedSubscript:@"auth_type"];
    }
}

- (void)SSDKSetupWeChatByAppId:(NSString *)appId
                     appSecret:(NSString *)appSecret
{
    [self SSDKSetupWeChatByAppId:appId
                       appSecret:appSecret
                     backUnionID:NO];
}

- (void)SSDKSetupWeChatByAppId:(NSString *)appId
                     appSecret:(NSString *)appSecret
                   backUnionID:(BOOL)backUnionID
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    [self setObject:@(backUnionID) forKey:@"back_unionid"];
}

- (void)SSDKSetupTwitterByConsumerKey:(NSString *)consumerKey
                       consumerSecret:(NSString *)consumerSecret
                          redirectUri:(NSString *)redirectUri
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        [self setObject:consumerSecret forKey:@"consumer_secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupQQByAppId:(NSString *)appId
                    appKey:(NSString *)appKey
                  authType:(NSString *)authType
{
    [self SSDKSetupQQByAppId:appId
                      appKey:appKey
                    authType:authType
                      useTIM:NO];
}

- (void)SSDKSetupQQByAppId:(NSString *)appId
                    appKey:(NSString *)appKey
                  authType:(NSString *)authType
                    useTIM:(BOOL)useTIM
{
    [self SSDKSetupQQByAppId:appId
                      appKey:appKey
                    authType:authType
                      useTIM:useTIM
                 backUnionID:NO];
}

- (void)SSDKSetupQQByAppId:(NSString *)appId
                    appKey:(NSString *)appKey
                  authType:(NSString *)authType
                    useTIM:(BOOL)useTIM
               backUnionID:(BOOL)backUnionID
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
    
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKeyedSubscript:@"auth_type"];
    }
    if(useTIM)
    {
        [self setObject:@(1) forKey:@"qq_share_type"];
    }
    else
    {
        [self setObject:@(0) forKey:@"qq_share_type"];
    }
    [self setObject:@(backUnionID) forKey:@"back_unionid"];
}

- (void)SSDKSetupFacebookByApiKey:(NSString *)apiKey
                        appSecret:(NSString *)appSecret
                         authType:(NSString *)authType
{
    [self SSDKSetupFacebookByApiKey:apiKey
                          appSecret:appSecret
                        displayName:@""
                           authType:authType];
}

- (void)SSDKSetupFacebookByApiKey:(NSString *)apiKey
                        appSecret:(NSString *)appSecret
                      displayName:(NSString *)displayName
                         authType:(NSString *)authType
{
    if ([displayName isKindOfClass:[NSString class]])
    {
        [self setObject:displayName forKey:@"display_name"];
    }
    if ([apiKey isKindOfClass:[NSString class]])
    {
        [self setObject:apiKey forKey:@"api_key"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKeyedSubscript:@"auth_type"];
    }
}

- (void)SSDKSetupTencentWeiboByAppKey:(NSString *)appKey
                            appSecret:(NSString *)appSecret
                          redirectUri:(NSString *)redirectUri
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupDouBanByApiKey:(NSString *)apiKey
                         secret:(NSString *)secret
                    redirectUri:(NSString *)redirectUri
{
    if ([apiKey isKindOfClass:[NSString class]])
    {
        [self setObject:apiKey forKey:@"api_key"];
    }
    
    if ([secret isKindOfClass:[NSString class]])
    {
        [self setObject:secret forKey:@"secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupRenRenByAppId:(NSString *)appId
                        appKey:(NSString *)appKey
                     secretKey:(NSString *)secretKey
                      authType:(NSString *)authType
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
    
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    
    if ([secretKey isKindOfClass:[NSString class]])
    {
        [self setObject:secretKey forKey:@"secret_key"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKeyedSubscript:@"auth_type"];
    }
}

- (void)SSDKSetupKaiXinByApiKey:(NSString *)apiKey
                      secretKey:(NSString *)secretKey
                    redirectUri:(NSString *)redirectUri
{
    if ([apiKey isKindOfClass:[NSString class]])
    {
        [self setObject:apiKey forKey:@"api_key"];
    }
    
    if ([secretKey isKindOfClass:[NSString class]])
    {
        [self setObject:secretKey forKey:@"secret_key"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupPocketByConsumerKey:(NSString *)consumerKey
                         redirectUri:(NSString *)redirectUri
                            authType:(NSString *)authType
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKey:@"auth_type"];
    }
}

- (void)SSDKSetupGooglePlusByClientID:(NSString *)clientId
                         clientSecret:(NSString *)clientSecret
                          redirectUri:(NSString *)redirectUri
{
    if ([clientId isKindOfClass:[NSString class]])
    {
        [self setObject:clientId forKey:@"client_id"];
    }
    if ([clientSecret isKindOfClass:[NSString class]])
    {
        [self setObject:clientSecret forKey:@"client_secret"];
    }
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupInstagramByClientID:(NSString *)clientId
                        clientSecret:(NSString *)clientSecret
                         redirectUri:(NSString *)redirectUri
{
    if ([clientId isKindOfClass:[NSString class]])
    {
        [self setObject:clientId forKey:@"client_id"];
    }
    if ([clientSecret isKindOfClass:[NSString class]])
    {
        [self setObject:clientSecret forKey:@"client_secret"];
    }
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupLinkedInByApiKey:(NSString *)apiKey
                        secretKey:(NSString *)secretKey
                      redirectUrl:(NSString *)redirectUrl
{
    if ([apiKey isKindOfClass:[NSString class]])
    {
        [self setObject:apiKey forKey:@"api_key"];
    }
    if ([secretKey isKindOfClass:[NSString class]])
    {
        [self setObject:secretKey forKey:@"secret_key"];
    }
    if ([redirectUrl isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUrl forKey:@"redirect_url"];
    }
}

- (void)SSDKSetupTumblrByConsumerKey:(NSString *)consumerKey
                      consumerSecret:(NSString *)consumerSecret
                         callbackUrl:(NSString *)callbackUrl
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        [self setObject:consumerSecret forKey:@"consumer_secret"];
    }
    if ([callbackUrl isKindOfClass:[NSString class]])
    {
        [self setObject:callbackUrl forKey:@"callback_url"];
    }
}

- (void)SSDKSetupFlickrByApiKey:(NSString *)apiKey
                      apiSecret:(NSString *)apiSecret
{
    if ([apiKey isKindOfClass:[NSString class]])
    {
        [self setObject:apiKey forKey:@"api_key"];
    }
    if ([apiSecret isKindOfClass:[NSString class]])
    {
        [self setObject:apiSecret forKey:@"api_secret"];
    }
}

- (void)SSDKSetupYouDaoNoteByConsumerKey:(NSString *)consumerKey
                          consumerSecret:(NSString *)consumerSecret
                           oauthCallback:(NSString *)oauthCallback
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        [self setObject:consumerSecret forKey:@"consumer_secret"];
    }
    
    if ([oauthCallback isKindOfClass:[NSString class]])
    {
        [self setObject:oauthCallback forKey:@"oauth_callback"];
    }
}

- (void)SSDKSetupEvernoteByConsumerKey:(NSString *)consumerKey
                        consumerSecret:(NSString *)consumerSecret
                               sandbox:(BOOL)sandbox
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        [self setObject:consumerSecret forKey:@"consumer_secret"];
    }
    
    [self setObject:@(sandbox) forKey:@"sandbox"];
}

- (void)SSDKSetupAliSocialByAppId:(NSString *)appId
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
}

- (void)SSDKSetupPinterestByClientId:(NSString *)clientId
{
    if ([clientId isKindOfClass:[NSString class]])
    {
        [self setObject:clientId forKey:@"client_id"];
    }
}

- (void)SSDKSetupKaKaoByAppKey:(NSString *)appKey
                    restApiKey:(NSString *)restApiKey
                   redirectUri:(NSString *)redirectUri
                      authType:(NSString *)authType
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    if ([restApiKey isKindOfClass:[NSString class]])
    {
        [self setObject:restApiKey forKey:@"rest_api_key"];
    }
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKey:@"auth_type"];
    }
}

- (void)SSDKSetupDropboxByAppKey:(NSString *)appKey
                       appSecret:(NSString *)appSecret
                   oauthCallback:(NSString *)oauthCallback
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    if ([oauthCallback isKindOfClass:[NSString class]])
    {
        [self setObject:oauthCallback forKey:@"oauth_callback"];
    }
}

- (void)SSDKSetupVKontakteByApplicationId:(NSString *)applicationId
                                secretKey:(NSString *)secretKey
{
    [self SSDKSetupVKontakteByApplicationId:applicationId
                                  secretKey:secretKey
                                   authType:@"both"];
}

- (void)SSDKSetupVKontakteByApplicationId:(NSString *)applicationId
                                secretKey:(NSString *)secretKey
                                 authType:(NSString *)authType
{
    if ([applicationId isKindOfClass:[NSString class]])
    {
        [self setObject:applicationId forKey:@"application_id"];
    }
    
    if ([secretKey isKindOfClass:[NSString class]])
    {
        [self setObject:secretKey forKey:@"secret_key"];
    }
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKey:@"auth_type"];
    }
}

- (void)SSDKSetupMingDaoByAppKey:(NSString *)appKey
                       appSecret:(NSString *)appSecret
                     redirectUri:(NSString *)redirectUri
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupYiXinByAppId:(NSString *)appId
                    appSecret:(NSString *)appSecret
                  redirectUri:(NSString *)redirectUri
                     authType:(NSString *)authType
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
    
    if ([appSecret isKindOfClass:[NSString class]])
    {
        [self setObject:appSecret forKey:@"app_secret"];
    }
    
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
    
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKey:@"auth_type"];
    }
}

- (void)SSDKSetupInstapaperByConsumerKey:(NSString *)consumerKey
                          consumerSecret:(NSString *)consumerSecret
{
    if ([consumerKey isKindOfClass:[NSString class]])
    {
        [self setObject:consumerKey forKey:@"consumer_key"];
    }
    
    if ([consumerSecret isKindOfClass:[NSString class]])
    {
        [self setObject:consumerSecret forKey:@"consumer_secret"];
    }
}

- (void)SSDKSetupDingTalkByAppId:(NSString *)appId
{
    if ([appId isKindOfClass:[NSString class]])
    {
        [self setObject:appId forKey:@"app_id"];
    }
}

- (void)SSDKSetupMeiPaiByAppKey:(NSString *)appKey
{
    if ([appKey isKindOfClass:[NSString class]])
    {
        [self setObject:appKey forKey:@"app_key"];
    }
}

- (void)SSDKSetupYouTubeByClientId:(NSString *)clientId
                      clientSecret:(NSString *)clientSecret
                       redirectUri:(NSString *)redirectUri
{
    if ([clientId isKindOfClass:[NSString class]])
    {
        [self setObject:clientId forKey:@"client_id"];
    }
    if ([clientSecret isKindOfClass:[NSString class]])
    {
        [self setObject:clientSecret forKey:@"client_secret"];
    }
    if ([redirectUri isKindOfClass:[NSString class]])
    {
        [self setObject:redirectUri forKey:@"redirect_uri"];
    }
}

- (void)SSDKSetupLineAuthType:(NSString *)authType
{
    if ([authType isKindOfClass:[NSString class]])
    {
        [self setObject:authType forKeyedSubscript:@"auth_type"];
    }
}

- (void)SSDKSetpSMSOpenCountryList:(BOOL)open;
{
    [self setObject:@(open) forKey:@"open_country_list"];
}

- (void)SSDKSetupCMCCByAppId:(NSString *)appid
                      appKey:(NSString *)appkey
                   displayUI:(BOOL)displayUI
{
    if ([appid isKindOfClass:NSString.class])
    {
        self[@"app_id"] = appid;
    }
    
    if ([appkey isKindOfClass:NSString.class])
    {
        self[@"app_key"] = appkey;
    }
    
    self[@"displayUI"] = @(displayUI);
}

@end
