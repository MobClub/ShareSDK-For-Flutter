import 'dart:async';
import 'package:flutter/services.dart';
import './sharesdk_defines.dart';
import './sharesdk_register.dart';
import './sharesdk_map.dart';

typedef void EventHandler(dynamic event);

class SharesdkPlugin {
  static const MethodChannel _channel =
      const MethodChannel('com.yoozoo.mob/sharesdk');

  static EventChannel _channelReciever =
      const EventChannel('SSDKRestoreReceiver');

  /// 注册方法：
  /// 1. 创建register对象，
  /// 2. 通过register对象的函数设置平台参数，
  /// 3. 通过register注册
  static Future<dynamic> regist(ShareSDKRegister register) async {
    return await _channel.invokeMethod(
        ShareSDKMethods.regist.name!, register.platformsInfo);
  }

  /// 分享
  static Future<dynamic> share(ShareSDKPlatform platform, SSDKMap params,
      Function(SSDKResponseState, dynamic, dynamic, SSDKError) result) {
    Map args = {"platform": platform.id, "params": params.map};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.share.name!, args);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["userData"],
            response["contentEntity"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }
  static Future<dynamic> shareByMap(ShareSDKPlatform platform, Map params,
      Function(SSDKResponseState, dynamic, dynamic, SSDKError) result) {
    Map args = {"platform": platform.id, "params": params};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.share.name!, args);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["userData"],
            response["contentEntity"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }
  /// 系统分享
  static Future<dynamic> shareWithActivity(ShareSDKPlatform platform,
      SSDKMap params, Function(SSDKResponseState, dynamic, dynamic, SSDKError) result) {
    Map args = {"platform": platform.id, "params": params.map};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.shareWithActivity.name!, args);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["userData"], response["contentEntity"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }

  /// 授权
  static Future<dynamic> auth(ShareSDKPlatform platform, Map settings,
      Function(SSDKResponseState, dynamic, SSDKError) result) {
    Map args = {"platform": platform.id, "settings": settings};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.auth.name!, args);
    callback.then((dynamic response) {
      print('======> $callback !' + '~~~~~> $response');
      if (result != null) {
        result(_state(response), response["user"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }

  /// 判断是否授权
  static Future<dynamic> hasAuthed(ShareSDKPlatform platform,
      Function(SSDKResponseState, dynamic, SSDKError) result) {
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.hasAuthed.name!, platform.id);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["user"], SSDKError(rawData: response["error"]));
      }
    });
    return callback;
  }

  /// 取消授权
  static Future<dynamic> cancelAuth(ShareSDKPlatform platform,
      Function(SSDKResponseState, dynamic, SSDKError) result) {
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.cancelAuth.name!, platform.id);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["user"], SSDKError(rawData: response["error"]));
      }
    });
    return callback;
  }

  /// 获取用户信息
  static Future<dynamic> getUserInfo(ShareSDKPlatform platform,
      Function(SSDKResponseState, dynamic, SSDKError) result) {
    Map args = {"platform": platform.id};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.getUserInfo.name!, args);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), response["user"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }

  /// 弹出分享菜单
  static Future<dynamic> showMenu(
      dynamic view,
      List<ShareSDKPlatform>? platforms,
      SSDKMap params,
      Function(SSDKResponseState, ShareSDKPlatform, dynamic, dynamic, SSDKError)?
          result) {
    List? types;
    if (platforms != null) {
      Iterable<int> ids = platforms.map((ShareSDKPlatform item) => item.id!);
      types = List.from(ids);
    }

    Map args = {"platforms": types, "params": params.map, "view":view};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.showMenu.name!, args);
    callback.then((dynamic response) {
      if (result != null) {
        result(_state(response), ShareSDKPlatform(id: response["platform"], name: "null"), response["userData"], response["contentEntity"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }

  /// 弹出编辑菜单
  static Future<dynamic> showEditor(
      ShareSDKPlatform platform,
      SSDKMap params,
      Function(SSDKResponseState, ShareSDKPlatform, dynamic, dynamic, SSDKError)?
          result) {
    Map args = {"platform": platform.id, "params": params.map};
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.showEditor.name!, args);
    callback.then((dynamic response) {
      print(response);
      if (result != null) {
        result(_state(response), ShareSDKPlatform(id: response["platform"], name: "null"), response["userData"], response["contentEntity"], SSDKError(rawData: response["error"]));
      }
    });

    return callback;
  }

  //get ShareSDK PrivacyPolicy, language forExample en-CN,zh-Hans-CN,zh,en. null will be zh
  static Future<dynamic> getPrivacyPolicy(
      String type, String? language, Function(dynamic? data, dynamic error) result) {
    Map args = {"type": type};
    if (language != null) {
      args["language"] = language;
    }
    Future<dynamic> callback =
        _channel.invokeMethod(ShareSDKMethods.getPrivacyPolicy.name!, args);
    callback.then((dynamic response) {
      print(response);
      if (result != null) {
        result(response["data"], response["error"]);
      }
    });
    return callback;
  }

  ///upload user permissionStatus to Share
  static Future<dynamic> uploadPrivacyPermissionStatus(
      int status, Function(bool success) result) {
    Map args = {"status": status};
    Future<dynamic> callback = _channel.invokeMethod(
        ShareSDKMethods.uploadPrivacyPermissionStatus.name!, args);
    callback.then((dynamic response) {
      print(response);
      if (result != null) {result(response["success"]);
      }
    });
    return callback;
  }

  /// 已集成的平台
  static Future<dynamic> activePlatforms() async {
    return await _channel.invokeMethod(ShareSDKMethods.activePlatforms.name!);
  }

  /// 获取sdk版本号
  static Future<dynamic> get sdkVersion async {
    return await _channel.invokeMethod(ShareSDKMethods.getVersion.name!);
  }

  /// 打开微信小程序
  static Future<dynamic> openWeChatMiniProgram(
      String userName, String path, int miniProgramType) async {
    Map args = {"userName": userName, "path": path, "type": miniProgramType};
    return await _channel.invokeMethod(
        ShareSDKMethods.openMiniProgram.name!, args);
  }

  /// 判断是否安装了客户端
  static Future<dynamic> isClientInstalled(ShareSDKPlatform platform) async {
    Map args = {"platform": platform.id};
    return await _channel.invokeMethod(
        ShareSDKMethods.isClientInstalled.name!, args);
  }

  static SSDKResponseState _state(Map response) {
    SSDKResponseState state = SSDKResponseState.Unknown;
    switch (response["state"]) {
      case 1:
        state = SSDKResponseState.Success;
        break;
      case 2:
        state = SSDKResponseState.Fail;
        break;
      case 3:
        state = SSDKResponseState.Cancel;
        break;
    }

    return state;
  }

  /*
   * 添加闭环分享回调监听
   */
  static addRestoreReceiver(EventHandler onEvent, EventHandler onError) {
    _channelReciever.receiveBroadcastStream().listen(onEvent, onError: onError);
  }
}
