package com.yoozoo.sharesdk;

import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.mob.MobSDK;
import com.mob.commons.SHARESDK;
import com.mob.tools.utils.UIHandler;

import java.util.HashMap;

import cn.sharesdk.framework.Platform;
import cn.sharesdk.framework.PlatformActionListener;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.onekeyshare.OnekeyShare;
import cn.sharesdk.tencent.qq.QQ;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * SharesdkPlugin
 */
public class SharesdkPlugin implements MethodCallHandler, Handler.Callback {

    private static final String PluginMethodGetVersion = "getVersion";
    private static final String PluginMethodShare = "share";
    private static final String PluginMethodAuth = "auth";
    private static final String PluginMethodHasAuthed = "hasAuthed";
    private static final String PluginMethodCancelAuth = "cancelAuth";
    private static final String PluginMethodGetUserInfo = "getUserinfo";
    private static final String PluginMethodRegist = "regist";
    private static final String PluginMethodActivePlatforms = "activePlatforms";
    private static final String PluginMethodShowEditor = "showEditor";
    private static final String PluginMethodShowMenu = "showMenu";
    private static final String PluginMethodOpenMiniProgram = "openMiniProgram";

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.yoozoo.mob/sharesdk");
        channel.setMethodCallHandler(new SharesdkPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }

