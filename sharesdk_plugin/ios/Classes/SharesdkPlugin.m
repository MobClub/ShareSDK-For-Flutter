#import "SharesdkPlugin.h"
#import <ShareSDK/ShareSDKHeader.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MOBFoundation/MOBFoundation.h>import 'package:flutter/services.dart';
#import <objc/message.h>
#import <MOBFoundation/MobSDK+Privacy.h>

typedef NS_ENUM(NSUInteger, PluginMethod) {
    PluginMethodGetVersion          = 0,
    PluginMethodShare               = 1,
    PluginMethodAuth                = 2,
    PluginMethodHasAuthed           = 3,
    PluginMethodCancelAuth          = 4,
    PluginMethodGetUserInfo         = 5,
    PluginMethodRegist              = 6,
    PluginMethodShowMenu            = 7,
    PluginMethodShowEditor          = 8,
    PluginMethodOpenMiniProgram     = 9,
    PluginMethodActivePlatforms     = 10,
    PluginMethodIsClientInstalled   = 11,
    PluginMethodUploadPrivacyPermissionStatus = 12,
    PluginMethodSetAllowShowPrivacyWindow = 13,
    PluginMethodGetPrivacyPolicy = 14,
    PluginMethodSetPrivacyUI = 15,
    PluginMethodShareWithActivity = 16

};

@interface SharesdkPlugin()<FlutterStreamHandler,ISSERestoreSceneDelegate>

@property (strong, nonatomic) NSDictionary *methodMap;

// 事件回调
@property (nonatomic, copy) void (^callBack) (id _Nullable event);

@property (nonatomic, strong) NSMutableDictionary *sceneData;

@end

@implementation SharesdkPlugin

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = sel_registerName("addChannelWithSdkName:channel:");
        Method method = class_getClassMethod([MobSDK class],sel) ;
        if (method && method_getImplementation(method) != _objc_msgForward) {
            ((void (*)(id, SEL,id,id))objc_msgSend)([MobSDK class],sel,@"SHARESDK",@"4");
        }
    });
}

