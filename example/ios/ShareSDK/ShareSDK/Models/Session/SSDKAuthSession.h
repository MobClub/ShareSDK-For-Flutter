//
//  SSDKAuthSession.h
//  ShareSDK
//
//  Created by Max on 2018/6/5.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <ShareSDK/SSDKSession.h>

@interface SSDKAuthSession : SSDKSession

@property (copy, nonatomic) SSDKAuthorizeStateChangedHandler stateChangedHandler;
@property (strong, nonatomic) NSMutableDictionary *settings;
@property (strong, nonatomic) SSDKUserQueryCondition *userQueryCondition;

@end
