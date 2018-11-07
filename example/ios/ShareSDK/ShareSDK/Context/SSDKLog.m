//
//  SSDKLog.m
//  ShareSDK
//
//  Created by Max on 2018/5/11.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "SSDKLog.h"
#import "SSDKLogManager.h"
#import "SSDKContentEntity.h"
#import "SSDKService.h"

@implementation SSDKLog

+ (instancetype)logWithType:(SSDKLogType)type
{
    switch (type)
    {
        case SSDKLogTypeRun:
            return [self _runLog];
            
        case SSDKLogTypeExist:
            return [self _existLog];
            
        case SSDKLogTypeShare:
            return [self _shareLog];
            
        case SSDKLogTypeEvent:
            return [self _eventLog];
            
        case SSDKLogTypeApi:
            return [self _apiLog];
            
        case SSDKLogTypeAuth:
            return [self _authLog];
            
        default:
            return nil;
    }
}

+ (instancetype)_runLog
{
    static NSInteger MaxCountPerTimeCycle = 5;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }

    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeRun;
    log.typeSign = @"RUN";
    
    return log;
}

+ (instancetype)_existLog
{
    static NSInteger MaxCountPerTimeCycle = 5;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }
    
    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeExist;
    log.typeSign = @"EXT";
    
    return log;
}

+ (instancetype)_shareLog
{
    static NSInteger MaxCountPerTimeCycle = 30;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }
    
    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeShare;
    log.typeSign = @"SHR";
    
    return log;
}

+ (instancetype)_authLog
{
    static NSInteger MaxCountPerTimeCycle = 5;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }
    
    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeAuth;
    log.typeSign = @"AUT";
    
    return log;
}

+ (instancetype)_eventLog
{
    static NSInteger MaxCountPerTimeCycle = 30;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }
    
    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeEvent;
    log.typeSign = @"EVT";
    
    return log;
}

+ (instancetype)_apiLog
{
    static NSInteger MaxCountPerTimeCycle = 50;
    static NSTimeInterval TimeCycle = 5.0;
    static NSInteger _curCountPerTimeCycle = 0.0;
    static NSTimeInterval _startTime = 0.0;
    
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    if (curTimestamp - _startTime > TimeCycle)
    {
        _startTime = 0.0;
        _curCountPerTimeCycle = 0;
    }
    
    _startTime = curTimestamp;
    _curCountPerTimeCycle ++;
    if (_curCountPerTimeCycle > MaxCountPerTimeCycle)
    {
        return nil;
    }
    
    SSDKLog *log = [[SSDKLog alloc] init];
    log.type = SSDKLogTypeApi;
    log.typeSign = @"API";
    
    return log;
}
- (void)getContent:(void(^)(NSString *))result
{
    if (![SSDKLogManager defaultManager].appkey.length)
    {
        if (result)
        {
            result(nil);
        }
        return;
    }
    
    NSString *network = [[SSDKHelper shareHelper] currentNetworkType];
    
    NSString *content =  [NSString stringWithFormat:
                          @"[%@]:%.0f|%@|%@|%@|%@|%@|%d|%@",
                          self.typeSign,
                          ([[NSDate date] timeIntervalSince1970] + [SSDKLogManager defaultManager].timestamp) * 1000,
                          [SSDKLogManager defaultManager].duid,
                          [SSDKLogManager defaultManager].appkey,
                          [MOBFApplication bundleId],
                          [MOBFApplication buildVersion],
                          [NSString stringWithFormat:@"%ld", (long)[SSDKHelper shareHelper].versionNumber],
                          (int)SSDKPlatform,
                          network];
    
    [self _handleContent:content result:result];
}

