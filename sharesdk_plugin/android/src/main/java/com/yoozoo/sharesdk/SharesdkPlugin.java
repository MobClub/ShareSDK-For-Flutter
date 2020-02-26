package com.yoozoo.sharesdk;

import android.app.Activity;
import android.graphics.Bitmap;
import android.text.TextUtils;
import android.util.Log;
import com.mob.MobSDK;
import com.mob.OperationCallback;
import com.mob.PrivacyPolicy;
import com.mob.commons.SHARESDK;
import com.mob.commons.dialog.entity.MobPolicyUi;
import com.mob.tools.utils.Hashon;

import java.util.ArrayList;
import java.util.List;
import org.json.JSONException;
import org.json.JSONObject;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cn.sharesdk.framework.Platform;
import cn.sharesdk.framework.PlatformActionListener;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.framework.loopshare.LoopShareResultListener;
import cn.sharesdk.onekeyshare.OnekeyShare;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;
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
  private static final String PluginMethodSetAllowShowPrivacyWindow = "setAllowShowPrivacyWindow";
  private static final String PluginMethodSetPrivacyUI = "setPrivacyUI";

  private static final String EVENTCHANNEL = "SSDKRestoreReceiver";
  private static EventChannel eventChannel;
  private static EventChannel.EventSink outerEventSink;

  private static Activity activity = null;

  private static final String TAG = "SHARESDK";


  /**
   * Plugin registration.
   */
  public static void registerWith(PluginRegistry.Registrar registrar) {
    //SharesdkPlugin instance = new SharesdkPlugin();

    activity = registrar.activity();

    final MethodChannel channel = new MethodChannel(registrar.messenger(),
        "com.yoozoo.mob/sharesdk");
    channel.setMethodCallHandler(new SharesdkPlugin());

    //eventChannel = new EventChannel(registrar.messenger(), EVENTCHANNEL);
    //eventChannel.setStreamHandler(new SharesdkPlugin());
    eventChannel = new EventChannel(registrar.messenger(), EVENTCHANNEL);
    Log.e("WWW", " eventChannel " + eventChannel);
    eventChannel.setStreamHandler(new EventChannel.StreamHandler() {

      @Override
      public void onListen(Object o, EventChannel.EventSink eventSink) {
        Log.e("WWW", " onListen " + " Object " + o + " eventSink " + eventSink);
        if (eventSink != null) {
          outerEventSink = eventSink;
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
          HashMap<String, Object> map = new HashMap<>();
          map.put("innerMapOneKey", "innerMapOneValue");
          map.put("innerMapTwoKey", "innerMapTwoValue");

          HashMap<String, Object> outer = new HashMap<String, Object>();
          outer.put("path", "outPathValue");
          outer.put("params", map);
          outerEventSink.success(outer);
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
        Log.e("SharesdkPlugin", " Android no need this method, Please use gradle set ");
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
      case PluginMethodSetAllowShowPrivacyWindow:
        setAllowDialog(call, result);
        break;
      case PluginMethodSetPrivacyUI:
        setPrivacyUI(call, result);
        break;
      default:
        break;
    }
  }

  //设置隐私二次弹框的UI
  private void setPrivacyUI(MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();

    String backColorStr = String.valueOf(map.get("backColor"));
    int backColorInt = Integer.valueOf(backColorStr);
    Log.e("qqq", "设置弹框背景色资源ID " + backColorInt);

    List<Integer> oprationButtonColors = new ArrayList<>();
    oprationButtonColors = (List<Integer>) map.get("oprationButtonColors");

    int PositiveBtnColorId = -1;
    int NegativeBtnColorId = -1;

    if (oprationButtonColors.size() >= 1) {
      PositiveBtnColorId = oprationButtonColors.get(0);
      Log.e("qqq", "设置同意按钮背景色资源ID " + PositiveBtnColorId);
    }
    if (oprationButtonColors.size() >= 2) {
      NegativeBtnColorId = oprationButtonColors.get(1);
      Log.e("qqq", "设置拒绝按钮背景色资源ID " + NegativeBtnColorId);
    }


    MobPolicyUi mobPolicyUi = new MobPolicyUi.Builder()
        // 设置弹框背景色资源ID
        .setBackgroundColorId(backColorInt)
        // 设置同意按钮背景色资源ID
        .setPositiveBtnColorId(PositiveBtnColorId)
        // 设置拒绝按钮背景色资源ID
        .setNegativeBtnColorId(NegativeBtnColorId)
        .build();
    // 需在使用SDK接口前调用，否则不生效
    MobSDK.setPolicyUi(mobPolicyUi);

    Log.e("qqq", "设置隐私二次弹框的UI完成 ");
  }

  //设置是否同意二次弹框
  private void setAllowDialog(MethodCall call, Result result) {
    //Log.e("qqq", "====> setAllowDialog");
    HashMap<String, Object> map = call.arguments();
    String boolStr = String.valueOf(map.get("show"));
    int boolInt = Integer.valueOf(boolStr);
    if (boolInt == 1) {
      MobSDK.setAllowDialog(true);
      Log.e("qqq", " 同意隐私二次弹框 ");
    } else {
      MobSDK.setAllowDialog(false);
      Log.e("qqq", " 不同意隐私二次弹框 ");

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
    map.put("版本号", "3.7.1");
    result.success(map);
  }

  /**
   * 分享
   **/
  private void shareWithArgs(MethodCall call, final Result result) {
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

    HashMap<String, Object> map = call.arguments();
    final String num = String.valueOf(map.get("platform"));

    final HashMap<String, Object> params = (HashMap<String, Object>) map.get("params");

    HashMap<String, Object> platMap = (HashMap<String, Object>) params
        .get("@platform(" + num + ")");
    if (platMap == null) {
      imageUrl = String.valueOf(params.get("imageUrl_android"));
      imagePath = String.valueOf(params.get("imagePath_android"));
      title = String.valueOf(params.get("title"));
      titleUrl = String.valueOf(params.get("titleUrl_android"));
      text = String.valueOf(params.get("text"));
      url = String.valueOf(params.get("url"));
      video = String.valueOf(params.get("video"));
      musicUrl = String.valueOf(params.get("audio_flash_url"));
      fileData = String.valueOf(params.get("file_data"));
      wxmpUserName = String.valueOf(params.get("wxmp_user_name"));
      wxmpType = String.valueOf(params.get("wxmp_type"));
      wxmpWithTicket = String.valueOf(params.get("wxmp_with_ticket"));
      wxmpPath = String.valueOf(params.get("wxmp_path"));
      videoUrl = String.valueOf(params.get("videoUrl_android"));
      type = String.valueOf(params.get("type"));
      //linkcard
      sina_summary = String.valueOf(params.get("sina_cardSummary"));
      image_url = String.valueOf(params.get("image_url"));
      image_data = (Bitmap) params.get("imageData");

      imageX = String.valueOf(params.get("image_x"));
      imageY = String.valueOf(params.get("image_y"));
      sina_displayname = String.valueOf(params.get("sina_displayname"));
      site = String.valueOf(params.get("site"));
      siteUrl = String.valueOf(params.get("siteUrl"));

      filePath = String.valueOf(params.get("filePath"));

    } else {
      imageUrl = String.valueOf(platMap.get("imageUrl_android"));
      imagePath = String.valueOf(platMap.get("imagePath_android"));
      title = String.valueOf(platMap.get("title"));
      titleUrl = String.valueOf(platMap.get("titleUrl_android"));
      text = String.valueOf(platMap.get("text"));
      url = String.valueOf(platMap.get("url"));
      video = String.valueOf(platMap.get("video"));
      musicUrl = String.valueOf(platMap.get("audio_flash_url"));
      fileData = String.valueOf(platMap.get("file_data"));
      wxmpUserName = String.valueOf(platMap.get("wxmp_user_name"));
      wxmpType = String.valueOf(platMap.get("wxmp_type"));
      wxmpWithTicket = String.valueOf(platMap.get("wxmp_with_ticket"));
      wxmpPath = String.valueOf(platMap.get("wxmp_path"));
      videoUrl = String.valueOf(platMap.get("videoUrl_android"));
      type = String.valueOf(platMap.get("type"));
      //linkcard
      sina_summary = String.valueOf(platMap.get("sina_cardSummary"));
      image_url = String.valueOf(platMap.get("image_url"));
      image_data = (Bitmap) platMap.get("imageData");

      sina_displayname = String.valueOf(platMap.get("sina_displayname"));
      imageX = String.valueOf(platMap.get("image_x"));
      imageY = String.valueOf(platMap.get("image_y"));
      site = String.valueOf(platMap.get("site"));
      siteUrl = String.valueOf(platMap.get("siteUrl"));

      filePath = String.valueOf(platMap.get("filePath"));

    }

    String platName = Utils.platName(num);

    Platform platform = ShareSDK.getPlatform(platName);
    Platform.ShareParams shareParams = new Platform.ShareParams();

    if (platName.equals("Douyin")) {
      if (activity != null) {
        shareParams.setActivity(activity);
      } else {
        Log.e(TAG, "SharesdkPlugin that activity is null");
      }
    }

    if (!(title.equals("null") || title == null)) {
      shareParams.setTitle(title);
    }
    if (!(titleUrl.equals("null") || titleUrl == null)) {
      shareParams.setTitleUrl(titleUrl);
    }
    if (!(text.equals("null") || text == null)) {
      shareParams.setText(text);
    }
    if (!(imageUrl.equals("null") || imageUrl == null)) {
      shareParams.setImageUrl(imageUrl);
    }

    if (image_data != null) {
      if (!(image_data.equals("null"))) {
        shareParams.setImageData(image_data);
      }
    }

    if (!(imagePath.equals("null") || imagePath == null)) {
      shareParams.setImagePath(imagePath);
    }
    if (!(url.equals("null") || url == null)) {
      shareParams.setUrl(url);
    }
    if (!(wxmpUserName.equals("null") || wxmpUserName == null)) {
      shareParams.setWxUserName(wxmpUserName);
    }
    if (!(musicUrl.equals("null") || musicUrl == null)) {
      shareParams.setMusicUrl(musicUrl);
    }
    if (!(fileData.equals("null") || fileData == null)) {
      shareParams.setFilePath(fileData);
    }
    if (!(filePath.equals("null") || filePath == null)) {
      shareParams.setFilePath(filePath);
      Log.e("WWW", " filePath===》 " + filePath);
    }

    if (!(wxmpType == null || wxmpType.isEmpty() || wxmpType.equals("null"))) {
      shareParams.setWxMiniProgramType(Integer.valueOf(wxmpType));
    }
    if (!(wxmpWithTicket == null || wxmpWithTicket.equals("null"))) {
      shareParams.setWxWithShareTicket(Boolean.valueOf(wxmpWithTicket));
    }
    if (!(wxmpPath == null || wxmpPath.equals("null"))) {
      shareParams.setWxPath(wxmpPath);
    }
    //linkcard
    if (!(sina_summary == null || sina_summary.equals("null"))) {
      shareParams.setLcSummary(sina_summary);
      //此参数不为空，说明用户是想分享linkcard，顺带把其他几个不需要用户输入的参数带进去
      Date date = new Date();
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
      String dateStr = simpleDateFormat.format(date);
      if (dateStr != null) {
        shareParams.setLcCreateAt(dateStr);
      }

    }
    if (!(sina_displayname == null || sina_displayname.equals("null"))) {
      shareParams.setLcDisplayName(sina_displayname);
    }
    if (!(url.equals("null") || url == null)) {
      shareParams.setLcUrl(url);
    }
    if (!(type.equals("null") || type == null)) {
      shareParams.setLcObjectType(type);
    }
    if (!(image_url == null || image_url.equals("null"))) {
      if (!(imageX == null || imageX.equals("null"))) {
        if (!(imageY == null || imageY.equals("null"))) {
          JSONObject jsonObject = new JSONObject();
          try {
            jsonObject.put("url", image_url);
            jsonObject.put("width", Integer.valueOf(imageX));
            jsonObject.put("height", Integer.valueOf(imageY));
            shareParams.setLcImage(jsonObject);
          } catch (JSONException e) {
            e.printStackTrace();
          }
        }
      }
    }

    if (!(site.equals("null") || site == null)) {
      shareParams.setSite(site);
    }
    if (!(siteUrl.equals("null") || siteUrl == null)) {
      shareParams.setSiteUrl(siteUrl);
    }

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
    platform.setPlatformActionListener(new PlatformActionListener() {
      @Override
      public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
        final Map<String, Object> map = new HashMap<>();
        map.put("state", 1);

        ThreadManager.getMainHandler().post(new Runnable() {
          @Override
          public void run() {
            result.success(map);
            Log.e(TAG, " onComplete===> " + map);
          }
        });
      }

      @Override
      public void onError(Platform platform, int i, Throwable throwable) {
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
            Log.e(TAG, " onError===> " + map);
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
            Log.e(TAG, " onCancel===> " + map);
          }
        });
      }
    });
    platform.share(shareParams);
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
    String images = String.valueOf(params.get("images"));
    String title = String.valueOf(params.get("title"));
    String text = String.valueOf(params.get("text"));
    String url = String.valueOf(params.get("url"));
    String video = String.valueOf(params.get("video"));

    String titleUrl = String.valueOf(params.get("titleUrl_android"));
    String musciUrl = String.valueOf(params.get("musicUrl_android"));
    String imageUrlAndroid = String.valueOf(params.get("imageUrl_android"));
    String imagePath = String.valueOf(params.get("imagePath_android"));
    String videoUrl = String.valueOf(params.get("videoUrl_android"));

    OnekeyShare oks = new OnekeyShare();
    if ((!TextUtils.isEmpty(title)) && !(title.equals("null"))) {
      oks.setTitle(title);
    }

    if ((!TextUtils.isEmpty(text)) && !(text.equals("null"))) {
      oks.setText(text);
    }

    if ((!TextUtils.isEmpty(url)) && !(url.equals("null"))) {
      oks.setUrl(url);
    }

    if ((!TextUtils.isEmpty(titleUrl)) && !(titleUrl.equals("null"))) {
      oks.setTitleUrl(titleUrl);
    }

    if ((!TextUtils.isEmpty(musciUrl)) && !(musciUrl.equals("null"))) {
      oks.setMusicUrl(musciUrl);
    }

    if ((!TextUtils.isEmpty(imageUrlAndroid)) && !(imageUrlAndroid.equals("null"))) {
      oks.setImageUrl(imageUrlAndroid);
    }

    if ((!TextUtils.isEmpty(imagePath)) && !(imagePath.equals("null"))) {
      oks.setImagePath(imagePath);
    }

    if ((!TextUtils.isEmpty(videoUrl)) && !(videoUrl.equals("null"))) {
      oks.setVideoUrl(videoUrl);
    }
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
}
