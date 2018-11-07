//
//  SSDKService.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/10.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKService.h"
#import "SSDKDataService.h"
#import "SSDKError.h"
#import <MOBFoundation/MOBFApiService.h>

/**
 *  错误域
 */
static NSString *const ErrorDomain      = @"ShareSDKErrorDomain";

/**
 *  图片服务器基础路径
 */
static NSString *const kBaseImageUrl    = @"up.mob.com";

/**
 *  转换短链服务路径
 */
static NSString *const kShortConvertUrl = @"l.mob.com";

/**
 *  服务基础路径
 */
static NSString *const kBaseUrl         = @"api.share.mob.com";

/**
 *  密钥
 */
static NSString *const AESKey           = @"sdk.sharesdk.sdk";


@interface SSDKService ()

/**
 *  服务器路径信息
 */
@property (nonatomic, strong) NSDictionary *serverPaths;

@property (nonatomic) BOOL enabledATS;

@end

@implementation SSDKService

- (void)getAppConfigWithAppkey:(NSString *)appkey
                          duid:(NSString *)duid
                        result:(void(^)(BOOL statDeviceOn, BOOL statShareOn, BOOL statAuthOn, BOOL backflowOn, NSTimeInterval timestamp, NSError *error))result

{
    //读取本地
    NSDictionary *config = [SSDKDataService shareService].appConfig;
    
    if (config)
    {
        [self _installAppConfigWithResponder:config result:result];
    }
    //服务器更新
    __weak typeof(self) weakSelf = self;
    [self getServerConnectPermissionWithAppkey:appkey result:^(BOOL allow, NSError *error) {
        
        if (allow)
        {
            NSString *url = [weakSelf _urlStringWithBaseURL:kBaseUrl paths:@"conf5"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:[NSString stringWithFormat:@"%ld", (long)SSDKPlatform] forKey:@"plat"];
            
            params[@"apppkg"] = [MOBFApplication bundleId];
            params[@"appver"] = [MOBFApplication buildVersion];
            params[@"sdkver"] = [NSString stringWithFormat:@"%ld", (long)[SSDKHelper shareHelper].versionNumber];
            params[@"appkey"] = appkey;
            params[@"device"] = duid;
            params[@"networktype"] = [SSDKHelper shareHelper].currentNetworkType;

            [MOBFHttpService sendHttpRequestByURLString:url
                                                 method:kMOBFHttpMethodPost
                                             parameters:params
                                                headers:@{@"duid":[MOBFDevice duid]}
                                               onResult:^(NSHTTPURLResponse *response, NSData *responseData) {
                                                   
                                                   [weakSelf _parseResponse:response data:responseData block:^(NSDictionary *responder, NSError *error) {
                                                       
                                                       if (error)
                                                       {
                                                           if (result)
                                                           {
                                                               result (YES, YES, YES, NO, 0.0, error);
                                                           }
                                                       }
                                                       else
                                                       {
                                                           [[SSDKDataService shareService] cacheAppConfig:responder];
                                                           [weakSelf _installAppConfigWithResponder:responder result:result];
                                                       }
                                                   }];
                                                   
                                               }
                                                onFault:^(NSError *error) {
                                                    
                                                    if (result)
                                                    {
                                                        result (YES, YES, YES, NO, 0.0, error);
                                                    }
                                                    
                                                }
                                       onUploadProgress:nil];
        }
        else
        {
            if (result)
            {
                result (NO, NO, NO, NO, 0.0, [SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
            }
        }
    }];
}

- (void)_installAppConfigWithResponder:(NSDictionary *)responder
                                result:(void(^)(BOOL statDeviceOn, BOOL statShareOn, BOOL statAuthOn, BOOL backflowOn, NSTimeInterval timestamp, NSError *error))result
{
    BOOL statDeviceOn = YES;
    BOOL statShareOn = YES;
    BOOL statAuthOn = YES;
    BOOL backflowOn = NO;
    
    NSTimeInterval timestamp = 0.0;
    
    self.serverPaths = responder [@"serpaths"];
    
    id value = [responder objectForKey:@"switchs"];
    if ([value isKindOfClass:[NSDictionary class]])
    {
        id item = [value objectForKey:@"device"];
        if ([item isKindOfClass:[NSNumber class]])
        {
            statDeviceOn = [item boolValue];
        }
        
        item = [value objectForKey:@"share"];
        if ([item isKindOfClass:[NSNumber class]])
        {
            statShareOn = [item boolValue];
        }
        
        item = [value objectForKey:@"auth"];
        if ([item isKindOfClass:[NSNumber class]])
        {
            statAuthOn = [item boolValue];
        }
        
        item = [value objectForKey:@"backflow"];
        if ([item isKindOfClass:[NSNumber class]])
        {
            backflowOn = [item boolValue];
        }
    }
    
    value = [responder objectForKey:@"timestamp"];
    if ([value isKindOfClass:[NSNumber class]])
    {
        timestamp = [value doubleValue] / 1000;
    }
    
    
    if (result)
    {
        result (statDeviceOn, statShareOn, statAuthOn, backflowOn, timestamp, nil);
    }
}

- (void)getPlatformConfigsWithAppkey:(NSString *)appkey duid:(NSString *)duid result:(void(^)(NSArray *configs, NSError *error))result;
{
    NSArray *configs = [[SSDKDataService shareService] platformConfigs];
    
    if (configs && result)
    {
        result(configs,nil);
    }
    
    __weak SSDKService *theService = self;
    
    [self getServerConnectPermissionWithAppkey:appkey result:^(BOOL allow, NSError *error) {
        
        if (allow)
        {
            NSString *url = [theService _urlStringWithBaseURL:kBaseUrl paths:@"snsconf"];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"appkey"] = appkey;
            params[@"device"] = duid;
            
            [MOBFHttpService sendHttpRequestByURLString:url
                                                 method:kMOBFHttpMethodPost
                                             parameters:params
                                                headers:@{@"duid":[MOBFDevice duid]}
                                               onResult:^(NSHTTPURLResponse *response, NSData *responseData) {
                                                   
                                                   [theService _parseResponse:response data:responseData block:^(NSDictionary *responder, NSError *error) {
                                                       
                                                       if (error)
                                                       {
                                                           //错误
                                                           if (result)
                                                           {
                                                               result (nil, error);
                                                           }
                                                       }
                                                       else
                                                       {
                                                           NSArray *settings = nil;
                                                           id res = [responder objectForKey:@"res"];
                                                           if ([res isKindOfClass:[NSString class]])
                                                           {
                                                               NSData *aesKeyData = [MOBFData md5Data:[[NSString stringWithFormat:@"%@:%@",appkey,duid]
                                                                                                       dataUsingEncoding:NSUTF8StringEncoding]];
                                                               
                                                               NSData *aesData = [MOBFString dataByBase64DecodeString:res];
                                                               NSData *data = [MOBFData aes128DecryptData:aesData
                                                                                                      key:aesKeyData
                                                                                                  options:kCCOptionECBMode];
                                                               
                                                               settings = [MOBFJson objectFromJSONData:data];
                                                           }
                                                           
                                                           if ([settings isKindOfClass:[NSArray class]])
                                                           {
                                                               [[SSDKDataService shareService] cachePlatformConfigs:settings];
                                                               if (result)
                                                               {
                                                                   result (settings, nil);
                                                               }
                                                           }
                                                           else
                                                           {
                                                               NSError *errorInfo = [SSDKError requestFailedWithInfo:@{@"InvalidSettings":settings?:[NSNull null]}];
                                                               if (result)
                                                               {
                                                                   result (nil, errorInfo);
                                                               }
                                                           }
                                                       }
                                                   }];
                                                   
                                               }
                                                onFault:^(NSError *error) {
                                                    
                                                    if (result)
                                                    {
                                                        result (nil, error);
                                                    }
                                                    
                                                }
                                       onUploadProgress:nil];
        }
        else
        {
            if (result)
            {
                result (nil, [SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
            }
        }
    }];
}


- (void)uploadSharedImage:(NSString *)filePath
                   appkey:(NSString *)appkey
                 onResult:(void(^)(NSString *imageUrl, NSError *error))resultHandler
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NULL])
    {
        __weak SSDKService *theService = self;
        
        [self getServerConnectPermissionWithAppkey:appkey result:^(BOOL allow, NSError *error) {
            if (allow)
            {
                NSString *url = [theService _urlStringWithBaseURL:kBaseImageUrl paths:@"upload/image"];
                
                MOBFHttpService *httpService = [[MOBFHttpService alloc] initWithURLString:url];
                
                NSData *imageData = [NSData dataWithContentsOfFile:filePath];
                NSString *fileName = [filePath lastPathComponent];
                NSString *mimeType = nil;
                if ([fileName hasSuffix:@".jpg"] || [fileName hasSuffix:@".jpeg"])
                {
                    mimeType = @"image/jpeg";
                }
                else if ([fileName hasSuffix:@".png"])
                {
                    mimeType = @"image/png";
                }
                else if ([fileName hasSuffix:@".gif"])
                {
                    mimeType = @"image/gif";
                }
                
                [httpService addFileParameter:imageData fileName:filePath mimeType:mimeType transferEncoding:nil forKey:@"file"];
                [httpService addHeaders:@{@"duid":[MOBFDevice duid]}];
                [httpService sendRequestOnResult:^(NSHTTPURLResponse *response, NSData *responseData) {
                    
                    [theService _parseResponse:response data:responseData block:^(NSDictionary *responder, NSError *error) {
                        
                        if (!error)
                        {
                            NSString *url = responder [@"url"];
                            if (resultHandler)
                            {
                                resultHandler (url, nil);
                            }
                        }
                        else
                        {
                            if (resultHandler)
                            {
                                resultHandler (nil, error);
                            }
                        }
                        
                    }];
                    
                    
                } onFault:^(NSError *error) {
                    
                    if (resultHandler)
                    {
                        resultHandler (nil, error);
                    }
                    
                } onUploadProgress:nil];
            }
            else
            {
                if (resultHandler)
                {
                    resultHandler (nil, [SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
                }
            }
        }];
    }
    else
    {
        if (resultHandler)
        {
            resultHandler (nil, [SSDKError paramsErrorWithDescription:@"File does not exist"]);
        }
    }
}


- (void)sendLogs:(NSArray *)logs appkey:(NSString *)appkey onResult:(void(^)(NSError *error))resultHandler;
{
    DebugLog(@"SendLogs:%@",logs);
    NSString *reqPath = [self _getServicePath:@"log4"];
    if (reqPath)
    {
        [self getServerConnectPermissionWithAppkey:appkey result:^(BOOL allow, NSError *error) {
            
            if (allow)
            {
                NSString *content = [logs componentsJoinedByString:@"\n"];
                if (logs.count > 2)
                {
                    //使用GZIP压缩
                    content = [MOBFData stringByBase64EncodeData:[MOBFData compressDataUsingGZip:[content dataUsingEncoding:NSUTF8StringEncoding]]];
                }
                
                if(content == nil)
                {
                    content = @"";
                }
                NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                            logs.count > 2 ? @(1) : @(0), @"t",
                                            content, @"m",
                                            nil];
                [MOBFHttpService sendHttpRequestByURLString:reqPath
                                                     method:kMOBFHttpMethodPost
                                                 parameters:paramsDict
                                                    headers:@{@"duid":[MOBFDevice duid]}
                                                   onResult:^(NSHTTPURLResponse *response, NSData *responseData) {
                                                       if(resultHandler)
                                                       {
                                                           resultHandler (nil);
                                                       }
                                                   }
                                                    onFault:^(NSError *error) {
                                                        
                                                        if (resultHandler)
                                                        {
                                                            resultHandler (error);
                                                        }
                                                        
                                                    }
                                           onUploadProgress:nil];
            }
            else
            {
                if (resultHandler)
                {
                    resultHandler ([SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
                }
            }
        }];
    }
    else
    {
        if (resultHandler)
        {
            resultHandler ([SSDKError errorWithDomain:SSDKErrorDomain code:500 userInfo:@{@"des":@"reqPath is nil"}]);
        }
    }
}

- (void)getShortUrls:(NSArray *)urls
              appkey:(NSString *)appkey
                duid:(NSString *)duid
        statDeviceOn:(BOOL)statDeviceOn
          statAuthOn:(BOOL)statAuthOn
                user:(SSDKUser *)user
        platformType:(SSDKPlatformType)platformType
            onResult:(void(^)(NSArray *shortUrls, NSError *error))resultHandler
{
    if (!self.backflowOn)
    {
        //回流开关关闭则直接返回错误
        if (resultHandler)
        {
            resultHandler (nil, [SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
        }
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self getServerConnectPermissionWithAppkey:appkey result:^(BOOL allow, NSError *error) {
        
        if (allow)
        {
            NSString *url = [weakSelf _urlStringWithBaseURL: kShortConvertUrl paths:@"url/shareSdkEncryptMapping.do"];
            
            NSMutableArray *mArr = [NSMutableArray array];
            
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *appId = [[bundle infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
            NSString *appVer = [[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
            
            //获取网络类型
            NSString *network = [[SSDKHelper shareHelper] currentNetworkType];
            
            //屏幕尺寸
            NSString *screenSize = [[SSDKHelper shareHelper] screenResolution];
            //获取运营商
            NSString *carrierStr = [MOBFDevice carrier];
            //系统版本
            NSString *sysVer = [NSString stringWithFormat:@"%@ %@",[UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
            //设备型号
            NSString *devModel = [MOBFDevice deviceModel];
            
            if (!statDeviceOn)
            {
                //不统计设备要重置运营商信息
                carrierStr = @"－1";
                screenSize = @"";
                sysVer = @"";
                devModel = @"";
            }
            
            NSString *uid = user.uid ? user.uid : @"";
            NSString *verifyType = [NSString stringWithFormat:@"%ld", (long)user.verifyType];
            NSString *gender = [NSString stringWithFormat:@"%ld", (long)user.gender];
            NSString *birthday = user.birthday ? [NSString stringWithFormat:@"%.0f", [user.birthday timeIntervalSince1970] * 1000] : @"";
            NSString *eduStr = user.educations ? [MOBFJson jsonStringFromObject:user.educations] : @"";
            NSString *workStr = user.works ? [MOBFJson jsonStringFromObject:user.works] : @"";
            
            if (!statAuthOn)
            {
                verifyType = @"";
                gender = @"";
                birthday = @"";
                eduStr = @"";
                workStr = @"";
            }
            
            //BundleId
            [mArr addObject:[MOBFString urlEncodeString:appId forEncoding:NSUTF8StringEncoding] ?: @""];
            //AppVer
            [mArr addObject:[MOBFString urlEncodeString:appVer forEncoding:NSUTF8StringEncoding] ?: @""];
            //SdkVer
            [mArr addObject:[NSString stringWithFormat:@"%ld", (long)[SSDKHelper shareHelper].versionNumber]];
            //Plat
            [mArr addObject:[NSString stringWithFormat:@"%ld", (long)SSDKPlatform]];
            //网络类型
            [mArr addObject:[MOBFString urlEncodeString:network forEncoding:NSUTF8StringEncoding] ?: @""];
            //系统版本
            [mArr addObject:[MOBFString urlEncodeString:sysVer forEncoding:NSUTF8StringEncoding] ?: @""];
            //屏幕尺寸
            [mArr addObject:[MOBFString urlEncodeString:screenSize forEncoding:NSUTF8StringEncoding] ?: @""];
            //厂商
            [mArr addObject:[MOBFString urlEncodeString:SSDKFactory forEncoding:NSUTF8StringEncoding] ?: @""];
            //model
            [mArr addObject:[MOBFString urlEncodeString:devModel forEncoding:NSUTF8StringEncoding] ?: @""];
            //运营商
            [mArr addObject:[MOBFString urlEncodeString:carrierStr forEncoding:NSUTF8StringEncoding] ?: @""];
            //Uid
            [mArr addObject:[MOBFString urlEncodeString:uid forEncoding:NSUTF8StringEncoding] ?: @""];
            //SecretType
            [mArr addObject:[MOBFString urlEncodeString:verifyType forEncoding:NSUTF8StringEncoding] ?: @""];
            //Gender
            [mArr addObject:[MOBFString urlEncodeString:gender forEncoding:NSUTF8StringEncoding] ?: @""];
            //生日
            [mArr addObject:[MOBFString urlEncodeString:birthday forEncoding:NSUTF8StringEncoding] ?: @""];
            //教育信息
            [mArr addObject:[MOBFString urlEncodeString:eduStr forEncoding:NSUTF8StringEncoding] ?: @""];
            //工作信息
            [mArr addObject:[MOBFString urlEncodeString:workStr forEncoding:NSUTF8StringEncoding] ?: @""];
            
            NSString *mStr = [mArr componentsJoinedByString:@"|"];
            NSString *keyStr = [NSString stringWithFormat:@"%@:%@", duid, appkey];
            
            NSData *keyData = [MOBFData md5Data:[keyStr dataUsingEncoding:NSUTF8StringEncoding]];
            NSData *mData = [MOBFData aes128EncryptData:[mStr dataUsingEncoding:NSUTF8StringEncoding]
                                                    key:keyData
                                                options:kCCOptionPKCS7Padding | kCCOptionECBMode];

            NSMutableDictionary *params = @{@"snsplat":@(platformType)}.mutableCopy;
            params[@"key"] = appkey;
            params[@"urls"] = urls;
            params[@"deviceid"] = duid;
            params[@"m"] = [MOBFData stringByBase64EncodeData:mData];

            [MOBFApiService sendRequestByURLString:url
                                              data:params
                                           headers:@{@"duid":[MOBFDevice duid]}
                                           timeout:0
                                        rsaKeySize:kShortUrlRSAKeySize
                                      rsaPublicKey:kShortUrlRSAPublicKey
                                        rsaModulus:kShortUrlRSAModulus
                                      compressData:NO
                                          onResult:^(NSDictionary *responder) {
                                              
                                              if (resultHandler)
                                              {
                                                  NSArray *urls = responder[@"data"];
                                                  
                                                  if ([urls isKindOfClass:NSArray.class])
                                                  {
                                                      resultHandler(urls, nil);
                                                  }
                                                  else
                                                  {
                                                      resultHandler(nil, [SSDKError requestFailedWithInfo:responder]);
                                                  }
                                              }
                                              
                                          } onFault:^(NSError *error) {
                                              
                                              if (resultHandler)
                                              {
                                                  resultHandler(nil,error);
                                              }
                                          }];
        }
        else
        {
            if (resultHandler)
            {
                resultHandler (nil, [SSDKError permissionDeniedWithDescription:@"Server permission denied !"]);
            }
        }
    }];
}

- (void)getServerConnectPermissionWithAppkey:(NSString *)appkey result:(void(^)(BOOL allow, NSError *error))result;
{
    BOOL hasCallback = NO; //是否已经回调
    static BOOL allowed = NO;
    if (!allowed)
    {
        allowed = [[SSDKDataService shareService] isAllowedConnectServer];
    }
    
    if (allowed && result)
    {
        result(YES,nil);
        hasCallback = YES;
    }
    
    if (!allowed || [[SSDKDataService shareService] needQueryServerConnectPermission])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"appkey"] = appkey;
        NSString *url = [self _urlStringWithBaseURL:kBaseUrl paths:@"conn"];
        
        __weak SSDKService *theService = self;
        [MOBFHttpService sendHttpRequestByURLString:url
                                             method:kMOBFHttpMethodGet
                                         parameters:params
                                            headers:@{@"duid":[MOBFDevice duid]}
                                           onResult:^(NSHTTPURLResponse *response, NSData *responseData) {
                                               
                                               [theService _parseResponse:response data:responseData block:^(NSDictionary *responder, NSError *error) {
                                                   
                                                   BOOL permission = YES;
                                                   BOOL serverPermission = NO;
                                                   if (!error && responder[@"res"] && [responder[@"res"] isKindOfClass:[NSNumber class]])
                                                   {
                                                       permission = [responder[@"res"] boolValue];
                                                       serverPermission = permission;
                                                       [[SSDKDataService shareService] cacheQueryServerConnectPermissionTime];
                                                       [[SSDKDataService shareService] cacheServerConnectPermission:YES];
                                                   }
                                                   
                                                   if (!hasCallback && result)
                                                   {
                                                       result(permission,error);
                                                   }
                                                   
                                                   allowed = serverPermission;
                                               }];
                                               
                                           } onFault:^(NSError *error) {
                                               
                                               if (!hasCallback && result)
                                               {
                                                   result(YES, error);
                                               }
                                               
                                           } onUploadProgress:nil];
    }
}

#pragma mark - Class Method

+ (SSDKService *)sharedService
{
    static SSDKService *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil)
        {
            _instance = [[SSDKService alloc] init];
        }
    });
    
    return _instance;
}

#pragma mark - Private

- (NSString *)_getServicePath:(NSString *)path
{
    NSString *apiPath = nil;
    NSString *host = nil;
    NSInteger port = 80;
    
    if (self.serverPaths)
    {
        if (self.serverPaths [@"assigns"] && self.serverPaths [@"assigns"] [path])
        {
            host = self.serverPaths [@"assigns"][path][@"host"];
            port = [self.serverPaths [@"assigns"][path][@"port"] integerValue];
        }
        
        if (!host)
        {
            host = self.serverPaths [@"defhost"];
            port = [self.serverPaths [@"defport"] integerValue];
        }
    }
    
    if (host)
    {
        NSString *baseUrl = [NSString stringWithFormat:@"%@:%ld", host, (long)port];
        apiPath = [self _urlStringWithBaseURL:baseUrl paths:path];
    }
    
    return apiPath;
}

/**
 *  解析请求回复
 */
- (void)_parseResponse:(NSHTTPURLResponse *)response
                 data:(NSData *)data
                block:(void(^)(NSDictionary *responder, NSError *error))block
{
    if (response.statusCode / 100 == 2)
    {
        NSDictionary *responder = [MOBFJson objectFromJSONData:data];
        
        [MOBFDebug log:@"#log : get reponder = %@", responder];
        
        id status = [responder objectForKey:@"status"];
        if ([status isKindOfClass:[NSNumber class]] && [status intValue] == 200)
        {
            //成功
            if (block)
            {
                block (responder, nil);
            }
        }
        else
        {
            //失败
            if (block)
            {
                block (nil, [SSDKError requestFailedWithInfo:responder]);
            }
        }
    }
    else
    {
        //失败
        if (block)
        {
            block (nil, [SSDKError requestFailedWithInfo:@{@"URLResponse":response}]);
        }
    }
}

- (NSString *)_urlStringWithBaseURL:(NSString *)baseURL paths:(NSString *)paths
{
    NSString *url = [baseURL stringByAppendingPathComponent:paths];
    NSString *regionPrefix = [MobSDK getInternationalDomain];
    
    BOOL needAddPrefix = NO;
    for (NSString *region in @[@"jp",@"us"])
    {
        if ([url hasPrefix:region])
        {
            needAddPrefix = NO;
            break;
        }
        // 服务器返回的日志接口 本身就自带区域前缀
        if ([region isEqualToString:regionPrefix])
        {
            needAddPrefix = YES;
        }
    }
    
    if (needAddPrefix)
    {
        url = [NSString stringWithFormat:@"%@.%@",regionPrefix,url];
    }
    NSString *scheme = [MOBFApplication enabledATS] ? @"https://":@"http://";
    url = [scheme stringByAppendingFormat:@"%@",url];
    return url;
}

@end
