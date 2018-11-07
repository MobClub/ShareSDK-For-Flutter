//
//  SSDKUrlDistribute.m
//  ShareSDK
//
//  Created by Max on 2018/5/9.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKHookService.h"
#import <MOBFoundation/MOBFHookService.h>
#import "SSDKContext.h"
#import "SSDKAuthViewManager.h"

@interface SSDKHookService()

@property (strong, nonatomic) NSMutableArray *appDelegates;
@property (nonatomic, copy) NSString *wxAppId;

- (void)handleOpenURL:(NSURL *)url;
- (void)_appDidBecomeActive;

@end

#pragma mark - HookService

@implementation SSDKHookService(Hook)

- (void)_setDelegate:(id)appDelegate
{
    [[SSDKHookService shareService] setAppDelegate:appDelegate];
    [self _setDelegate:appDelegate];
}

- (void)_setDelegateP:(id)appDelegate
{
    
}

- (BOOL)_openUrl:(NSURL *)url
{
    [[NSNotificationCenter defaultCenter] addObserver:[SSDKHookService shareService] selector:@selector(_appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    return [self _openUrl:url];
}

- (BOOL)_openUrlP:(NSURL *)url
{
    return YES;
}

- (BOOL)_application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[SSDKHookService shareService] handleOpenURL:url];
    return [self _application:application handleOpenURL:url];
}

- (BOOL)_application:(UIApplication *)application handleOpenURLP:(NSURL *)url
{
    return YES;
}

- (BOOL)_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    [[SSDKHookService shareService] handleOpenURL:url];
    return [self _application:app openURL:url options:options];
}

- (BOOL)_application:(UIApplication *)app openURL:(NSURL *)url optionsP:(NSDictionary *)options
{
    return YES;
}

- (BOOL)_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[SSDKHookService shareService] handleOpenURL:url];
    return [self _application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotationP:(id)annotation
{
    return YES;
}

@end

struct SSDKMain
{
    SSDKMain()
    {
        [MOBFHookService hookRawClass:UIApplication.class rawSEL:@selector(setDelegate:) targetClass:SSDKHookService.class newSEL:@selector(_setDelegate:) placeHolderSEL:@selector(_setDelegateP:)];
        [MOBFHookService hookRawClass:UIApplication.class rawSEL:@selector(openURL:) targetClass:SSDKHookService.class newSEL:@selector(_openUrl:) placeHolderSEL:@selector(_openUrlP:)];
    }
};
static SSDKMain ssdkMain;

@implementation SSDKHookService

#pragma mark - implementation

+ (instancetype)shareService
{
    static SSDKHookService *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKHookService alloc] init];
    });
    
    return singleton;
}

- (void)setAppDelegate:(id)appDelegate
{
    if (!_appDelegates)
    {
        _appDelegates = [NSMutableArray array];
    }
    
    Class delegateClass = [appDelegate class];
    
    BOOL hasHooked = NO;
    
    for (Class obj in _appDelegates)
    {
        if ([appDelegate isKindOfClass:obj])
        {
            hasHooked = YES;
            break;
        }
    }
    
    if (delegateClass && !hasHooked)
    {
        _appDelegate = appDelegate;
        [self hookApplicationDelegate];
        [_appDelegates addObject:delegateClass];
    }
}

- (void)hookApplicationDelegate
{
    [MOBFHookService hookRawClass:[self.appDelegate class] rawSEL:@selector(application:handleOpenURL:) targetClass:SSDKHookService.class newSEL:@selector(_application:handleOpenURL:) placeHolderSEL:@selector(_application:handleOpenURLP:)];
    [MOBFHookService hookRawClass:[self.appDelegate class] rawSEL:@selector(application:openURL:sourceApplication:annotation:) targetClass:SSDKHookService.class newSEL:@selector(_application:openURL:sourceApplication:annotation:) placeHolderSEL:@selector(_application:openURL:sourceApplication:annotationP:)];
    [MOBFHookService hookRawClass:[self.appDelegate class] rawSEL:@selector(application:openURL:options:) targetClass:SSDKHookService.class newSEL:@selector(_application:openURL:options:) placeHolderSEL:@selector(_application:openURL:optionsP:)];
}

- (void)handleOpenURL:(NSURL *)url
{
    DebugLog(@"%@",url);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[SSDKContext defaultContext] handleCallbackWithUrl:url];
}

- (void)_appDidBecomeActive
{
    [self handleOpenURL:nil];
}

@end

