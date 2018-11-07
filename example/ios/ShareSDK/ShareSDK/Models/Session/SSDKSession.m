//
//  SSDKSession.m
//  ShareSDK
//
//  Created by Max on 2018/7/27.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKSession.h"

@implementation SSDKSession

- (void) cancel
{
    _isCancelled = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:SSDKDidCancelSessionNotificationKey object:self];
}

@end