static NSString *const receiverStr = @"SSDKRestoreReceiver";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"com.yoozoo.mob/sharesdk"
                                     binaryMessenger:[registrar messenger]];
    SharesdkPlugin* instance = [[SharesdkPlugin alloc] init];
    instance.methodMap = @{
                           @"getVersion":@(PluginMethodGetVersion),
                           @"share":@(PluginMethodShare),
                           @"auth":@(PluginMethodAuth),
                           @"hasAuthed":@(PluginMethodHasAuthed),
                           @"cancelAuth":@(PluginMethodCancelAuth),
                           @"getUserInfo":@(PluginMethodGetUserInfo),
                           @"regist":@(PluginMethodRegist),
                           @"activePlatforms":@(PluginMethodActivePlatforms),
                           @"showEditor":@(PluginMethodShowEditor),
                           @"showMenu":@(PluginMethodShowMenu),
                           @"openMiniProgram":@(PluginMethodOpenMiniProgram),
                           @"isClientInstalled":@(PluginMethodIsClientInstalled),
                           @"uploadPrivacyPermissionStatus":@(PluginMethodUploadPrivacyPermissionStatus),
                           @"setAllowShowPrivacyWindow":@(PluginMethodSetAllowShowPrivacyWindow),
                           @"setPrivacyUI":@(PluginMethodSetPrivacyUI),
                           @"getPrivacyPolicy":@(PluginMethodGetPrivacyPolicy),
                           @"shareWithActivity":@(PluginMethodShareWithActivity)
                           };
    [registrar addMethodCallDelegate:instance channel:channel];
    
    FlutterEventChannel* e_channel = [FlutterEventChannel eventChannelWithName:receiverStr binaryMessenger:[registrar messenger]];
    [e_channel setStreamHandler:instance];
    
    [instance addObserver];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSNumber *methodType = self.methodMap[call.method];
    
    if (methodType)
    {
        switch (methodType.intValue)
        {
            case PluginMethodGetVersion:
                [self _getVersion:result];
                break;
            case PluginMethodShare:
                [self _shareWithArgs:call.arguments result:result];
                break;
            case PluginMethodAuth:
                [self _authWithArgs:call.arguments result:result];
                break;
            case PluginMethodHasAuthed:
                [self _hasAuthedWithArgs:call.arguments result:result];
                break;
            case PluginMethodCancelAuth:
                [self _cancelAuthWithArgs:call.arguments result:result];
                break;
            case PluginMethodGetUserInfo:
                [self _getUserInfoWithArgs:call.arguments result:result];
                break;
            case PluginMethodRegist:
                [self _registWithArgs:call.arguments result:result];
                break;
            case PluginMethodActivePlatforms:
                [self _getActivePlatformsResult:result];
                break;
            case PluginMethodShowMenu:
                [self _showMenuWithArgs:call.arguments result:result];
                break;
            case PluginMethodShowEditor:
                [self _showEditorWithArgs:call.arguments result:result];
                break;
            case PluginMethodOpenMiniProgram:
                [self _openMiniProgramWithArgs:call.arguments result:result];
                break;
            case PluginMethodIsClientInstalled:
                [self _isClientInstalledWithArgs:call.arguments result:result];
                break;
            case PluginMethodGetPrivacyPolicy:{
                [self _getPrivacyPolicy:call.arguments result:result];
            }
                break;
            case PluginMethodSetAllowShowPrivacyWindow:{
                [self _setAllowShowPrivacyWindow:call.arguments result:result];
            }
                break;
            case PluginMethodSetPrivacyUI:{
                [self _setPrivacyUI:call.arguments result:result];
            }
                break;
            case PluginMethodUploadPrivacyPermissionStatus:{
                [self _uploadPrivacyPermissionStatus:call.arguments result:result];
            }
                break;
            case PluginMethodShareWithActivity:{
                [self _shareActivityWithArgs:call.arguments result:result];
            }
                break;
            default:
                NSAssert(NO, @"The method requires an implementation ！");
                break;
        }
    }
    else
    {
        result(FlutterMethodNotImplemented);
    }
}

- (void)_getVersion:(FlutterResult)result
{
    result([ShareSDK sdkVersion]);
}

