package com.yoozoo.sharesdk;

import android.app.Activity;
import android.graphics.Bitmap;
import android.text.TextUtils;

import com.mob.MobSDK;
import com.mob.OperationCallback;
import com.mob.PrivacyPolicy;
import com.mob.commons.SHARESDK;
import com.mob.tools.utils.Hashon;

import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cn.sharesdk.framework.Platform;
import cn.sharesdk.framework.PlatformActionListener;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.framework.loopshare.LoopShareResultListener;
import cn.sharesdk.onekeyshare.OnekeyShare;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

/**
 * SharesdkPlugin
 */
public class SharesdkPlugin implements MethodCallHandler {

  private static final String PluginMethodGetVersion = "getVersion";
  private static final String PluginMethodShare = "share";
  private static final String PluginMethodAuth = "auth";
  private static final String PluginMethodHasAuthed = "hasAuthed";
  private static final String PluginMethodCancelAuth = "cancelAuth";
  private static final String PluginMethodGetUserInfo = "getUserInfo";
  private static final String PluginMethodRegist = "regist";
  private static final String PluginMethodActivePlatforms = "activePlatforms";
  private static final String PluginMethodShowEditor = "showEditor";
  private static final String PluginMethodShowMenu = "showMenu";
  private static final String PluginMethodOpenMiniProgram = "openMiniProgram";
  private static final String PluginMethodIsClientInstalled = "isClientInstalled";
  //隐私协议 getPrivacyPolicy
  private static final String PluginMethodGetPrivacyPolicy = "getPrivacyPolicy";
  private static final String PluginMethodUploadPrivacyPermissionStatus = "uploadPrivacyPermissionStatus";

  private static final String EVENTCHANNEL = "SSDKRestoreReceiver";
  private static EventChannel eventChannel;
  private static EventChannel.EventSink outerEventSink;

  private static Activity activity = null;

  public static int IS_ALIVE = 123;

  private static final String TAG = "SHARESDK";


