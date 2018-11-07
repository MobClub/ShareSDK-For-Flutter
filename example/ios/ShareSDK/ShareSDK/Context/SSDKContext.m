//
//  SSDKContext.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/5.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MOBFoundation/MOBFAdService.h>
#import <MOBFoundation/MobSDK_Private.h>
#import <MOBFoundation/MOBFComponentManager.h>
#import <MOBFoundation/MOBFJSContext.h>
#import "SSDKConnectorProtocol.h"

#import "SSDKLogManager.h"
#import "SSDKContext.h"
#import "SSDKService.h"
#import "SSDKRegister.h"
#import "SSDKJsProxy.h"
#import "SSDKShareSession.h"
#import "SSDKAuthSession.h"

@interface SSDKContext ()

/**
 用户注册的信息/服务器下发的信息
 */
@property (strong, nonatomic) NSMutableDictionary *finalPlatformConfigs;

@end

@implementation SSDKContext

#pragma mark - Init

+ (SSDKContext *)defaultContext
{
    static SSDKContext *_instance = nil;
    static dispatch_once_t defaultContextPredicate;
    dispatch_once(&defaultContextPredicate, ^{
        _instance = [[SSDKContext alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    if (self = [super init])
    {
        _recordIntentionShare = YES;
        _mainQueue = dispatch_queue_create("ssdkQueue", DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(0);
        [self _addSystemNotification];
    }
    return self;
}

- (void)awakeFromMOBFoundationWithAppkey:(NSString *)appkey duid:(NSString *)duid
{
    DebugLog(@"appkey:%@\n  duid:%@",appkey,duid);
    self.appKey = appkey;
    self.duid = duid;
    //加载app设置
    [self _loadAppConfig];
    
    //加载服务器平台设置
    [self _loadPlatformsConfig:^(NSError *error) {
        
        if (error)
        {
            DebugLog(@"%@",error);
        }
    }];
}

- (void)registPlatforms:(void(^)(SSDKRegister *platformsRegister))importHandler
{
    SSDKRegister *regist = [[SSDKRegister alloc] init];
    
    if (importHandler)
    {
        importHandler(regist);
    }
    
    _regist = regist;
    _finalPlatformConfigs = nil;
}

- (void)_loadAppConfig
{
    __weak SSDKService *theService = [SSDKService sharedService];
    __weak SSDKLogManager *theManager = [SSDKLogManager defaultManager];
    theManager.appkey = self.appKey;
    theManager.duid = self.duid;
    [theService getAppConfigWithAppkey:self.appKey duid:self.duid result:^(BOOL statDeviceOn, BOOL statShareOn, BOOL statAuthOn, BOOL backflowOn, NSTimeInterval timestamp, NSError *error) {
        
        theManager.timestamp = timestamp;
        theManager.statDeviceOn = statDeviceOn;
        theManager.statShareOn = statShareOn;
        theManager.statAuthOn = statAuthOn;
        theService.backflowOn = backflowOn;
        
        [[SSDKLogManager defaultManager] unlockSend];
        
        DebugLog(@"%@",error);
    }];
}

- (void)_loadPlatformsConfig:(void(^)(NSError *error))result
{
    __weak typeof(self) weakSelf = self;
    [[SSDKService sharedService] getPlatformConfigsWithAppkey:self.appKey duid:self.duid result:^(NSArray *configs, NSError *error) {
        
        if (!error )
        {
            DebugLog(@"%@",configs);
            weakSelf.serverPlatformConfigs = configs;
            _finalPlatformConfigs = nil;
        }
        else
        {
            DebugLog(@"error:%@",error);
        }
        
        if (result)
        {
            result(error);
        }
        
        dispatch_semaphore_signal(_semaphore);
    }];
}

- (NSDictionary *)configWithPlatform:(SSDKPlatformType)platform
{
    platform = [[SSDKHelper shareHelper] convertPlatformType:platform];
    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)platform];
    
    if (!_finalPlatformConfigs)
    {
        _finalPlatformConfigs = self.regist.platformsInfo.mutableCopy;
        if (!_finalPlatformConfigs)
        {
            _finalPlatformConfigs = [NSMutableDictionary dictionary];
        }
        
        for (NSDictionary *config in _serverPlatformConfigs)
        {
            if ([config isKindOfClass:NSDictionary.class] && config[@"snsplat"])
            {
                NSInteger type = [config[@"snsplat"] integerValue];
                type = [[SSDKHelper shareHelper] convertPlatformType:type];
                NSString *platformKey = [NSString stringWithFormat:@"%ld",(long)type];
                NSMutableDictionary *registed = _finalPlatformConfigs[platformKey];
                
                if (!registed)
                {
                    registed = [NSMutableDictionary dictionary];
                    _finalPlatformConfigs[platformKey] = registed;
                }
                
                for (NSString *key in config.allKeys)
                {
                    if ([key isEqualToString:@"snsplat"])
                    {
                        continue;
                    }
                    registed[key] = config[key];
                }
            }
        }
        
        DebugLog(@"%@",_finalPlatformConfigs);
    }
    
    return _finalPlatformConfigs[key];
}

- (NSMutableArray *)activePlatforms
{
    static NSMutableArray *activePlatforms = nil;
    
    if (!activePlatforms)
    {
        activePlatforms = [NSMutableArray array];

        for (NSInteger i=1; i<100; i++)
        {
            id connector = [self connectorWithPlatform:i];
            if (connector)
            {
                [activePlatforms addObject:@(i)];
            }
        }
    }
    return activePlatforms;
}

#pragma mark - Operations

- (SSDKSession *)shareWithContent:(NSMutableDictionary *)parameters platform:(SSDKPlatformType)platformType stateChanged:(SSDKShareStateChangedHandler)stateChangedHandler
{
    if (self.recordIntentionShare)
    {
        [[SSDKLogManager defaultManager] recordShareEventWithPlatform:platformType eventType:SSDKShareEventTypeOpenEditor];
    }
    
    SSDKShareSession *session = [[SSDKShareSession alloc] init];
    [[SSDKHelper shareHelper] shareParams:parameters fillSceneWithPlatformsType:platformType]; // 需要填充Scene以区分分享场景
    session.params = parameters.mutableCopy?:[NSMutableDictionary dictionary];
    
    // 包装日志发送
    __weak typeof(session) theSession = session;
    session.stateChangedHandler = ^(SSDKResponseState state, NSError *error) {
        
        NSString *target = [MOBFJson jsonStringFromObject:theSession.userData[@"@flags"]];
        switch (state)
        {
            case SSDKResponseStateSuccess:
                [[SSDKLogManager defaultManager] sendShareLog:platformType contentEntity:theSession.contentEntity user:[self _currentUserWithPlatformType:platformType] target:target];
                break;
                
            case SSDKResponseStateFail:
                DebugLog(@"%@",error);
                [[SSDKLogManager defaultManager] recordShareEventWithPlatform:platformType eventType:SSDKShareEventTypeFailed];
                break;
                
            case SSDKResponseStateCancel:
                [[SSDKLogManager defaultManager] recordShareEventWithPlatform:platformType eventType:SSDKShareEventTypeCancel];
                break;
                
            default:
                break;
        }
        
        if (stateChangedHandler && !session.isCancelled)
        {
            stateChangedHandler(state, theSession.userData, theSession.contentEntity, error);
        }
    };
    
    [self waitForInit:^(BOOL isJsExist) {
        
        if (!isJsExist)
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail,nil,nil,[SSDKError unloadedFile:@"sharesdk.js"]);
            }
            return ;
        }
        
        id <SSDKConnectorProtocol>connector = [self connectorWithPlatform:platformType];
        
        if (connector)
        {
            //更新平台配置
            [connector updatePlatformConfigWithInfo:[self configWithPlatform:platformType]];
            
            if ([connector respondsToSelector:@selector(share:)])
            {
                [connector share:session];
            }
            else
            {
                if (stateChangedHandler)
                {
                    stateChangedHandler(SSDKResponseStateFail, nil, nil, [SSDKError unsupportFeature]);
                }
            }
        }
        else
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail, nil, nil, [SSDKError platformUninitWithDescription:@"Connector is not exsit"]);
            }
        }
    }];
    
    return session;
}