- (void)_shareWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSInteger type = [args[@"platform"] integerValue];
    NSMutableDictionary *params = [self _covertParams:args[@"params"]].mutableCopy;
    if (type == SSDKPlatformTypeOasis) {
        if ([params[@"type"] integerValue] == SSDKContentTypeVideo) {
            if ([params[@"video"] isKindOfClass:[NSString class]]) {
                params[@"video"] = [NSData dataWithContentsOfFile:params[@"video"]];
            }
        }
    }
    
    //Facebook
    NSArray *imageIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_image"] isKindOfClass:[NSString class]])  {
        imageIdentifier = [params[@"facebookAssetLocalIdentifierKey_image"] componentsSeparatedByString:@","];
    }
    id videoIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_video"] isKindOfClass:[NSString class]])  {
        videoIdentifier = params[@"facebookAssetLocalIdentifierKey_video"];
    }
    if (imageIdentifier || videoIdentifier) {
        [params SSDKSetupFacebookParamsByImagePHAsset:imageIdentifier videoPHAsset:videoIdentifier];
    }
    
    //kakaotalk
    NSString *key = [NSString stringWithFormat:@"@platform(%ld)",type];
    NSMutableDictionary *platformParams = [self _covertParams:params[key]].mutableCopy;
    
    NSString *templateId = nil;
    if ([platformParams[@"templateId"] isKindOfClass:[NSString class]])  {
        templateId = platformParams[@"templateId"];
    }
    NSURL *url = nil;
    if ([platformParams[@"url"] isKindOfClass:[NSURL class]])  {
        url = platformParams[@"url"];
    }
    NSDictionary *templateArgs = nil;
    if ([platformParams[@"templateArgs"] isKindOfClass:[NSDictionary class]])  {
        templateArgs = platformParams[@"templateArgs"];
    }
    if (templateId || url) {
        [params SSDKSetupKaKaoTalkParamsByUrl:url templateId:templateId templateArgs:templateArgs];
    }
    
    //dropbox
    NSString *attachments = nil;
    if ([platformParams[@"attachments"] isKindOfClass:[NSString class]])  {
        attachments = platformParams[@"attachments"];
    }
    if (attachments) {
        [params SSDKSetupDropboxParamsByAttachment:[NSURL URLWithString:attachments]];
    }
    
    //通用相册分享参数设置
    NSArray *imageAssets = nil;
    if ([params[@"imageAssets"] isKindOfClass:[NSString class]])  {
        imageAssets = [params[@"imageAssets"] componentsSeparatedByString:@","];
    }
    id videoAsset = nil;
    if (params[@"videoAsset"] != nil)  {
        videoAsset = params[@"videoAsset"];
    }
    if (imageAssets || videoAsset) {
        [params SSDKSetupShareParamsByImageAsset:imageAssets videoAsset:videoAsset completeHandle:^(BOOL complete) {
            if(complete){
                [ShareSDK share:type parameters:params.mutableCopy onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    if (state != SSDKResponseStateBegin)
                    {
                        NSDictionary *dic = @{
                                              @"state":@(state),
                                              @"userData":[self _ssdkGetDictionaryWithObject:userData]?:[NSNull null],
                                              @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                              @"error":[self _covertError:error]
                                              };
                        
                        result([self _ssdkGetDictionaryWithObject:dic]);
                    }
                }];
            }else{
                NSDictionary *dic = @{
                                      @"state":@(2),
                                      @"user":[NSNull null],
                                      @"error":@{@"error":@"失败"}
                                      };
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }else{
        [ShareSDK share:type parameters:params.mutableCopy onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state != SSDKResponseStateBegin)
            {
                NSDictionary *dic = @{
                                      @"state":@(state),
                                      @"userData":[self _ssdkGetDictionaryWithObject:userData]?:[NSNull null],
                                      @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                      @"error":[self _covertError:error]
                                      };
                
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }
}

- (void)_shareActivityWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSInteger type = [args[@"platform"] integerValue];
    NSMutableDictionary *params = [self _covertParams:args[@"params"]].mutableCopy;

    //通用相册分享参数设置
    NSArray *imageAssets = nil;
    if ([params[@"imageAssets"] isKindOfClass:[NSString class]])  {
        imageAssets = [params[@"imageAssets"] componentsSeparatedByString:@","];
    }
    id videoAsset = nil;
    if (params[@"videoAsset"] != nil)  {
        videoAsset = params[@"videoAsset"];
    }
    if (imageAssets || videoAsset) {
        [params SSDKSetupShareParamsByImageAsset:imageAssets videoAsset:videoAsset completeHandle:^(BOOL complete) {
            if(complete){
                [ShareSDK shareByActivityViewController:type parameters:params.mutableCopy onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                    if (state != SSDKResponseStateBegin)
                    {
                        NSDictionary *dic = @{
                                              @"state":@(state),
                                              @"userData":[self _ssdkGetDictionaryWithObject:userData]?:[NSNull null],
                                              @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                              @"error":[self _covertError:error]
                                              };
                        
                        result([self _ssdkGetDictionaryWithObject:dic]);
                    }
                }];
            }else{
                NSDictionary *dic = @{
                                      @"state":@(2),
                                      @"user":[NSNull null],
                                      @"error":@{@"error":@"失败"}
                                      };
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }else{
        [ShareSDK shareByActivityViewController:type parameters:params.mutableCopy onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state != SSDKResponseStateBegin)
            {
                NSDictionary *dic = @{
                                      @"state":@(state),
                                      @"userData":[self _ssdkGetDictionaryWithObject:userData]?:[NSNull null],
                                      @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                      @"error":[self _covertError:error]
                                      };
                
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }
}

- (void)_authWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSInteger type = [args[@"platform"] integerValue];
    NSDictionary *settings = args[@"settings"];
    [ShareSDK authorize:type settings:[settings isKindOfClass:NSDictionary.class]?settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
        {
            NSDictionary *dic = @{
                                  @"state":@(state),
                                  @"user":user.dictionaryValue?:[NSNull null],
                                  @"error":[self _covertError:error]
                                  };
            result([self _ssdkGetDictionaryWithObject:dic]);
        }
    }];
}

- (void)_hasAuthedWithArgs:(NSNumber *)args result:(FlutterResult)result
{
    NSInteger state = SSDKResponseStateFail;
    BOOL hasAuthed = [ShareSDK hasAuthorized:args.integerValue];
    if (hasAuthed)
    {
        state = SSDKResponseStateSuccess;
    }
    NSDictionary *dic = @{
                          @"state":@(state),
                          @"user":[NSNull null],
                          @"error":[NSNull null]
                          };
    result([self _ssdkGetDictionaryWithObject:dic]);
}

- (void)_cancelAuthWithArgs:(NSNumber *)args result:(FlutterResult)result
{
    
    [ShareSDK cancelAuthorize:args.integerValue result:^(NSError *error) {
        NSInteger state = SSDKResponseStateFail;
        if (error == nil)
        {
            state = SSDKResponseStateSuccess;
        }
        NSDictionary *dic = @{
                              @"state":@(state),
                              @"user":[NSNull null],
                              @"error":[self _covertError:error]
                              };
        result([self _ssdkGetDictionaryWithObject:dic]);
    }];
}

- (void)_getUserInfoWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSInteger type = [args[@"platform"] integerValue];
    [ShareSDK getUserInfo:type onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state != SSDKResponseStateBegin)
        {
            NSDictionary *dic = @{
                                  @"state":@(state),
                                  @"user":user.dictionaryValue?:[NSNull null],
                                  @"error":[self _covertError:error],
                                  };
            result([self _ssdkGetDictionaryWithObject:dic]);
        }
    }];
}