        switch (call.method) {
            case PluginMethodGetVersion:
                break;
            case PluginMethodShare:
                shareWithArgs(call, result);
                break;
            case PluginMethodAuth:
                authWithArgs(call, result);
                break;
            case PluginMethodHasAuthed:
                Log.e("SharesdkPlugin", " PluginMethodHasAuthed IOS platform only");
                //IOS only
                break;
            case PluginMethodCancelAuth:
                Log.e("SharesdkPlugin", " PluginMethodCancelAuth IOS platform only");
                //IOS only
                break;
            case PluginMethodGetUserInfo:
                getUserInfoWithArgs(call, result);
                break;
            case PluginMethodRegist:
                Log.e("SharesdkPlugin", " test " + call.method.toString() + " 核对 " + PluginMethodRegist);
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
                shareMiniProgramWithArgs(call, result);
                break;

            default:
                break;
        }
    }

    /** 分享 **/
    private void shareWithArgs(MethodCall call, Result result) {
        String imageUrl = "";
        String imagePath = "";
        String title = "";
        String text = "";
        String url = "";
        String video = "";
        String musicUrl = "";
        String fileData = "";
        String wxmpUserName = "";
        String wxmpType = "";
        String wxmpWithTicket = "";
        String wxmpPath = "";
        String type = "";


        HashMap<String, Object> map = call.arguments();
        String num = String.valueOf(map.get("platform"));

        HashMap<String, Object> params = (HashMap<String, Object>) map.get("params");

        HashMap<String, Object> platMap = (HashMap<String, Object>) params.get("@platform(" + num +")" );
        if (platMap == null) {
            imageUrl = String.valueOf(params.get("imageUrl_android"));
            imagePath = String.valueOf(params.get("imagePath_android"));
            title = String.valueOf(params.get("title"));
            text = String.valueOf(params.get("text"));
            url = String.valueOf(params.get("url"));
            video = String.valueOf(params.get("video"));
            musicUrl = String.valueOf(params.get("audio_flash_url"));
            fileData = String.valueOf(params.get("file_data"));
            wxmpUserName = String.valueOf(params.get("wxmp_user_name"));
            wxmpType = String.valueOf(params.get("wxmp_type"));
            wxmpWithTicket = String.valueOf(params.get("wxmp_with_ticket"));
            wxmpPath = String.valueOf(params.get("wxmp_path"));
            type = String.valueOf(params.get("type"));
        } else {
            imageUrl = String.valueOf(platMap.get("imageUrl_android"));
            imagePath = String.valueOf(platMap.get("imagePath_android"));
            title = String.valueOf(platMap.get("title"));
            text = String.valueOf(platMap.get("text"));
            url = String.valueOf(platMap.get("url"));
            video = String.valueOf(platMap.get("video"));
            musicUrl = String.valueOf(platMap.get("audio_flash_url"));
            fileData = String.valueOf(platMap.get("file_data"));
            wxmpUserName = String.valueOf(platMap.get("wxmp_user_name"));
            wxmpType = String.valueOf(platMap.get("wxmp_type"));
            wxmpWithTicket = String.valueOf(platMap.get("wxmp_with_ticket"));
            wxmpPath = String.valueOf(platMap.get("wxmp_path"));
            type = String.valueOf(platMap.get("type"));
        }

        String platName = Utils.platName(num);

        Platform platform = ShareSDK.getPlatform(platName);
        Platform.ShareParams shareParams = new Platform.ShareParams();
        if (!(title.equals("null") || title == null)) {
            shareParams.setTitle(title);
        }
        if (!(text.equals("null") || text == null)) {
            shareParams.setText(text);
        }
        if (!(imageUrl.equals("null") || imageUrl == null)) {
            shareParams.setImageUrl(imageUrl);
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
        if (!(wxmpType == null || wxmpType.isEmpty() || wxmpType.equals("null"))) {
            shareParams.setWxMiniProgramType(Integer.valueOf(wxmpType));
        }
        if (!(wxmpWithTicket == null || wxmpWithTicket.equals("null"))) {
            shareParams.setWxWithShareTicket(Boolean.valueOf(wxmpWithTicket));
        }
        if (!(wxmpPath == null || wxmpPath.equals("null"))) {
            shareParams.setWxPath(wxmpPath);
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
        platform.share(shareParams);
        Log.e("SharesdkPlugin", " plat " + platform + " ====> " + call.arguments.toString());
    }


    /** 分享微信小程序 **/
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

    /** 授权 **/
    private void authWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String num = String.valueOf(params.get("platform"));
        String settings = String.valueOf(params.get("settings"));

        String platStr = Utils.platName(num);
        Platform platName = ShareSDK.getPlatform(platStr);
        doAuthorize(platName);
        Log.e("SharesdkPlugin", " plat " + platName + " ====> " + call.arguments.toString());
    }

    /**
     * 授权的代码
     */
    private void doAuthorize(Platform platform) {
        if (platform != null) {
            //platform.setPlatformActionListener(myPlatformActionListener);
            if (platform.isAuthValid()) {
                platform.removeAccount(true);
                return;
            }
            platform.SSOSetting(true);
            platform.authorize();
        }
    }

    /** 分享菜单 **/
    private void showMenuWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String images = String.valueOf(params.get("images"));
        String title = String.valueOf(params.get("title"));
        String text = String.valueOf(params.get("text"));
        String url = String.valueOf(params.get("url"));
        String video = String.valueOf(params.get("video"));

        OnekeyShare oks = new OnekeyShare();
        oks.setImageUrl(images);
        oks.setTitle(title);
        oks.setText(text);
        oks.setUrl(url);

        oks.show(MobSDK.getContext());
        Log.e("SharesdkPlugin", call.arguments.toString());
    }

    /** 获得用户信息 **/
    private void getUserInfoWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String num = String.valueOf(params.get("platform"));
        String platStr = Utils.platName(num);
        Platform platName = ShareSDK.getPlatform(platStr);
        doUserInfo(platName);

        Log.e("SharesdkPlugin", " platName " + platName + " ====> " + call.arguments.toString());
    }


    private void doUserInfo(Platform platform) {
        if (platform != null) {
            platform.showUser(null);
            platform.setPlatformActionListener(new PlatformActionListener() {
                @Override
                public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
                    Message msg = new Message();
                    msg.what = 1;
                    msg.arg2 = i;
                    msg.obj = hashMap;
                    UIHandler.sendMessage(msg, SharesdkPlugin.this);
                }

                @Override
                public void onError(Platform platform, int i, Throwable throwable) {
                    Message msg = new Message();
                    msg.what = 2;
                    msg.arg2 = i;
                    msg.obj = throwable;
                    UIHandler.sendMessage(msg, SharesdkPlugin.this);
                }

                @Override
                public void onCancel(Platform platform, int i) {
                    Message msg = new Message();
                    msg.what = 3;
                    msg.arg2 = i;
                    msg.obj = platform;
                    UIHandler.sendMessage(msg, SharesdkPlugin.this);
                }
            });
        }
    }

    @Override
    public boolean handleMessage(Message msg) {
        switch (msg.what) {
            case 1: {
                onComplete(msg.arg2, (HashMap<String, Object>) msg.obj);
            } break;
            case 2: {
                onError(msg.arg2, (Throwable) msg.obj);
            } break;
            case 3: {
                onCancel(msg.arg2);
            } break;
        }
        return false;
    }

    public void onComplete(int i, HashMap<String, Object> hashMap){
        String text = StrUtils.format("", hashMap);
        Toast.makeText(MobSDK.getContext(), text, Toast.LENGTH_LONG).show();
    }

    public void onError(int i, Throwable throwable){
       String text = " caught error at " + String.valueOf(throwable);
       Toast.makeText(MobSDK.getContext(), text, Toast.LENGTH_LONG).show();
    }

    public void onCancel(int i){
        String text = " canceled ";
        Toast.makeText(MobSDK.getContext(), text, Toast.LENGTH_LONG).show();
    }
}
