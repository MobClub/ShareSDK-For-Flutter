//
//  SSDKAuthorizeCredential.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/6.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKCredential.h"

@implementation SSDKCredential

@dynamic authCode;
@dynamic uid;
@dynamic token;
@dynamic secret;
@dynamic expired;
@dynamic type;
@dynamic rawData;
@dynamic available;

- (BOOL)available
{
    switch (self.type)
    {
        case SSDKCredentialTypeOAuth1x:
        {
            return (self.uid && self.token && self.secret);
        }
        case SSDKCredentialTypeOAuth2:
        {
            NSString *uid = self.uid;
            NSString *token = self.token;
            NSTimeInterval timeLeft = [[NSDate dateWithTimeIntervalSince1970:self.expired/1000.0] timeIntervalSinceNow];
            return (uid.length && token.length && timeLeft > 0);
        }
        case SSDKCredentialTypeSMS:
        {
            return YES;
        }
        default:
            return NO;
    }
}

@end
