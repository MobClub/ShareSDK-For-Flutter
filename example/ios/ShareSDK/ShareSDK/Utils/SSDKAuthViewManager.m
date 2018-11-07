//
//  SSDKAuthViewManager.m
//  ShareSDK
//
//  Created by Max on 2018/5/30.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKAuthViewManager.h"
#import "SSDKAuthViewController.h"
#import "SSDKNavigationController.h"

@interface SSDKAuthViewManager()
{
    NSMutableArray *_windows;
}
//@property (strong, nonatomic) NSMutableArray *authViewViewControllers;
@end

@implementation SSDKAuthViewManager

+ (instancetype)defaultManager
{
    static SSDKAuthViewManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKAuthViewManager alloc] init];
    });
    
    return singleton;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _windows = [NSMutableArray array];
        _cancelButtonTitle = SSDKLocalized(@"ShareSDK_cancel");
        _title = SSDKLocalized(@"ShareSDK_authTitle");
        _titleColor = [UIColor whiteColor];
        _navigationBarBackgroundColor = [UIColor blackColor];
        _cancelButtonTitleColor = [UIColor whiteColor];
        _statusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

- (void)showAuthViewWithPlatform:(SSDKPlatformType)platformType authUrl:(NSString *)url redirectUrl:(NSString *)redirectUrl callback:(NSString *)callback
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = [UIApplication sharedApplication].keyWindow.windowLevel + 1;
    window.backgroundColor = [UIColor clearColor];
    
    UIViewController *modalVc = [[UIViewController alloc] init];
    window.rootViewController = modalVc;
    
    SSDKAuthViewController *vc = [[SSDKAuthViewController alloc] init];
    vc.window = window;
    vc.platformType = platformType;
    vc.url = url;
    vc.redirectUrl = redirectUrl;
    vc.callback = callback;
    UINavigationController *nav = [[SSDKNavigationController alloc] initWithRootViewController:vc];
    
    [window makeKeyAndVisible];
    [modalVc presentViewController:nav animated:YES completion:nil];
    [_windows addObject:window];
}

- (void)hiddenAuthWindowForViewController:(SSDKAuthViewController *)viewController;
{
    viewController.window.hidden = YES;
    [viewController.window resignKeyWindow];
    [_windows removeObject:viewController.window];
}

@end