  /**
   * Plugin registration.
   */
  public static void registerWith(PluginRegistry.Registrar registrar) {
    activity = registrar.activity();

    final MethodChannel channel = new MethodChannel(registrar.messenger(),
        "com.yoozoo.mob/sharesdk");
    channel.setMethodCallHandler(new SharesdkPlugin());

    eventChannel = new EventChannel(registrar.messenger(), EVENTCHANNEL);
    eventChannel.setStreamHandler(new EventChannel.StreamHandler() {

      @Override
      public void onListen(Object o, EventChannel.EventSink eventSink) {
        if (eventSink != null) {
          outerEventSink = eventSink;
          if (IS_ALIVE != 123) {
            try {
              HashMap<String, Object> resMap = ShareSDK.getCustomDataFromLoopShare();

              HashMap<String, Object> fedbackMap = new HashMap<>();
              if (resMap.containsKey("path")) {
                fedbackMap.put("path", resMap.get("path"));
              }
              fedbackMap.put("params", resMap);
              outerEventSink.success(fedbackMap);
            } catch (Throwable t) {
              Log.e("www", " catch====> " + t);
            }

            IS_ALIVE = 123;
          }
          Log.e("WWW", "onListen ===> outerEventSink " + outerEventSink);
        } else {
          Log.e("WWW", "onListen ===> eventSink is null ");
        }

      }

      @Override
      public void onCancel(Object o) {
        Log.e("WWW", " onCancel " + " Object " + o);
      }
    });

    //setChannelId
    MobSDK.setChannel(new SHARESDK(), MobSDK.CHANNEL_FLUTTER);

    /**
     * loopshare init and set Listener
     * **/
    ShareSDK.prepareLoopShare(new LoopShareResultListener() {
      @Override
      public void onResult(Object var1) {
        String test = new Hashon().fromHashMap((HashMap<String, Object>) var1);
        Log.e("WWW", "LoopShareResultListener onResult " + test);

        if (outerEventSink != null) {

          try {
            HashMap<String, Object> resMap = (HashMap<String, Object>) var1;

            HashMap<String, Object> fedbackMap = new HashMap<>();
            if (resMap.containsKey("path")) {
              fedbackMap.put("path", resMap.get("path"));
            }
            fedbackMap.put("params", resMap);
            outerEventSink.success(fedbackMap);
          } catch (Throwable t) {
            Log.e("www", " catch====> " + t);
          }

          Log.e("WWW", "LoopShareResultListener onResult outerEventSink.success is ok");
        } else {
          Log.e("WWW", "LoopShareResultListener onResult outerEventSink is null");
        }
      }

      @Override
      public void onError(Throwable t) {
        Log.e("WWW", "LoopShareResultListener onError " + t);
      }
    });
    Log.e("WWW", " ShareSDK.prepareLoopShare() successed ");

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      switch (call.method) {
        case PluginMethodGetVersion:
          getVersion(call, result);
          break;
        case PluginMethodShare:
          shareWithArgs(call, result);
          break;
        case PluginMethodAuth:
          authWithArgs(call, result);
          break;
        case PluginMethodHasAuthed:
          hasAuthed(call, result);
          break;
        case PluginMethodCancelAuth:
          cancelAuth(call, result);
          Log.e("SharesdkPlugin", " PluginMethodCancelAuth IOS platform only");
          break;
        case PluginMethodGetUserInfo:
          getUserInfoWithArgs(call, result);
          break;
        case PluginMethodRegist:
          break;
        case PluginMethodActivePlatforms:
          //IOS only
          break;
        case PluginMethodShowEditor:
          //IOS only
          break;
        case PluginMethodShowMenu:
          showMenuWithArgs(call, result);
          break;
        case PluginMethodOpenMiniProgram:
          //shareMiniProgramWithArgs(call, result);
          openMinProgramWithArgs(call, result);
          break;
        case PluginMethodIsClientInstalled:
          isClientInstalled(call, result);
          break;
        case PluginMethodGetPrivacyPolicy: //隐私协议
          getPrivacyPolicy(call, result);
          break;
        case PluginMethodUploadPrivacyPermissionStatus:
          submitPrivacyGrantResult(call, result);
          break;
        default:
          break;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }



  private void submitPrivacyGrantResult(MethodCall call, final Result result) {
    Log.e("qqq", "====> submitPrivacyGrantResult");
    HashMap<String, Object> map = call.arguments();
    String boolStr = String.valueOf(map.get("status"));
    boolean granted;
    if (boolStr.equals("1")) { //1 代表同意
      granted = true;
    } else {
      granted = false;
    }

    MobSDK.submitPolicyGrantResult(granted, new OperationCallback<Void>() {
      @Override
      public void onComplete(Void data) {
        //success
        final Map<String, Object> map = new HashMap<>();
        String resp = String.valueOf(data);
        Log.d("qqq", "隐私协议授权结果提交：成功 " + resp);
        boolean success = true;
        map.put("success", success);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
            Log.e(TAG, "MobSDK.submitPolicyGrantResult onComplete===> " + map);
          }
        });
      }

      @Override
      public void onFailure(Throwable t) {
        final Map<String, Object> map = new HashMap<>();
        String resp = String.valueOf(t.getMessage());
        boolean fail = false;
        map.put("success", fail);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
            Log.e(TAG, "MobSDK.submitPolicyGrantResult onFailure===> " + map);
          }
        });
        Log.d("qqq", "隐私协议授权结果提交：失败" + resp);
      }
    });
  }

  //隐私协议的方法
  private void getPrivacyPolicy(MethodCall call, final Result result) {
    try {
      HashMap<String, Object> map = call.arguments();
      String type = String.valueOf(map.get("type"));
      int Type = Integer.valueOf(type);
      //String respValue = MobSDK.getPrivacyPolicy(Type);

      // 异步方法
      MobSDK.getPrivacyPolicyAsync(Type, new PrivacyPolicy.OnPolicyListener() {
        @Override
        public void onComplete(PrivacyPolicy data) {
          if (data != null) {
            Map<String, Object> map = new HashMap<>();
            HashMap<String, Object> valueMap = new HashMap<>();
            String resp = String.valueOf(data.getContent());

            valueMap.put("data", resp);
            map.put("data", valueMap);
            result.success(map);
          }
        }

        @Override
        public void onFailure(Throwable t) {
          // 请求失败
          Map<String, Object> map = new HashMap<>();
          HashMap<String, Object> valueMap = new HashMap<>();
          String resp = String.valueOf(t.getMessage());

          valueMap.put("error", resp);
          map.put("error", valueMap);
          result.success(map);
          Log.e(TAG, "隐私协议查询结果：失败 " + t);
        }
      });

    } catch (Throwable t) {
      Log.e("qqq", "getPrivacyPolicy catch===> " + t);
    }


  }

  /**
   * 获取版本
   **/
  private void getVersion(MethodCall call, Result result) {
    Map<String, Object> map = new HashMap<>();
    map.put("版本号", ShareSDK.SDK_VERSION_NAME);
    result.success(map);
  }

  /**
   * 分享
   **/
  private void shareWithArgs(MethodCall call, final Result result) {

    HashMap<String, Object> map = call.arguments();
    final String num = String.valueOf(map.get("platform"));
    final HashMap<String, Object> params = (HashMap<String, Object>) map.get("params");
    HashMap<String, Object> platMap = (HashMap<String, Object>) params
        .get("@platform(" + num + ")");
    HashMap<String, Object> dataMap = !ObjectUtils.isEmpty(platMap) ? platMap : params;
    //获取分享平台
    String platName = Utils.platName(num);
    final Platform platform = ShareSDK.getPlatform(platName);
    final Platform.ShareParams shareParams = parseParamsAndFillShareParams(dataMap,platform);
    registerShareCallBack(platform,result);
    ThreadManager.execute(new ThreadManager.SafeRunnable() {
      @Override
      public void safeRun() throws Throwable {
        platform.share(shareParams);
      }
    });
  }

  /**
   * 打开微信小程序
   **/
  private void openMinProgramWithArgs(MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();
    //int type =Integer.valueOf(map.get("type"));
    String typeStr = String.valueOf(map.get("type"));
    int type = Integer.valueOf(typeStr);
    String path = String.valueOf(map.get("path"));
    String userName = String.valueOf(map.get("userName"));

    Platform wexin = ShareSDK.getPlatform("Wechat");
    Platform.ShareParams sp = new Platform.ShareParams();
    sp.setWxUserName(userName);
    sp.setWxPath(path);
    //sp.setShareType(Platform.SHARE_WXMINIPROGRAM);
    sp.setShareType(Platform.OPEN_WXMINIPROGRAM);
    sp.setWxMiniProgramType(type);
    wexin.share(sp);

  }

  /**
   * 分享微信小程序
   **/
  private void shareMiniProgramWithArgs(MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();
    String num = String.valueOf(map.get("platform"));

    HashMap<String, Object> params = (HashMap<String, Object>) map.get("params");

    String images = String.valueOf(params.get("wxmp_hdthumbimage"));
    String title = String.valueOf(params.get("title"));
    String text = String.valueOf(params.get("text"));
    String url = String.valueOf(params.get("url"));
    String wxmpUserName = String.valueOf(params.get("wxmp_user_name"));
    //String thumbImage = String.valueOf(params.get("thumb_image"));
    String video = String.valueOf(params.get("video"));
    String musicUrl = String.valueOf(params.get("audio_flash_url"));

    String platName = Utils.platName(num);

    Platform platform = ShareSDK.getPlatform(platName);
    Platform.ShareParams shareParams = new Platform.ShareParams();
    shareParams.setTitle(title);
    shareParams.setText(text);
    shareParams.setImageUrl(images);
    shareParams.setUrl(url);
    shareParams.setWxUserName(wxmpUserName);
    shareParams.setMusicUrl(musicUrl);
    shareParams.setShareType(Platform.SHARE_WXMINIPROGRAM);

    platform.share(shareParams);
    Log.e("SharesdkPlugin", " plat " + platform + " ====> " + call.arguments.toString());
  }

  /**
   * 授权
   **/
  private void authWithArgs(MethodCall call, Result result) {
    HashMap<String, Object> params = call.arguments();
    String num = String.valueOf(params.get("platform"));

    String platStr = Utils.platName(num);
    Platform platName = ShareSDK.getPlatform(platStr);
    if ("XMAccount".equals(platStr)) {
      if (activity != null) {
        ShareSDK.setActivity(activity);
      } else {
        Log.e(TAG, "SharesdkPlugin that activity is null");
      }
    }
    doAuthorize(platName, result);
  }

  /**
   * 授权的代码,不返回数据，只返回授权成功与否的结果
   */
  private void doAuthorize(Platform platform, final Result result) {
    if (platform != null) {
      if (platform.isAuthValid()) {
        platform.removeAccount(true);
      }
      platform.setPlatformActionListener(new PlatformActionListener() {
        @Override
        public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              try {
                Map<String, Object> map = new HashMap<>();
                map.put("state", 1);
                result.success(map);
                Log.e(TAG, "doAuthorize onComplete()===> " + map);
              } catch (Throwable t) {
                Log.e(TAG, "doAuthorize onComplete() catch===> " + t);
              }
            }
          });


        }

        @Override
        public void onError(Platform platform, int i, final Throwable throwable) {
          final Map<String, Object> map = new HashMap<>();
          map.put("state", 2);
          HashMap<String, Object> errorMap = new HashMap<>();

          if (throwable.getMessage() != null) {
            errorMap.put("error", String.valueOf(throwable.getMessage()));
          } else if (throwable.getCause() != null) {
            errorMap.put("error", String.valueOf(throwable.getCause()));
          } else if (throwable != null) {
            errorMap.put("error", String.valueOf(throwable));
          }
          map.put("error", errorMap);

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              result.success(map);
              Log.e(TAG, "doAuthorize onError()===> " + map);
            }
          });

        }

        @Override
        public void onCancel(Platform platform, int i) {
          final Map<String, Object> map = new HashMap<>();
          map.put("state", 3);

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              result.success(map);
              Log.e(TAG, "doAuthorize onCancel()===> " + map);
            }
          });
        }
      });
      //platform.SSOSetting(true);
      platform.authorize();
    }
  }

  /**
   * 取消授权
   **/
  private void cancelAuth(MethodCall call, final Result result) {
    String platStr = Utils.platName(String.valueOf(call.arguments()));
    Platform platform = ShareSDK.getPlatform(platStr);

    if (platform != null) {
      if (platform.isAuthValid()) {
        platform.removeAccount(true);
        Log.e("QQQ", " 我已经取消了授权 ");
        final Map<String, Object> map = new HashMap<>();
        map.put("state", 1);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
          }
        });
      } else {
        Log.e("QQQ", " 您还没有授权，请先授权 ");
        final Map<String, Object> map = new HashMap<>();
        map.put("state", 2);
        HashMap<String, Object> errorMap = new HashMap<>();
        errorMap.put("error", "您还没有授权，请先授权");
        map.put("error", errorMap);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
          }
        });

      }
    }


  }

  /**
   * 判断是否授权
   **/
  private void hasAuthed(MethodCall call, final Result result) {
    String platStr = Utils.platName(String.valueOf(call.arguments));
    Platform platform = ShareSDK.getPlatform(platStr);
    if (platform != null) {
      if (platform.isAuthValid()) {
        final Map<String, Object> map = new HashMap<>();
        map.put("state", 1);
        HashMap<String, Object> reMap = new HashMap<>();
        reMap.put("true", "授权了");
        map.put("user", reMap);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
          }
        });

      } else {
        final Map<String, Object> map = new HashMap<>();
        map.put("state", 2);
        HashMap<String, Object> reMap = new HashMap<>();
        reMap.put("false", "没有授权");
        map.put("error", reMap);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
          }
        });
      }
    } else {
      final HashMap<String, Object> map = new HashMap<>();
      map.put("state", 2);
      HashMap<String, Object> errorMap = new HashMap<>();
      errorMap.put("error", "平台为空");
      map.put("error", errorMap);

      ThreadManager.getMainHandler().post(new Runnable() {
        @Override
        public void run() {
          result.success(map);
        }
      });
    }
  }

  /**
   * 分享菜单
   **/
  private void showMenuWithArgs(MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();
    HashMap<String, Object> params = (HashMap<String, Object>) map.get("params");
    OnekeyShare oks = new OnekeyShare();
    parseParamsAndFillShareParams(params,oks);
    registerShareCallBack(oks,result);
    oks.show(MobSDK.getContext());
    Log.e("SharesdkPlugin", call.arguments.toString());
  }

  /**
   * 获得用户信息
   **/
  private void getUserInfoWithArgs(MethodCall call, Result result) {
    HashMap<String, Object> params = call.arguments();
    String num = String.valueOf(params.get("platform"));
    String platStr = Utils.platName(num);
    Platform platName = ShareSDK.getPlatform(platStr);
    if ("XMAccount".equals(platStr)) {
      if (activity != null) {
        ShareSDK.setActivity(activity);
      } else {
        Log.e(TAG, "SharesdkPlugin that activity is null");
      }
    }
    doUserInfo(platName, result);
    Log.e("SharesdkPlugin", " platName " + platName + " ====> " + call.arguments.toString());
  }


  private void doUserInfo(Platform platform, final Result result) {
    if (platform != null) {
      platform.showUser(null);
      //add 2019.06.13
      if (platform.isAuthValid()) {
        platform.removeAccount(true);
      }

      platform.setPlatformActionListener(new PlatformActionListener() {
        @Override
        public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
          final HashMap<String, Object> userMap = new HashMap<>();
          if (ObjectUtils.isNull(hashMap)) {
            hashMap = new HashMap<>();
          }
          if (platform.getDb().exportData() != null) {
            hashMap.clear();
            hashMap.put("dbInfo", platform.getDb().exportData());
          } else {
            hashMap.put("token", platform.getDb().getToken());
          }
          userMap.put("user", hashMap);
          userMap.put("state", 1);

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              result.success(userMap);
              Log.e(TAG, "doUserInfo onComplete" + userMap);
            }
          });

        }

        @Override
        public void onError(Platform platform, int i, Throwable throwable) {
          final HashMap<String, Object> map = new HashMap<>();
          map.put("state", 2);

          HashMap<String, Object> errorMap = new HashMap<>();

          if (throwable.getMessage() != null) {
            errorMap.put("error", String.valueOf(throwable.getMessage()));
          } else if (throwable.getCause() != null) {
            errorMap.put("error", String.valueOf(throwable.getCause()));
          } else if (throwable != null) {
            errorMap.put("error", String.valueOf(throwable));
          }
          map.put("error", errorMap);

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              result.success(map);
              Log.e(TAG, "doUserInfo onError" + map);
            }
          });
        }

        @Override
        public void onCancel(Platform platform, int i) {
          final Map<String, Object> map = new HashMap<>();
          map.put("state", 3);

          ThreadManager.getMainHandler().post(new Runnable() {
            @Override
            public void run() {
              result.success(map);
              //result.error(null, null, map);
              Log.e(TAG, "doUserInfo onCancel" + map);
            }
          });
        }
      });
    }
  }

  /**
   * 判断客户端是否有效
   **/
  private void isClientInstalled(MethodCall call, final Result result) {
    HashMap<String, Object> map = call.arguments();
    String num = String.valueOf(map.get("platform"));
    String platName = Utils.platName(num);
    Platform platform = ShareSDK.getPlatform(platName);
    boolean clientValid = platform.isClientValid();
    if (clientValid) {
      final Map<String, Object> resMapSucceed = new HashMap<>();
      resMapSucceed.put("state", "installed");
      ThreadManager.getMainHandler().post(new Runnable() {
        @Override
        public void run() {
          result.success(resMapSucceed);
        }
      });
    } else {
      final Map<String, Object> resMapFail = new HashMap<>();
      resMapFail.put("state", "uninstalled");
      ThreadManager.getMainHandler().post(new Runnable() {
        @Override
        public void run() {
          result.success(resMapFail);
        }
      });
    }
  }

  /**
   * java层给flutter层发送消息,写了但是没用到，留着吧
   * **/
  // @Override
  // public void onListen(Object o, EventChannel.EventSink mEventSink) {
  //     this.eventSink = mEventSink;
  // }

  // @Override
  // public void onCancel(Object o) {

  // }

  // private void setEventChannel(Object data) {
  //     if (eventSink != null) {
  //         eventSink.success(data);
  //     } else {
  //         Log.e("FFF", " ===== FlutterEventChannel.eventSink 为空 需要检查一下 ===== ");
  //     }
  // }
  private final <Return> Return parseParam(Map<String, Object> paramMap, String key) {
    if (ObjectUtils.isEmpty(paramMap) || TextUtils.isEmpty(key)) {
      return null;
    }
    try {
      if (paramMap.containsKey(key)) {
        return (Return) paramMap.get(key);
      }
    } catch (Exception e) {
      Log.e("", e.getMessage());
    }
    return null;
  }

  /**
   * 注册分享回调
   * @param platform
   * @param result
   */
  private void registerShareCallBack(Object platform, final Result result) {
    if (ObjectUtils.isNull(platform) || ObjectUtils.isNull(result)) {
      return;
    }
    //flutter 一键分享回调，有需要平台信息
    final boolean fillPlatformInfo = (platform instanceof OnekeyShare);

    PlatformActionListener listener = new PlatformActionListener() {
      @Override
      public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
        final Map<String, Object> map = new HashMap<>();
        try {
          map.put("state", 1);
          if (fillPlatformInfo) {
            map.put("platform", platform.getId());
            map.put("name", platform.getName());
          }
        } catch (Exception e) {
          Log.e("",e.getMessage());
        }
        ThreadManager.getMainHandler().post(new ThreadManager.SafeRunnable() {
          @Override
          public void safeRun(){
            result.success(map);
            Log.e(TAG, " onComplete===> " + map);
          }
        });
      }

      @Override
      public void onError(Platform platform, int i, Throwable throwable) {
        final Map<String, Object> map = new HashMap<>();;
        try {
          map.put("state", 2);
          if (fillPlatformInfo) {
            map.put("platform", platform.getId());
            map.put("name", platform.getName());
          }
          HashMap<String, Object> errorMap = new HashMap<>();
          if (throwable.getMessage() != null) {
            errorMap.put("error", String.valueOf(throwable.getMessage()));
          } else if (throwable.getCause() != null) {
            errorMap.put("error", String.valueOf(throwable.getCause()));
          } else if (throwable != null) {
            errorMap.put("error", String.valueOf(throwable));
          }
          map.put("error", errorMap);
        } catch (Exception e) {
          Log.e("",e.getMessage());
        }

        ThreadManager.getMainHandler().post(new ThreadManager.SafeRunnable() {
          @Override
          public void safeRun() {
            result.success(map);
            Log.e(TAG, " onError===> " + map);
          }
        });
      }

      @Override
      public void onCancel(Platform platform, int i) {
        final Map<String, Object> map = new HashMap<>();
        try {
          map.put("state", 3);
          if (fillPlatformInfo) {
            map.put("platform", platform.getId());
            map.put("name", platform.getName());
          }
        } catch (Exception e) {
          Log.e("",e.getMessage());
        }
        ThreadManager.getMainHandler().post(new ThreadManager.SafeRunnable() {
          @Override
          public void safeRun() {
            result.success(map);
            Log.e(TAG, " onCancel===> " + map);
          }
        });
      }
    };
    if (platform instanceof Platform) {
      ((Platform) platform).setPlatformActionListener(listener);
    } else if (platform instanceof OnekeyShare) {
      ((OnekeyShare) platform).setCallback(listener);
    }
  }

  /**
   *
   * @param dataMap 参数
   * @param platformObject 分享平台/OnekeyShare
   */
  private <RETURN> RETURN parseParamsAndFillShareParams( HashMap<String, Object> dataMap, Object platformObject){
    Platform platform = null;
    OnekeyShare onekeyShare = null;
    if (platformObject instanceof  Platform) {
      platform = (Platform) platformObject;
    }else if (platformObject instanceof  OnekeyShare) {
      onekeyShare = (OnekeyShare) platformObject;
    }
    if (ObjectUtils.isNull(platform) && ObjectUtils.isNull(onekeyShare)) {
      return null;
    }

    String imageUrl = "";
    String imagePath = "";
    String title = "";
    String titleUrl = "";
    String text = "";
    String url = "";
    String video = "";
    String musicUrl = "";
    String fileData = "";
    String wxmpUserName = "";
    String wxmpType = "";
    String wxmpWithTicket = "";
    String wxmpPath = "";
    String videoUrl = "";
    String type = "";
    //linkcard
    String sina_summary;
    String sina_displayname;
    String image_url;
    Bitmap image_data;
    String imageX;
    String imageY;
    String site;
    String siteUrl;

    String filePath;
    String[]imageArray = null;
    //视频列表
    String[]videoArray = null;
    String[]hashTags = null;
    /*读取参数，封装分享数据*/
    imageUrl = parseParam(dataMap,Const.Key.IMAGE_URL_ANDROID);
    imagePath = parseParam(dataMap,Const.Key.IMAGE_PATH_ANDROID);
    title = parseParam(dataMap,Const.Key.TITLE);
    titleUrl = parseParam(dataMap,Const.Key.TITLE_URL_ANDROID);
    text = parseParam(dataMap,Const.Key.TEXT);;
    url = parseParam(dataMap,Const.Key.URL);
    video = parseParam(dataMap,Const.Key.VIDEO);
    musicUrl = parseParam(dataMap,Const.Key.AUDIO_FLASH_URL);
    fileData = parseParam(dataMap,Const.Key.FILE_DATA);
    wxmpUserName = parseParam(dataMap,Const.Key.WXMP_USER_NAME);
    wxmpType = parseParam(dataMap,Const.Key.WXMP_TYPE);
    wxmpWithTicket = parseParam(dataMap,Const.Key.WXMP_WITH_TICKET);
    wxmpPath =  parseParam(dataMap,Const.Key.WXMP_PATH);
    videoUrl =parseParam(dataMap,Const.Key.VIDEO_URL_ANDROID);
    Object tempType = parseParam(dataMap,Const.Key.TYPE);
    if (ObjectUtils.notNull(tempType)) {
      type = String.valueOf(tempType);
    }
    //linkcard
    sina_summary = parseParam(dataMap,Const.Key.SINA_CARD_SUMMARY);
    image_url = parseParam(dataMap,Const.Key.IMAGE_URL);
    image_data = parseParam(dataMap,Const.Key.IMAGE_DATA);;
    sina_displayname = parseParam(dataMap,Const.Key.SINA_DISPLAY_NAME);
    imageX = parseParam(dataMap,Const.Key.IMAGE_X);
    imageY =parseParam(dataMap,Const.Key.IMAGE_Y);
    site = parseParam(dataMap,Const.Key.SITE);
    siteUrl = parseParam(dataMap,Const.Key.SITE_URL);
    filePath =parseParam(dataMap,Const.Key.FILE_PATH);
    //获取分享图片数组
    if (dataMap.containsKey(Const.Key.IMAGES)) {
      Object images = dataMap.get(Const.Key.IMAGES);
      if (ObjectUtils.notNull(images)) {
        if (images instanceof ArrayList) {
          ArrayList<String> list = (ArrayList<String>) images;
          if (!ObjectUtils.isEmpty(list)) {
            imageArray = list.toArray(new String[]{});
          }
        }else if (images instanceof String && TextUtils.isEmpty(imageUrl)){
          imageUrl = (String) images;
        }
      }
    }
    if (dataMap.containsKey(Const.Key.VIDEO_ARRAY)) {//解析视频路径列表
      Object videos = dataMap.get(Const.Key.VIDEO_ARRAY);
      if (ObjectUtils.notNull(videos) && videos instanceof ArrayList) {
        ArrayList<String> list = (ArrayList<String>) videos;
        if (!ObjectUtils.isEmpty(list)) {
          videoArray = list.toArray(new String[]{});
        }
      }
    }
    if (dataMap.containsKey(Const.Key.HASHTAGS)) {//解析hashtags
      Object tags = dataMap.get(Const.Key.HASHTAGS);
      if (ObjectUtils.notNull(tags) && tags instanceof ArrayList) {
        ArrayList<String> list = (ArrayList<String>) tags;
        if (!ObjectUtils.isEmpty(list)) {
          hashTags = list.toArray(new String[]{});
        }
      }
    }

    Platform.ShareParams shareParams = null;
    if (ObjectUtils.notNull(platform)) {
      shareParams = new Platform.ShareParams();
      //抖音分享需要参数activity
      String platName = platform.getName();
      if ("Douyin".equals(platName)) {
        if (activity != null) {
          shareParams.setActivity(activity);
        } else {
          Log.e(TAG, "SharesdkPlugin that activity is null");
        }
      }
    }
    if (ObjectUtils.notNull(onekeyShare)) {
      if (activity != null) {
        onekeyShare.setActivity(activity);
      } else {
        Log.e(TAG, "SharesdkPlugin that activity is null");
      }
    }
    if (!TextUtils.isEmpty(title)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setTitle(title);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setTitle(title);
      }
    }
    if (!TextUtils.isEmpty(titleUrl)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setTitleUrl(titleUrl);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setTitleUrl(titleUrl);
      }
    }
    if (!TextUtils.isEmpty(text)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setText(text);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setText(text);
      }
    }
    if (!TextUtils.isEmpty(imageUrl)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setImageUrl(imageUrl);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setImageUrl(imageUrl);
      }
    }

    if (image_data != null) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setImageData(image_data);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setImageData(image_data);
      }
    }

    if (!TextUtils.isEmpty(imagePath)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setImagePath(imagePath);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setImagePath(imagePath);
      }
    }
    if (!TextUtils.isEmpty(url)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setUrl(url);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setUrl(url);
      }
    }
    if (!TextUtils.isEmpty(wxmpUserName)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setWxUserName(wxmpUserName);
      }
    }
    if (!TextUtils.isEmpty(musicUrl)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setMusicUrl(musicUrl);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setMusicUrl(musicUrl);
      }
    }
    if (!TextUtils.isEmpty(fileData)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setFilePath(fileData);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setFilePath(fileData);
      }
    }
    if (!TextUtils.isEmpty(filePath)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setFilePath(filePath);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setFilePath(filePath);
      }
      Log.e("WWW", " filePath===》 " + filePath);
    }

    if (!TextUtils.isEmpty(wxmpType)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setWxMiniProgramType(Integer.valueOf(wxmpType));
      }
    }
    if (!TextUtils.isEmpty(wxmpWithTicket)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setWxWithShareTicket(Boolean.valueOf(wxmpWithTicket));
      }
    }
    if (!TextUtils.isEmpty(wxmpPath)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setWxPath(wxmpPath);
      }
    }
    if (!ObjectUtils.isEmpty(imageArray)){
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setImageArray(imageArray);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setImageArray(imageArray);
      }
    }
    //linkcard
    if (!TextUtils.isEmpty(sina_summary)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setLcSummary(sina_summary);
      }

      //此参数不为空，说明用户是想分享linkcard，顺带把其他几个不需要用户输入的参数带进去
      Date date = new Date();
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
      String dateStr = simpleDateFormat.format(date);
      if (!TextUtils.isEmpty(dateStr)) {
        if (ObjectUtils.notNull(shareParams)){
          shareParams.setLcCreateAt(dateStr);
        }
      }

    }
    if (!TextUtils.isEmpty(sina_displayname)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setLcDisplayName(sina_displayname);
      }
    }
    if (!TextUtils.isEmpty(url)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setLcUrl(url);
      }
    }
    if (!TextUtils.isEmpty(type)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setLcObjectType(type);
      }
    }
    if (!TextUtils.isEmpty(image_url) && !TextUtils.isEmpty(imageX) && !TextUtils.isEmpty(imageY)) {
      JSONObject jsonObject = new JSONObject();
      try {
        jsonObject.put("url", image_url);
        jsonObject.put("width", Integer.valueOf(imageX));
        jsonObject.put("height", Integer.valueOf(imageY));
        if (ObjectUtils.notNull(shareParams)){
          shareParams.setLcImage(jsonObject);
        }
      } catch (JSONException e) {
        e.printStackTrace();
      }
    }

    if (!TextUtils.isEmpty(site)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setSite(site);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setSite(site);
      }
    }
    if (!TextUtils.isEmpty(siteUrl)) {
      shareParams.setSiteUrl(siteUrl);
    }

    if (ObjectUtils.notNull(shareParams)) {
      if (type.equals("1")) {
        shareParams.setShareType(Platform.SHARE_TEXT);
      } else if (type.equals("2")) {
        shareParams.setShareType(Platform.SHARE_IMAGE);
      } else if (type.equals("3")) {
        shareParams.setShareType(Platform.SHARE_WEBPAGE);
      } else if (type.equals("4")) {
        shareParams.setShareType(Platform.SHARE_APPS);
      } else if (type.equals("5")) {
        shareParams.setShareType(Platform.SHARE_MUSIC);
      } else if (type.equals("6")) {
        shareParams.setShareType(Platform.SHARE_VIDEO);
      } else if (type.equals("7")) {
        shareParams.setShareType(platform.SHARE_FILE);
      } else if (type.equals("10")) {
        shareParams.setShareType(Platform.SHARE_WXMINIPROGRAM);
      }
    }
    if (!ObjectUtils.isEmpty(videoArray)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setVideoPathArray(videoArray);
      }
    }
    if (!ObjectUtils.isEmpty(hashTags)) {
      if (ObjectUtils.notNull(shareParams)){
        shareParams.setHashtags(hashTags);
      }else if (ObjectUtils.notNull(onekeyShare)){
        onekeyShare.setHashtags(hashTags);
      }
    }
    if (ObjectUtils.notNull(shareParams)) {
      return (RETURN) shareParams;
    }
    return null;
  }
}
