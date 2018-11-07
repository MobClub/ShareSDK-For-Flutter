//
//  SSDKNavigationController.m
//  ShareSDK
//
//  Created by Max on 2018/9/17.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKNavigationController.h"

@interface SSDKNavigationController ()

@end

@implementation SSDKNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.viewControllers.count > 0)
    {
        return [self.viewControllers.lastObject preferredStatusBarStyle];
    }
    
    return [super preferredStatusBarStyle];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.viewControllers.count > 0)
    {
        return [self.viewControllers.lastObject supportedInterfaceOrientations];
    }
    
    return [super supportedInterfaceOrientations];
}

@end
