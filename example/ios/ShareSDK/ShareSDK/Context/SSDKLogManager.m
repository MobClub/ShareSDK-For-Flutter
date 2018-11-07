//
//  SSDKLogService.m
//  ShareSDK
//
//  Created by Max on 2018/5/11.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKLogManager.h"
#import "SSDKLog.h"
#import "SSDKDataService.h"
#import "SSDKService.h"

@interface SSDKLogManager()<MOBFLogServiceDelegate>

@property (assign, nonatomic) NSTimeInterval lastSendRunLogTime;

@end

@implementation SSDKLogManager

+ (instancetype)defaultManager
{
    static SSDKLogManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SSDKLogManager alloc] init];
    });
    
    return singleton;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _logQueue = dispatch_queue_create("ssdkLogQueue", DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(0);
        _service = [[MOBFLogService alloc] initWithName:@"ShareSDK"];
        _service.failRetryMaxCount = 3;
        _service.delegate = self;
        _lastSendRunLogTime = [[SSDKDataService shareService] lastSendRunLogTime];
    }
    return self;
}

- (void)unlockSend
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_semaphore_signal(_semaphore);
    });
}

- (void)sendRunLog
{
    [self _prepareSendLog:^{
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeRun];
        [log getContent:^(NSString *content) {
            if (content)
            {
                BOOL needDelay = self._needDelay;
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:(needDelay?SendLogDelay:0)];
                if (!needDelay)
                {
                    [[SSDKDataService shareService] cacheSendRunLogTime];
                }
            }
        }];
    }];
}

- (void)sendExitLog
{
    [self _prepareSendLog:^{
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeExist];
        [log getContent:^(NSString *content) {
            if (content)
            {
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:SendLogDelay];
            }
        }];
    }];
}

- (void)sendAuthLog:(SSDKUser *)user
{
    [self _prepareSendLog:^{
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeAuth];
        log.user = user;
        [log getContent:^(NSString *content) {
            if (content)
            {
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:SendLogDelay];
            }
        }];
    }];
}

- (void)sendShareLog:(SSDKPlatformType)platformType
       contentEntity:(SSDKContentEntity *)contentEntity
                user:(SSDKUser *)user
              target:(NSString *)target
{
    [self _prepareSendLog:^{
        
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeShare];
        log.platformType = platformType;
        log.contentEntity = contentEntity;
        log.target = target;
        log.user = user;
        [log getContent:^(NSString *content) {
            if (content)
            {
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:SendLogDelay];
            }
        }];
    }];
}

- (void)recordShareEventWithPlatform:(SSDKPlatformType)platformType eventType:(SSDKShareEventType)eventType
{
    [self _prepareSendLog:^{
        
        NSString *eventString = nil;
        switch (eventType)
        {
            case SSDKShareEventTypeOpenMenu:
                eventString = @"SHARESDK_ENTER_SHAREMENU";
                break;
            case SSDKShareEventTypeCloseMenu:
                eventString = @"SHARESDK_CANCEL_SHAREMENU";
                break;
            case SSDKShareEventTypeFailed:
                eventString = @"SHARESDK_FAILED_SHARE";
                break;
            case SSDKShareEventTypeCancel:
                eventString = @"SHARESDK_CANCEL_SHARE";
                break;
            default:
                eventString = @"SHARESDK_EDIT_SHARE";
                break;
        }
        
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeEvent];
        log.eventId = eventString;
        log.eventTarget = [NSString stringWithFormat:@"%lu",(unsigned long)platformType];
        log.eventParams = nil;
        [log getContent:^(NSString *content) {
            if (content)
            {
                DebugLog(@"%@",content);
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:SendLogDelay];
            }
        }];
    }];
}

- (void)sendApiLog:(SSDKPlatformType)platformType
               api:(NSString *)api
{
    [self _prepareSendLog:^{
        
        SSDKLog *log = [SSDKLog logWithType:SSDKLogTypeApi];
        log.api = api;
        log.platformType = platformType;
        [log getContent:^(NSString *content) {
            if (content)
            {
                [self.service syncWriteData:content];
                [self.service needsSendLogAfterTime:SendLogDelay];
            }
        }];
    }];
}

- (void)getShortUrls:(NSArray *)urls
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
              result:(void(^)(NSArray *shortUrls, NSError *error))result
{
    dispatch_async(_logQueue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        __block BOOL statDeviceOn = NO;
        __block BOOL statAuthOn = NO;
        
        [MobSDK waitForLogAuth:^{
            statAuthOn = self.statAuthOn;
            statDeviceOn = self.statDeviceOn;
        }];
        
        [[SSDKService sharedService] getShortUrls:urls
                                           appkey:self.appkey
                                             duid:self.duid
                                     statDeviceOn:statDeviceOn
                                       statAuthOn:statAuthOn
                                             user:user
                                     platformType:platformType
                                         onResult:result];
        
        dispatch_semaphore_signal(_semaphore);
    });
}

#pragma mark - MOBFLogServiceDelegate

- (void)logService:(MOBFLogService *)logService didSendLogs:(NSArray *)logs result:(void (^)(BOOL, NSArray *))result
{
    dispatch_async(_logQueue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        [[SSDKService sharedService] sendLogs:logs appkey:self.appkey onResult:^(NSError *error) {
            
            BOOL isSuccess = error ? NO:YES;
            NSArray *sendedLogs = isSuccess ? logs:nil;
            if (result) {
                result(isSuccess,sendedLogs);
            }
        }];
        dispatch_semaphore_signal(_semaphore);
    });
}

- (BOOL)logService:(MOBFLogService *)logService needsSendLogs:(NSArray *)logs
{
    return YES;
}

#pragma mark - Privite

//检测是否为同一天日志, 同一天延时2s
- (BOOL)_needDelay
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.lastSendRunLogTime];
    return [[MOBFDate stringByDate:date withFormat:@"yyyy-MM-dd"] isEqualToString:[MOBFDate stringByDate:[NSDate date] withFormat:@"yyyy-MM-dd"]];
}

- (void)_prepareSendLog:(void(^)(void))operation
{
    [MobSDK waitForLogAuth:^{
        operation();
    }];
}

@end
