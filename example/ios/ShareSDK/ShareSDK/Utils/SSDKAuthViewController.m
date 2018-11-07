//
//  SSDKAuthViewController.m
//  ShareSDK
//
//  Created by Max on 2018/5/30.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKAuthViewController.h"
#import "SSDKAuthViewManager.h"
#import "SSDKLogManager.h"
#import <MOBFoundation/MOBFJSContext.h>
#import <WebKit/WebKit.h>
#import "SSDKContext.h"

@interface SSDKAuthViewController ()<WKNavigationDelegate>
@property (weak, nonatomic)  WKWebView *webView;
@end

@implementation SSDKAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupNavigationBar];
    [self _configUI];
}

- (void)_configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUserScript];
    wkWebConfig.userContentController = wkUController;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
    
    webView.navigationDelegate = self;
    
    if ([MOBFDevice versionCompare:@"11.0"] != NSOrderedAscending)
    {
        [webView.scrollView setValue:@0 forKey:@"contentInsetAdjustmentBehavior"];
    }

    NSURL *requestUrl = [NSURL URLWithString:_url];
    if (!requestUrl)
    {
        NSString *urlStr = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        requestUrl = [NSURL URLWithString:urlStr];
    }
    
    if (requestUrl)
    {
        //清除URL Cookies缓存
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookies = [cookieStorage cookiesForURL:requestUrl];
        for (int i = 0; i < cookies.count; i++)
        {
            NSHTTPCookie *cookie = cookies [i];
            [cookieStorage deleteCookie:cookie];
        }
    }
    else
    {
        NSAssert(NO, @"requestUrl exception!");
    }

    [[SSDKLogManager defaultManager] sendApiLog:_platformType api:_url];
    
    //加载授权页面
    [webView loadRequest:[NSURLRequest requestWithURL:requestUrl]];
    [self.view addSubview:webView];
    
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *webViewL = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:webView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *webViewR = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:webView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *webViewT = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:webView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *webViewB = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:webView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self .view addConstraints:@[webViewL,webViewR,webViewT,webViewB]];
    self.webView = webView;
}

#pragma mark - Config authView Style

- (void)_setupNavigationBar
{
    SSDKAuthViewManager *manager = [SSDKAuthViewManager defaultManager];
    self.navigationController.navigationBar.backgroundColor = manager.navigationBarBackgroundColor;
    self.navigationController.navigationBar.tintColor = manager.navigationBarBackgroundColor;
    if ([MOBFDevice versionCompare:@"7.0"] >= 0)
    {
        self.navigationController.navigationBar.barTintColor = manager.navigationBarBackgroundColor;
    }
    else
    {
        //iOS7之前的版本，修改状态栏
        [UIApplication sharedApplication].statusBarStyle = manager.statusBarStyle;
    }
    
    if (manager.navigationBarBackgroundImage)
    {
        [self.navigationController.navigationBar setBackgroundImage:manager.navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (manager.titleColor)
    {
        titleLabel.textColor = manager.titleColor;
    }
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = manager.title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    //取消按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:manager.cancelButtonTitle forState:UIControlStateNormal];
    if (manager.cancelButtonTitleColor)
    {
        [button setTitleColor:manager.cancelButtonTitleColor forState:UIControlStateNormal];
    }
    if (manager.cancelButtonImage)
    {
        [button setImage:manager.cancelButtonImage forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(_cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    CGRect buttonFrame = button.frame;
    if (buttonFrame.size.width < 40)
    {
        buttonFrame.size.width = 40.0;
    }
    if (buttonFrame.size.height < 35)
    {
        buttonFrame.size.height = 35.0;
    }
    button.frame = buttonFrame;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([MOBFDevice versionCompare:@"7.0"] != NSOrderedAscending)
    {
        spaceItem.width = -10;
    }
    
    spaceItem.width += manager.cancelButtonLeftMargin;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem, [[UIBarButtonItem alloc] initWithCustomView:button]];
    
    //右边按钮
    if (manager.rightButton)
    {
        UIBarButtonItem *righButtonSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        if ([MOBFDevice versionCompare:@"7.0"] != NSOrderedAscending)
        {
            righButtonSpaceItem.width = -10;
        }
        
        righButtonSpaceItem.width += manager.rightButtonRightMargin;
        
        self.navigationItem.rightBarButtonItems = @[righButtonSpaceItem, [[UIBarButtonItem alloc] initWithCustomView:manager.rightButton]];
    }
}

- (void)_cancelButtonClick:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [[SSDKAuthViewManager defaultManager] hiddenAuthWindowForViewController:weakSelf];
    }];
    
    [[MOBFJSContext defaultContext] callJSMethod:_callback arguments:@[@{@"state":@(SSDKResponseStateCancel)}]];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([SSDKAuthViewManager defaultManager].toInterfaceOrientation)
    {
        return [SSDKAuthViewManager defaultManager].toInterfaceOrientation;
    }
    
    return UIInterfaceOrientationMaskAll;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [SSDKAuthViewManager defaultManager].statusBarStyle;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    DebugLog(@"AuthView start request:%@",navigationAction.request.URL);
    
    if ([navigationAction.request.URL.absoluteString rangeOfString:self.redirectUrl?:@"" options:NSCaseInsensitiveSearch].location == 0)
    {
        NSDictionary *urlInfo = @{@"state":@(SSDKResponseStateSuccess), @"url":navigationAction.request.URL.absoluteString};
        [[MOBFJSContext defaultContext] callJSMethod:_callback arguments:@[urlInfo]];
        decisionHandler(WKNavigationActionPolicyCancel);
        
        __weak typeof(self) weakSelf = self;
        [self dismissViewControllerAnimated:YES completion:^{
            [[SSDKAuthViewManager defaultManager] hiddenAuthWindowForViewController:weakSelf];
        }];
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)dealloc
{
    DebugLog(@"delloc");
}

@end
