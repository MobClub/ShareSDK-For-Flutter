//
//  SSDKShareSession.m
//  ShareSDK
//
//  Created by Max on 2018/6/5.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKShareSession.h"
#import "SSDKContentEntity.h"

@interface SSDKShareSession()
{
    NSMutableDictionary *_userData;
    SSDKContentEntity *_contentEntity;
}

@end

@implementation SSDKShareSession

- (NSMutableDictionary *)userData
{
    if (!_userData)
    {
        if (_params[@"@flag"])
        {
            _userData = @{@"@flag":_params[@"@flag"]}.mutableCopy;
        }
        else
        {
            _userData = [NSMutableDictionary dictionary];
        }
    }
    return _userData;
}

- (SSDKContentEntity *)contentEntity
{
    if (!_contentEntity)
    {
        _contentEntity = [[SSDKContentEntity alloc] init];
    }
    return _contentEntity;
}

- (void)cancel
{
    if (self.stateChangedHandler)
    {
        self.stateChangedHandler(SSDKResponseStateCancel, nil);
    }
    
    [super cancel];
}

@end