- (SSDKSession *)authorize:(SSDKPlatformType)platformType
                  settings:(NSDictionary *)settings
              stateChanged:(SSDKAuthorizeStateChangedHandler)stateChangedHandler
{
    SSDKAuthSession *session = [[SSDKAuthSession alloc] init];
    session.settings = settings.mutableCopy ?: [NSMutableDictionary dictionary];
    session.stateChangedHandler = ^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        if (SSDKResponseStateSuccess)
        {
            [[SSDKLogManager defaultManager] sendAuthLog:user];
        }
        
        if (stateChangedHandler)
        {
            stateChangedHandler(state, user, error);
        }
    };
    
    [self waitForInit:^(BOOL isJsExist) {
        
        if (!isJsExist)
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail,nil,[SSDKError unloadedFile:@"sharesdk.js"]);
            }
            return ;
        }
        
        id <SSDKConnectorProtocol>connector = [self connectorWithPlatform:platformType];
        if (connector)
        {
            [connector updatePlatformConfigWithInfo:[self configWithPlatform:platformType]];
            
            if ([connector respondsToSelector:@selector(authorize:)])
            {
                [connector authorize:session];
            }
            else
            {
                if (stateChangedHandler)
                {
                    stateChangedHandler(SSDKResponseStateFail, nil, [SSDKError unsupportFeature]);
                }
            }
            
        }
        else
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail, nil, [SSDKError platformUninitWithDescription:@"Connector is not exsit"]);
            }
        }
    }];
    
    return session;
}