- (void)_registWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [args enumerateKeysAndObjectsUsingBlock:^(id key, NSDictionary *obj, BOOL * _Nonnull stop) {
            
            [platformsRegister.platformsInfo setObject:obj.mutableCopy forKey:[NSString stringWithFormat:@"%@",key]];
        }];
    }];
}

- (void)_getActivePlatformsResult:(FlutterResult)result
{
    result([ShareSDK activePlatforms]);
}

- (void)_showEditorWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    SSDKPlatformType type = [args[@"platform"] integerValue];
    NSMutableDictionary *params = [self _covertParams:args[@"params"]].mutableCopy;
    if (type == SSDKPlatformTypeOasis) {
        if ([params[@"type"] integerValue] == SSDKContentTypeVideo) {
            if ([params[@"video"] isKindOfClass:[NSString class]]) {
                params[@"video"] = [NSData dataWithContentsOfFile:params[@"video"]];
            }
        }
    }
    NSArray *imageIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_image"] isKindOfClass:[NSString class]])  {
        imageIdentifier = [params[@"facebookAssetLocalIdentifierKey_image"] componentsSeparatedByString:@","];
    }
    id videoIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_video"] isKindOfClass:[NSString class]])  {
        videoIdentifier = params[@"facebookAssetLocalIdentifierKey_video"];
    }
    if (imageIdentifier || videoIdentifier) {
        [params SSDKSetupFacebookParamsByImagePHAsset:imageIdentifier videoPHAsset:videoIdentifier];
    }
    
    //kakaotalk
    NSString *key = [NSString stringWithFormat:@"@platform(%ld)",type];
    NSMutableDictionary *platformParams = [self _covertParams:params[key]].mutableCopy;
    
    NSString *templateId = nil;
    if ([platformParams[@"templateId"] isKindOfClass:[NSString class]])  {
        templateId = platformParams[@"templateId"];
    }
    NSURL *url = nil;
    if ([platformParams[@"url"] isKindOfClass:[NSURL class]])  {
        url = platformParams[@"url"];
    }
    NSDictionary *templateArgs = nil;
    if ([platformParams[@"templateArgs"] isKindOfClass:[NSDictionary class]])  {
        templateArgs = platformParams[@"templateArgs"];
    }
    if (templateId || url) {
        [params SSDKSetupKaKaoTalkParamsByUrl:url templateId:templateId templateArgs:templateArgs];
    }
    
    //dropbox
    NSString *attachments = nil;
    if ([platformParams[@"attachments"] isKindOfClass:[NSString class]])  {
        attachments = platformParams[@"attachments"];
    }
    if (attachments) {
        [params SSDKSetupDropboxParamsByAttachment:attachments];
    }
    
    //通用相册分享参数设置
    NSArray *imageAssets = nil;
    if ([params[@"imageAssets"] isKindOfClass:[NSString class]])  {
        imageAssets = [params[@"imageAssets"] componentsSeparatedByString:@","];
    }
    id videoAsset = nil;
    if (params[@"videoAsset"] != nil)  {
        videoAsset = params[@"videoAsset"];
    }
    if (imageAssets || videoAsset) {
        [params SSDKSetupShareParamsByImageAsset:imageAssets videoAsset:videoAsset completeHandle:^(BOOL complete) {
            if(complete){
                [ShareSDK showShareEditor:type
                           otherPlatforms:nil
                              shareParams:params.mutableCopy
                      editorConfiguration:nil
                           onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                    
                    if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
                    {
                        NSDictionary *dic = @{
                                              @"state":@(state),
                                              @"platform":@(platformType),
                                              @"error":[self _covertError:error],
                                              @"userData":userData?:[NSNull null],
                                              @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                              };
                        result([self _ssdkGetDictionaryWithObject:dic]);
                    }
                }];
            }else{
                NSDictionary *dic = @{
                                      @"state":@(2),
                                      @"user":[NSNull null],
                                      @"error":@{@"error":@"失败"}
                                      };
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }else{
        [ShareSDK showShareEditor:type
                   otherPlatforms:nil
                      shareParams:params.mutableCopy
              editorConfiguration:nil
                   onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
            {
                NSDictionary *dic = @{
                                      @"state":@(state),
                                      @"platform":@(platformType),
                                      @"error":[self _covertError:error],
                                      @"userData":userData?:[NSNull null],
                                      @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                      };
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }
}

- (void)_showMenuWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSArray *types = [args[@"platforms"] isKindOfClass:NSArray.class] ?args[@"platforms"]:nil;
    id view = [args[@"view"] isKindOfClass:UIView.class] ? args[@"view"] : nil;
    NSMutableDictionary *params = [self _covertParams:args[@"params"]].mutableCopy;
    
    //Facebook
    NSArray *imageIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_image"] isKindOfClass:[NSString class]])  {
        imageIdentifier = [params[@"facebookAssetLocalIdentifierKey_image"] componentsSeparatedByString:@","];
    }
    id videoIdentifier = nil;
    if ([params[@"facebookAssetLocalIdentifierKey_video"] isKindOfClass:[NSString class]])  {
        videoIdentifier = params[@"facebookAssetLocalIdentifierKey_video"];
    }
    if (imageIdentifier || videoIdentifier) {
        [params SSDKSetupFacebookParamsByImagePHAsset:imageIdentifier videoPHAsset:videoIdentifier];
    }
    
    //通用相册分享参数设置
    NSArray *imageAssets = nil;
    if ([params[@"imageAssets"] isKindOfClass:[NSString class]])  {
        imageAssets = [params[@"imageAssets"] componentsSeparatedByString:@","];
    }
    id videoAsset = nil;
    if (params[@"videoAsset"] != nil)  {
        videoAsset = params[@"videoAsset"];
    }
    if (imageAssets || videoAsset) {
        [params SSDKSetupShareParamsByImageAsset:imageAssets videoAsset:videoAsset completeHandle:^(BOOL complete) {
            if(complete){
                [ShareSDK showShareActionSheet:view
                                   customItems:types
                                   shareParams:params.mutableCopy
                            sheetConfiguration:nil
                                onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                    
                    if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
                    {
                        NSDictionary *dic = @{
                                              @"state":@(state),
                                              @"platform":@(platformType),
                                              @"error":[self _covertError:error],
                                              @"userData":userData?:[NSNull null],
                                              @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                              };
                        dic = [self _ssdkGetDictionaryWithObject:dic];
                        result(dic);
                    }
                }];
            }else{
                NSDictionary *dic = @{
                                      @"state":@(2),
                                      @"user":[NSNull null],
                                      @"error":@{@"error":@"失败"}
                                      };
                result([self _ssdkGetDictionaryWithObject:dic]);
            }
        }];
    }else{
        [ShareSDK showShareActionSheet:view
                           customItems:types
                           shareParams:params.mutableCopy
                    sheetConfiguration:nil
                        onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
            {
                NSDictionary *dic = @{
                                      @"state":@(state),
                                      @"platform":@(platformType),
                                      @"error":[self _covertError:error],
                                      @"userData":userData?:[NSNull null],
                                      @"contentEntity":[self _ssdkGetDictionaryWithObject:contentEntity.dictionaryValue]?:[NSNull null],
                                      };
                dic = [self _ssdkGetDictionaryWithObject:dic];
                result(dic);
            }
        }];
    }
}

