//
//  SSDKAuthSession.m
//  ShareSDK
//
//  Created by Max on 2018/6/5.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKAuthSession.h"

@implementation SSDKAuthSession

- (void)cancel
{
    if (self.stateChangedHandler)
    {
        self.stateChangedHandler(SSDKResponseStateCancel, nil, nil);
    }
    
    [super cancel];
}

@end