- (SSDKSession *)getUserInfo:(SSDKPlatformType)platformType
                   condition:(SSDKUserQueryCondition *)condition
                stateChanged:(SSDKGetUserStateChangedHandler)stateChangedHandler
{
    SSDKAuthSession *session = [[SSDKAuthSession alloc] init];
    session.userQueryCondition = condition;
    session.stateChangedHandler = ^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        if (stateChangedHandler)
        {
            stateChangedHandler(state, user, error);
        }
    };
    
    [self waitForInit:^(BOOL isJsExist) {
        
        if (!isJsExist)
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail,nil,[SSDKError unloadedFile:@"sharesdk.js"]);
            }
            return ;
        }
        
        id <SSDKConnectorProtocol>connector = [self connectorWithPlatform:platformType];
        
        if (connector)
        {
            [connector updatePlatformConfigWithInfo:[self configWithPlatform:platformType]];
            
            if ([connector respondsToSelector:@selector(getUserInfo:)])
            {
                [connector getUserInfo:session];
            }
            else
            {
                if (stateChangedHandler)
                {
                    stateChangedHandler(SSDKResponseStateFail, nil, [SSDKError unsupportFeature]);
                }
            }
        }
        else
        {
            if (stateChangedHandler)
            {
                stateChangedHandler(SSDKResponseStateFail, nil, [SSDKError platformUninitWithDescription:@"Connector is not exsit"]);
            }
        }
    }];
    
    return session;
}

- (void)handleCallbackWithUrl:(NSURL *)url;
{
    NSArray *comps = [[MOBFComponentManager defaultManager] getComponents:@protocol(SSDKConnectorProtocol)];
    
    for (id<SSDKConnectorProtocol> obj in comps)
    {
        if ([obj respondsToSelector:@selector(handleOpenUrl:)])
        {
            [obj handleOpenUrl:url];
        }
    }
}

- (BOOL)hasAuthorized:(SSDKPlatformType)platformType
{
    SSDKUser *user = [self _currentUserWithPlatformType:platformType];
    if (user)
    {
        return YES;
    }
    return NO;
}