- (id)_covertError:(NSError *)error
{
    if (error)
    {
        NSDictionary *errorInfo = [self _ssdkGetDictionaryWithObject:error.userInfo];
        return @{@"code":@(error.code),@"userInfo":errorInfo?:@{}};
    }
    
    return [NSNull null];
}

- (id)_getObjectWithObject:(id)obj{
    id basicData = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        basicData = obj;
    }else if([obj isKindOfClass:[NSNumber class]]){
        basicData = obj;
    }else if([obj isKindOfClass:[NSURL class]]){
        basicData = [obj absoluteString];
    }else if([obj isKindOfClass:[SSDKImage class]]){
        basicData = [[obj URL] absoluteString];
    }else if([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *array = [NSMutableArray array];
        for (id sigleObject in obj) {
            if ([sigleObject isKindOfClass:[NSDictionary class]]) {
                id sigdic = [self _ssdkGetDictionaryWithObject:sigleObject];
                if (sigdic) {
                    [array addObject:sigdic];
                }
            }else{
                id sigData = [self _getObjectWithObject:sigleObject];
                if (sigData) {
                    [array addObject:sigData];
                }
            }
        }
        basicData = array.count > 0?array:nil;
    }else if([obj isKindOfClass:[NSDictionary class]]){
        basicData = [self _ssdkGetDictionaryWithObject:obj];
    }
    return basicData;
}