- (void)_handleContent:(NSString *)content result:(void(^)(NSString *))result
{
    if (content)
    {
        switch (self.type) {
                
            case SSDKLogTypeRun:
            {
                NSString *deviceDataStr = [self _encryptDeviceString];
                NSString *newContent = [NSString stringWithFormat:@"%@|%@", content, (deviceDataStr ? deviceDataStr : @"")];
                if (result)
                {
                    result(newContent);
                }
            }
                break;
                
            case SSDKLogTypeExist:
            {
                NSString *deviceDataStr = [self _encryptDeviceString];
                NSString *newContent = [NSString stringWithFormat:@"%@|%@|%.0f", content, (deviceDataStr ? deviceDataStr : @""), [SSDKHelper shareHelper].runDuration];
                if (result)
                {
                    result(newContent);
                }
            }
                break;
                
            case SSDKLogTypeShare:
            {
                SSDKLogManager *manager = [SSDKLogManager defaultManager];
                NSString *deviceDataString = [self _encryptDeviceString];
                NSString *userInfoString = nil;
                if (manager.statAuthOn && self.user)
                {
                    NSString *birthdayStr = nil;
                    if (self.user.birthday)
                    {
                        birthdayStr = [NSString stringWithFormat:@"%.0f", [self.user.birthday timeIntervalSince1970] * 1000];
                    }
                    
                    if (self.user.credential)
                    {
                        //统计用户信息
                        userInfoString = [NSString stringWithFormat:
                                          @"%ld|%@|%ld|%@|%@",
                                          (long)self.user.gender,
                                          (birthdayStr ? birthdayStr : @""),
                                          (long)self.user.verifyType,
                                          (self.user.educations ? [MOBFJson jsonStringFromObject:self.user.educations] : @""),
                                          (self.user.works ? [MOBFJson jsonStringFromObject:self.user.works] : @"")];
                        
                    }
                    else
                    {
                        
                        //统计用户信息
                        userInfoString = [NSString stringWithFormat:
                                          @"|%@||%@|%@",
                                          (birthdayStr ? birthdayStr : @""),
                                          (self.user.educations ? [MOBFJson jsonStringFromObject:self.user.educations] : @""),
                                          (self.user.works ? [MOBFJson jsonStringFromObject:self.user.works] : @"")];
                        
                    }
                    
                    userInfoString = [self _encryptData:[userInfoString dataUsingEncoding:NSUTF8StringEncoding]];
                }
                
                //进行平台编号转换参数
                
                SSDKPlatformType platformType = (self.platformType==SSDKPlatformTypeEvernote ? SSDKPlatformTypeYinXiang:self.platformType);
                
                if (manager.statShareOn && self.contentEntity)
                {
                    //统计分享信息
                    [self _convertContentEntityToDictionary:^(NSDictionary *dictionaryValue) {
                        
                        NSString *shareString = [MOBFJson jsonStringFromObject:dictionaryValue];
                        shareString = [self _encryptData:[shareString dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        NSString *newContent = [NSString stringWithFormat:
                                                @"%@|%lu|%@|%@|%@|%@|%@|%@",
                                                content,
                                                (unsigned long)platformType,
                                                (self.user.uid ? self.user.uid : @""),
                                                (self.contentEntity.cid ? self.contentEntity.cid : @""),
                                                (self.target ? self.target : @""),
                                                (shareString ? shareString : @""),
                                                (deviceDataString ? deviceDataString : @""),
                                                (userInfoString ? userInfoString : @"")];
                        if (result)
                        {
                            result(newContent);
                        }
                    }];
                }
                else
                {
                    NSString *newContent = [NSString stringWithFormat:
                                            @"%@|%lu|%@|%@|%@|%@|%@|%@",
                                            content,
                                            (unsigned long)platformType,
                                            (self.user.uid ? self.user.uid : @""),
                                            (self.contentEntity.cid ? self.contentEntity.cid : @""),
                                            (self.target ? self.target : @""),
                                            @"",
                                            (deviceDataString ? deviceDataString : @""),
                                            (userInfoString ? userInfoString : @"")];
                    if (result)
                    {
                        result(newContent);
                    }
                }
            }
                break;
                
            case SSDKLogTypeAuth:
            {
                NSString *userInfoString = nil;
                NSString *rawUserInfoString = nil;
                NSString *deviceDataString = [self _encryptDeviceString];
                
                SSDKLogManager *manager = [SSDKLogManager defaultManager];
                if (manager.statAuthOn)
                {
                    //构造用户信息字符串
                    NSString *eduJsonString = nil;
                    NSString *workJsonString = nil;
                    NSString *birthdayStr = nil;
                    
                    if (self.user.educations)
                    {
                        eduJsonString = [MOBFJson jsonStringFromObject:self.user.educations];
                    }
                    else
                    {
                        eduJsonString = @"";
                    }
                    
                    if (self.user.works)
                    {
                        workJsonString = [MOBFJson jsonStringFromObject:self.user.works];
                    }
                    else
                    {
                        workJsonString = @"";
                    }
                    
                    if (self.user.birthday)
                    {
                        birthdayStr = [NSString stringWithFormat:@"%.0f", [self.user.birthday timeIntervalSince1970] * 1000];
                    }
                    
                    
                    userInfoString = [NSString stringWithFormat:
                                      @"%@|%@|%ld|%@|%@|%ld|%@|%@|%ld|%ld|%ld|%@|%ld|%@|%@",
                                      (self.user.nickname ? [MOBFString urlEncodeString:self.user.nickname forEncoding:NSUTF8StringEncoding] : @""),
                                      (self.user.icon ? [MOBFString urlEncodeString:self.user.icon forEncoding:NSUTF8StringEncoding] : @""),
                                      (long)self.user.gender,
                                      (self.user.url ? [MOBFString urlEncodeString:self.user.url forEncoding:NSUTF8StringEncoding] : @""),
                                      (self.user.aboutMe ? [MOBFString urlEncodeString:self.user.aboutMe forEncoding:NSUTF8StringEncoding] : @""),
                                      (long)self.user.verifyType,
                                      (self.user.verifyReason ? [MOBFString urlEncodeString:self.user.verifyReason forEncoding:NSUTF8StringEncoding] : @""),
                                      (birthdayStr ? birthdayStr : @""),
                                      (long)self.user.followerCount,
                                      (long)self.user.friendCount,
                                      (long)self.user.shareCount,
                                      (self.user.regAt > 0 ? [NSString stringWithFormat:@"%.0f", self.user.regAt * 1000] : @""),
                                      (long)self.user.level,
                                      eduJsonString,
                                      workJsonString];
                    
                    userInfoString = [self _encryptData:[userInfoString dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //构造原始的用户信息
                    if (self.user.dictionaryValue.count > 0)
                    {
                        NSData *rawUserInfoData = [MOBFJson jsonDataFromObject:self.user.dictionaryValue];
                        rawUserInfoString = [self _encryptData:rawUserInfoData];
                    }
                }
                
                //判断平台如果为微信或者QQ，则需要进行平台编号转换
                SSDKPlatformType platformType = self.user.platformType;
                switch (platformType)
                {
                    case SSDKPlatformTypeWechat:
                        platformType = SSDKPlatformSubTypeWechatSession;
                        break;
                    case SSDKPlatformTypeQQ:
                        platformType = SSDKPlatformSubTypeQZone;
                        break;
                    case SSDKPlatformTypeEvernote:
                        //统一写入印象笔记平台中
                        platformType = SSDKPlatformTypeYinXiang;
                        break;
                    case SSDKPlatformTypeKakao:
                        //统一写入KaKao Talk平台中
                        platformType = SSDKPlatformSubTypeKakaoTalk;
                        break;
                    case SSDKPlatformTypeYiXin:
                        //默认为易信好友
                        platformType = SSDKPlatformSubTypeYiXinSession;
                        break;
                    default:
                        break;
                }
                
                NSString *newContent =  [NSString stringWithFormat:
                                         @"%@|%lu|%@|%@|%@|%@",
                                         content,
                                         (unsigned long)platformType,
                                         (self.user.uid ? self.user.uid : @""),
                                         (userInfoString ? userInfoString : @""),
                                         (deviceDataString ? deviceDataString : @""),
                                         (rawUserInfoString ? rawUserInfoString : @"")];
                if (result)
                {
                    result(newContent);
                }
            }
                break;
                
            case SSDKLogTypeEvent:
            {
                NSString *newContent = [NSString stringWithFormat:
                                        @"%@|%@|%@|%@",
                                        content,
                                        (self.eventId ? self.eventId : @""),
                                        (self.eventTarget ? self.eventTarget : @""),
                                        (self.eventParams ? self.eventParams : @"")];
                if (result)
                {
                    result(newContent);
                }
            }
                break;
                
            case SSDKLogTypeApi:
            {
                //进行平台编号转换
                SSDKPlatformType platformType = (self.platformType==SSDKPlatformTypeEvernote ? SSDKPlatformTypeYinXiang:self.platformType);
                NSString *newContent = [NSString stringWithFormat:@"%@|%d|%@", content, (int)platformType, self.api];
                if (result)
                {
                    result(newContent);
                }
            }
                break;
                
            default:
                if (result)
                {
                    result(nil);
                }
                break;
        }
    }
}


#pragma mark - Private

- (NSString *)_encryptDeviceString
{
    if ([SSDKLogManager defaultManager].statDeviceOn)
    {
        //获取运营商
        NSString *carrierStr = [MOBFDevice carrier];
        carrierStr = [carrierStr isEqualToString:@""] ? @"-1" : carrierStr;
        
        NSString *deviceRawData = [NSString stringWithFormat:
                                   @"%@|%@|%@|%@|%@",
                                   [MOBFDevice deviceModel],
                                   [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion],
                                   SSDKFactory,
                                   carrierStr,
                                   [[SSDKHelper shareHelper] screenResolution]];
        
        //进行加密
        return [self _encryptData:[deviceRawData dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return nil;
}

- (NSString *)_encryptData:(NSData *)data
{
    if (data)
    {
        NSString *aesKey = [[SSDKLogManager defaultManager].duid substringToIndex:16];
        data = [MOBFData aes128EncryptData:data
                                       key:aesKey
                                  encoding:NSUTF8StringEncoding];
        
        return [MOBFData stringByBase64EncodeData:data];
    }
    
    return nil;
}

/**
 *  转换内容实体为字典值
 *
 *  @param block 返回回调
 */
- (void)_convertContentEntityToDictionary:(void(^)(NSDictionary *dictionaryValue))block
{
    [self _convertContentEntityImages:^(NSArray *imageList) {
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        if (self.contentEntity.text)
        {
            [dictionary setObject:self.contentEntity.text forKey:@"text"];
        }
        if (imageList)
        {
            [dictionary setObject:imageList forKey:@"imgs"];
        }
        if (self.contentEntity.urls)
        {
            //转换成字符串
            NSMutableArray *urls = [NSMutableArray array];
            for (int i = 0; i < self.contentEntity.urls.count; i++)
            {
                id url = self.contentEntity.urls [i];
                if ([url isKindOfClass:[NSString class]])
                {
                    [urls addObject:url];
                }
            }
            
            [dictionary setObject:urls forKey:@"url"];
        }
        if (self.contentEntity.rawData)
        {
            [dictionary setObject:self.contentEntity.rawData forKey:@"attch"];
        }
        
        if (block)
        {
            block (dictionary);
        }
    }];
}

/**
 *  转换实体图片列表
 *
 *  @param block 返回回调
 */
- (void)_convertContentEntityImages:(void(^)(NSArray *imageList))block
{
    if (self.contentEntity.images.count > 0)
    {
        __block NSInteger curCount = 0;
        __weak typeof(self) weakSelf = self;
        
        NSMutableArray *imageListArr = [NSMutableArray array];
        for (int i = 0; i < self.contentEntity.images.count; i++)
        {
            id image = self.contentEntity.images[i];
            if ([image isKindOfClass:[NSString class]])
            {
                [self _convertContentEntityImage:image result:^(NSString *imageUrl) {
                    
                    if (imageUrl)
                    {
                        [imageListArr addObject:imageUrl];
                    }
                    curCount ++;
                    
                    if (curCount == weakSelf.contentEntity.images.count)
                    {
                        //转换数量相同则返回
                        if (block)
                        {
                            block (imageListArr);
                        }
                    }
                }];
            }
            else
            {
                curCount ++;
                if (curCount == weakSelf.contentEntity.images.count)
                {
                    //转换数量相同则返回
                    if (block)
                    {
                        block (imageListArr);
                    }
                }
            }
        }
    }
    else
    {
        if (block)
        {
            block (nil);
        }
    }
}

- (void)_convertContentEntityImage:(NSString *)image result:(void(^)(NSString *imageUrl))resultHandler
{
    if ([MOBFRegex isMatchedByRegex:@"^(file\\:/)?/" options:MOBFRegexOptionsCaseless inRange:NSMakeRange(0, image.length) withString:image])
    {
        [[SSDKService sharedService] uploadSharedImage:image appkey:[SSDKLogManager defaultManager].appkey onResult:^(NSString *imageUrl, NSError *error) {
            if (resultHandler)
            {
                resultHandler (imageUrl);
            }
        }];
    }
    else
    {
        if (resultHandler)
        {
            resultHandler (image);
        }
    }
}
@end