- (void)cancelAuthorize:(SSDKPlatformType)platformType result:(void(^)(NSError *error))result
{
    [self waitForInit:^(BOOL isJsExist) {
        
        id <SSDKConnectorProtocol>connector = [self connectorWithPlatform:platformType];
        
        if (connector)
        {
            [connector updatePlatformConfigWithInfo:[self configWithPlatform:platformType]];
            
            if ([connector respondsToSelector:@selector(cancelAuth:)])
            {
                [connector cancelAuth:result];
            }
            else
            {
                if (result)
                {
                    result([SSDKError unsupportFeature]);
                }
            }
        }
        else
        {
            if (result)
            {
                result([SSDKError platformUninitWithDescription:@"Connector is not exist"]);
            }
        }
    }];
}

- (void)getShortUrls:(NSArray *)urls
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result
{
    [[SSDKLogManager defaultManager] getShortUrls:urls user:user platformType:platformType result:result];
}

#pragma mark - Privite

- (SSDKUser *)_currentUserWithPlatformType:(SSDKPlatformType)platformType
{
    id <SSDKConnectorProtocol>connector = [self connectorWithPlatform:platformType];
    [connector updatePlatformConfigWithInfo:[self configWithPlatform:platformType]]; //need
    if ([connector respondsToSelector:@selector(currentUser)])
    {
        return [connector currentUser];
    }
    else
    {
        return nil;
    }
}

- (BOOL)_loadJs
{
    static BOOL exist = NO;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *path = [bundle pathForResource:@"ScriptCore/ShareSDK" ofType:@"js"];
        NSString *extPath = [bundle pathForResource:@"ScriptCore/NativeExt" ofType:@"js"];
        
        if (path && extPath)
        {
            [[MOBFJSContext defaultContext] loadPluginWithPath:path forName:@"com.mob.sharesdk.base"];
            [[MOBFJSContext defaultContext] loadPluginWithPath:extPath forName:@"com.mob.ext"];
            [[SSDKJsProxy defaultProxy] registJsMethod];
            exist = YES;
        }
    });
    return exist;
}

// 获取connector的同时更新config
- (id <SSDKConnectorProtocol>)connectorWithPlatform:(SSDKPlatformType)platformType
{
    static NSArray *comps = nil;
    
    if (!comps)
    {
        comps = [[MOBFComponentManager defaultManager] getComponents:@protocol(SSDKConnectorProtocol)];
    }
    
    for (id<SSDKConnectorProtocol> obj in comps)
    {
        if ([obj isConnectorForPlatformType:platformType])
        {
            return obj;
        }
    }
    return nil;
}

// 等待服务器配置, 每次启动第一次拉去一下，之后业务执行的时候判断 用户本地是否注册，如果本地未注册，且服务器配置未下发，则尝试重新拉取服务器配置，再执行其他业务
- (void)waitForInit:(void(^)(BOOL isJsExist))operation
{
    dispatch_async(_mainQueue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            BOOL exist = [self _loadJs];//保证在主线程加载js
            BOOL needUpdateServerConfig = (_regist == nil && _serverPlatformConfigs == nil);
            if (needUpdateServerConfig)
            {
                [self _loadPlatformsConfig:^(NSError *error) {
                    
                    if (error)
                    {
                        DebugLog(@"%@",error);
                    }
                    
                    operation(exist);
                }];
            }
            else
            {
                operation(exist);
                dispatch_semaphore_signal(_semaphore);
            }
        });
    });
}

#pragma mark - Run && exist Log

- (void)_addSystemNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)_appDidBecomeActive
{
    DebugLog(@"-------------------app active-----------------");
    [SSDKHelper shareHelper].startTime = [[NSDate date] timeIntervalSince1970];
    [[SSDKLogManager defaultManager] sendRunLog];
}

- (void)_appDidEnterBackground
{
    [[SSDKLogManager defaultManager] sendExitLog];
}

@end