- (NSDictionary *)_ssdkGetDictionaryWithObject:(NSDictionary *)object{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [object enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id data = [self _getObjectWithObject:obj];
        if (data) {
            dic[key] = data;
        }
    }];
    return dic.count > 0 ?dic:nil;
}

- (NSMutableDictionary *)_covertParams:(NSDictionary *)params
{
    NSMutableDictionary *tmp = params.mutableCopy;
    
    NSArray *urlKeys = @[@"url",@"audio_url",@"audio_flash_url",@"video_flash_url",@"video_asset_url"];
    NSArray *thumbImageKeys = @[@"thumb_image",@"wxmp_hdthumbimage"];
    NSArray *dataKeys = @[@"emoticon_data",@"file_data",@"source_file",@"video",@"audio"];
    SSDKImage *img = nil;
    for (id key in params.allKeys)
    {
        if ([urlKeys containsObject:key])
        {
            tmp[key] = [NSURL URLWithString:[NSString stringWithFormat:@"%@",params[key]]];
        }
        
        if ([thumbImageKeys containsObject:key])
        {
            tmp[key] = [SSDKImage imageWithObject:params[key]];
        }
        
        if ([dataKeys containsObject:key])
        {
            tmp[key] = ((id(*)(id,SEL,id))objc_msgSend)(NSClassFromString(@"SSDKData"),NSSelectorFromString(@"dataWithObject:"),params[key]);
        }

        if ([key isEqualToString:@"thumbImage"])
        {
            img = (((NSArray *(*)(id, SEL, id))objc_msgSend)(params.mutableCopy,NSSelectorFromString(@"_convertToImages:"),params[key]))[0];
            void(^ handler)(UIImage *) = ^(UIImage *image) {
                [tmp setObject:image forKey:@"thumbImage"];
            };
            ((void(*)(id, SEL, id))objc_msgSend)(img,NSSelectorFromString(@"getNativeImage:"),handler);
        }
        
        if ([key isEqualToString:@"images"])
        {
            tmp[key] = ((NSArray *(*)(id, SEL, id))objc_msgSend)(params.mutableCopy,NSSelectorFromString(@"_convertToImages:"),params[key]);
        }
        
        if ([key isEqualToString:@"Sticker"])
        {
            tmp[key] = ((NSArray *(*)(id, SEL, id))objc_msgSend)(params.mutableCopy,NSSelectorFromString(@"_convertToImages:"),params[key]);
        }
        
        if ([params[key] isKindOfClass:NSDictionary.class])
        {
            tmp[key] = [self _covertParams:params[key]];
        }
    }
    
    if (params[@"sina_linkCard"] != nil && [params[@"sina_linkCard"] boolValue] == YES)
    {
        tmp[@"sina_linkCard"] = @1;
        if (tmp[@"images"] == nil && params[@"image_url"] != nil)
        {
            tmp[@"images"] = ((NSArray *(*)(id, SEL, id))objc_msgSend)(params.mutableCopy,NSSelectorFromString(@"_convertToImages:"),params[@"image_url"]);
        }
    }
    
    return tmp;
}

