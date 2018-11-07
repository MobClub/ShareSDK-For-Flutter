//
//  SSDKAuthViewController.h
//  ShareSDK
//
//  Created by Max on 2018/5/30.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDKAuthViewController : UIViewController

@property (weak, nonatomic) UIWindow *window;

@property (assign, nonatomic) SSDKPlatformType platformType;
@property (copy, nonatomic) NSString *url;
@property (nonatomic, copy) NSString *callback;
@property (nonatomic, copy) NSString *redirectUrl;

@end
