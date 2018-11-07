//
//  SSDKShareSession.h
//  ShareSDK
//
//  Created by Max on 2018/6/5.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import <ShareSDK/SSDKSession.h>

typedef void(^SSDKShareSessionStateChangedHandler)(SSDKResponseState state, NSError *error);

@interface SSDKShareSession : SSDKSession

@property (strong, nonatomic) NSMutableDictionary *params;
@property (nonatomic, copy) SSDKShareSessionStateChangedHandler stateChangedHandler;

@property (strong, nonatomic, readonly) SSDKContentEntity *contentEntity;
@property (strong, nonatomic, readonly) NSMutableDictionary *userData;

@end