- (void)_openMiniProgramWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    Class connector = NSClassFromString(@"WeChatConnector");
    NSAssert(connector != NULL, @"Need to import WechatConnector.framework !");
    
    void(^ complete)(BOOL) = ^(BOOL success) {
        result(@(success));
    };
    SEL openMiniProgramSEL = NSSelectorFromString(@"openMiniProgramWithUserName:path:miniProgramType:complete:");
    ((void(*)(id,SEL,NSString *,NSString *,int,id))objc_msgSend)(connector,openMiniProgramSEL,args[@"userName"],args[@"path"],[args[@"type"] intValue],complete);
}

- (void)_isClientInstalledWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    SSDKPlatformType type = [args[@"platform"] integerValue];
    result(@([ShareSDK isClientInstalled:type]));
}

- (void)_uploadPrivacyPermissionStatus:(NSDictionary *)args result:(FlutterResult)result{
    [MobSDK uploadPrivacyPermissionStatus:[args[@"status"]boolValue] onResult:^(BOOL success) {
        result(@{@"success":@(success)});
    }];
}

- (void)_setAllowShowPrivacyWindow:(NSDictionary *)args result:(FlutterResult)result{
    
    result(@1);
}

- (void)_getPrivacyPolicy:(NSDictionary *)args result:(FlutterResult)result{
    [MobSDK getPrivacyPolicy:args[@"type"] language:args[@"language"]  compeletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        result(@{
            @"data":@{@"data":(data[@"content"]?:[NSNull null])},
            @"error":error?@{@"error":@"获取失败"}:[NSNull null]
        });
    }];
}

- (void)_setPrivacyUI:(NSDictionary *)args result:(FlutterResult)result{
    
    result(nil);
}

#pragma mark - FlutterStreamHandler Protocol

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events
{
    self.callBack = events;
    if (self.sceneData) {
        events(self.sceneData);
    }
    self.sceneData = nil;
    return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments
{
    self.callBack = nil;
    return nil;
}


#pragma mark - 场景还原 添加监听
- (void)addObserver
{
    [ShareSDK setRestoreSceneDelegate:self];
}

#pragma mark - ISSERestoreSceneDelegate

/**
 闭环分享代理回调
 
 */
- (void)ISSEWillRestoreScene:(SSERestoreScene *)scene error:(NSError *)error
{
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
       
    if (scene.path.length > 0)
    {
        resultDict[@"path"] = scene.path;
    }
       
    if (scene.params && scene.params.count > 0)
    {
        resultDict[@"params"] = scene.params;
    }
    if (self.callBack)
    {
        self.callBack(resultDict);
    }else{
        self.sceneData = resultDict;
    }
}



@end
