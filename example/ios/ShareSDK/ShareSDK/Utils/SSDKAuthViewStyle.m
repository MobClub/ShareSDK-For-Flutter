//
//  SSDKAuthViewStyle.m
//  ShareSDK
//
//  Created by fenghj on 15/4/13.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKAuthViewStyle.h"
#import "SSDKAuthViewManager.h"

@implementation SSDKAuthViewStyle

#pragma mark - Public

+ (void)setNavigationBarBackgroundImage:(UIImage *)image
{
    [SSDKAuthViewManager defaultManager].navigationBarBackgroundImage = image;
}

+ (void)setNavigationBarBackgroundColor:(UIColor *)color
{
    [SSDKAuthViewManager defaultManager].navigationBarBackgroundColor = color;
}

+ (void)setTitle:(NSString *)title
{
    [SSDKAuthViewManager defaultManager].title = title;
}

+ (void)setTitleColor:(UIColor *)color
{
    [SSDKAuthViewManager defaultManager].titleColor = color;
}

+ (void)setCancelButtonLabel:(NSString *)label
{
    [SSDKAuthViewManager defaultManager].cancelButtonTitle = label;
}

+ (void)setCancelButtonLabelColor:(UIColor *)color
{
    [SSDKAuthViewManager defaultManager].cancelButtonTitleColor = color;
}

+ (void)setCancelButtonImage:(UIImage *)image
{
    [SSDKAuthViewManager defaultManager].cancelButtonImage = image;
}

+ (void)setCancelButtonLeftMargin:(CGFloat)margin
{
    [SSDKAuthViewManager defaultManager].cancelButtonLeftMargin = margin;
}

+ (void)setRightButton:(UIButton *)button
{
    [SSDKAuthViewManager defaultManager].rightButton = button;
}

+ (void)setRightButtonRightMargin:(CGFloat)margin
{
    [SSDKAuthViewManager defaultManager].rightButtonRightMargin = margin;
}

+(void)setSupportedInterfaceOrientation:(UIInterfaceOrientationMask)toInterfaceOrientation
{
    [SSDKAuthViewManager defaultManager].toInterfaceOrientation = toInterfaceOrientation;
}

+ (void)setStatusBarStyle:(UIStatusBarStyle)style
{
    [SSDKAuthViewManager defaultManager].statusBarStyle = style;
}

@end
