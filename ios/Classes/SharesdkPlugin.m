#import "SharesdkPlugin.h"
#import <ShareSDK/ShareSDKHeader.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
// #import <ShareSDK/ShareSDK.h>
// #import <ShareSDK/ShareSDK+Base.h>
#import <objc/message.h>

typedef NS_ENUM(NSUInteger, PluginMethod) {
    PluginMethodGetVersion,
    PluginMethodShare,
    PluginMethodAuth,
    PluginMethodHasAuthed,
    PluginMethodCancelAuth,
    PluginMethodGetUserInfo,
    PluginMethodRegist,
    PluginMethodShowMenu,
    PluginMethodShowEditor,
    PluginMethodOpenMiniProgram,
    PluginMethodActivePlatforms,
    PluginMethodIsClientInstalled,
};

@interface SharesdkPlugin()
@property (strong, nonatomic) NSDictionary *methodMap;
@end

@implementation SharesdkPlugin
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
                           @"isClientInstalled":@(PluginMethodIsClientInstalled)
                           };
  [registrar addMethodCallDelegate:instance channel:channel];
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
    NSDictionary *params = [self _covertParams:args[@"params"]];
    
    [ShareSDK share:type parameters:params.mutableCopy onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        if (state != SSDKResponseStateBegin)
        {
            NSDictionary *dic = @{
                                  @"state":@(state),
                                  @"userData":userData?:[NSNull null],
                                  @"contentEntity":contentEntity.dictionaryValue?:[NSNull null],
                                  @"error":[self _covertError:error]
                                  };
            result(dic);
        }
    }];
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
            result(dic);
        }
    }];
}

- (void)_hasAuthedWithArgs:(NSNumber *)args result:(FlutterResult)result
{
    result(@([ShareSDK hasAuthorized:args.integerValue]));
}

- (void)_cancelAuthWithArgs:(NSNumber *)args result:(FlutterResult)result
{
    [ShareSDK cancelAuthorize:args.integerValue result:^(NSError *error) {
        
        result([self _covertError:error]);
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
            result(dic);
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
    NSDictionary *params = [self _covertParams:args[@"params"]];
    SEL showEditorSEL = NSSelectorFromString(@"showShareEditor:otherPlatforms:shareParams:editorConfiguration:onStateChanged:");
    NSAssert([ShareSDK.class respondsToSelector:showEditorSEL], @"Need to import ShareSDKUI.framework");    
    ((id(*)(id,
            SEL,
            SSDKPlatformType,
            NSArray *,
            NSMutableDictionary *,
            id,
            void(^)(SSDKResponseState,SSDKPlatformType,NSDictionary*,SSDKContentEntity*,NSError *,BOOL)))objc_msgSend)
    (ShareSDK.class,
     showEditorSEL,
     type,
     nil,
     params.mutableCopy,
     nil,
     ^(SSDKResponseState state,
       SSDKPlatformType platformType,
       NSDictionary *userData,
       SSDKContentEntity *contentEntity,
       NSError *error,
       BOOL end){
         
         if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
         {
             NSDictionary *dic = @{
                                   @"state":@(state),
                                   @"platform":@(platformType),
                                   @"error":[self _covertError:error],
                                   @"userData":userData?:[NSNull null],
                                   @"contentEntity":contentEntity.dictionaryValue?:[NSNull null],
                                   };
             result(dic);
         }
     });
    
}

- (void)_showMenuWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    NSArray *types = [args[@"platforms"] isKindOfClass:NSArray.class] ?args[@"platforms"]:nil;
    NSDictionary *params = [self _covertParams:args[@"params"]];
    SEL showMenuSEL = NSSelectorFromString(@"showShareActionSheet:customItems:shareParams:sheetConfiguration:onStateChanged:");
    NSAssert([ShareSDK.class respondsToSelector:showMenuSEL], @"Need to import ShareSDKUI.framework");
    
    ((id(*)(id,
            SEL,
            UIView *,
            NSArray *,
            NSMutableDictionary *,
            id,
            void(^)(SSDKResponseState,SSDKPlatformType,NSDictionary*,SSDKContentEntity*,NSError *,BOOL)))objc_msgSend)
    (ShareSDK.class
     ,showMenuSEL,
     nil,
     types,
     params.mutableCopy,
     nil,
     ^(SSDKResponseState state,
       SSDKPlatformType platformType,
       NSDictionary *userData,
       SSDKContentEntity *contentEntity,
       NSError *error,
       BOOL end){
         
         if (state != SSDKResponseStateBegin && state != SSDKResponseStateUpload)
         {
             NSDictionary *dic = @{
                                   @"state":@(state),
                                   @"platform":@(platformType),
                                   @"error":[self _covertError:error],
                                   @"userData":userData?:[NSNull null],
                                   @"contentEntity":contentEntity.dictionaryValue?:[NSNull null],
                                   };
             result(dic);
         }
     });
}

- (id)_covertError:(NSError *)error
{
    if (error)
    {
        return @{@"code":@(error.code),@"userInfo":error.userInfo?:@{}};
    }
    
    return [NSNull null];
}

- (NSMutableDictionary *)_covertParams:(NSDictionary *)params
{
    NSMutableDictionary *tmp = params.mutableCopy;
    
    NSArray *urlKeys = @[@"url",@"audio_url",@"audio_flash_url",@"video_flash_url",@"video_asset_url"];
    NSArray *thumbImageKeys = @[@"thumb_image",@"wxmp_hdthumbimage"];
    NSArray *dataKeys = @[@"emoticon_data",@"file_data",@"source_file"];
    
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
        
        if ([key isEqualToString:@"images"])
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
    SEL openMiniProgramSEL = NSSelectorFromString(@"openMiniProgramWithUserName:path:miniProgramType:");
    BOOL opened = ((BOOL(*)(id,SEL,NSString *,NSString *,int))objc_msgSend)(connector,openMiniProgramSEL,args[@"userName"],args[@"path"],[args[@"type"] intValue]);
    result(@(opened));
}

- (void)_isClientInstalledWithArgs:(NSDictionary *)args result:(FlutterResult)result
{
    SSDKPlatformType type = [args[@"platform"] integerValue];
    result(@([ShareSDK isClientInstalled:type]));
}

@end
