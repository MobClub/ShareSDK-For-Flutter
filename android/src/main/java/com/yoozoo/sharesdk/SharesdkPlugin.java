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
                //IOS only
                break;
            case PluginMethodCancelAuth:
                //IOS only
                break;
            case PluginMethodGetUserInfo:
                getUserInfoWithArgs(call, result);
                break;
            case PluginMethodRegist:
                Log.e("WWW", " test " + call.method.toString() + " 核对 " + PluginMethodRegist);
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
                Log.e("WWW", " test " + call.method.toString() + " 核对 " + PluginMethodOpenMiniProgram);
                break;

            default:
                break;
        }
    }

    /** 分享 **/
    private void shareWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String num = String.valueOf(params.get("platform"));
        String images = String.valueOf(params.get("images"));
        String title = String.valueOf(params.get("title"));
        String text = String.valueOf(params.get("text"));
        String url = String.valueOf(params.get("url"));
        String video = String.valueOf(params.get("video"));

        String platName = Utils.platName(num);

        Platform platform = ShareSDK.getPlatform(platName);
        Platform.ShareParams shareParams = new Platform.ShareParams();
        shareParams.setTitle(title);
        shareParams.setText(text);
        shareParams.setImageUrl(images);
        shareParams.setUrl(url);
        platform.share(shareParams);
        Log.e("WWW", " plat " + platform + " ====> " + call.arguments.toString());
    }

    /** 授权 **/
    private void authWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String num = String.valueOf(params.get("platform"));
        String settings = String.valueOf(params.get("settings"));

        String platStr = Utils.platName(num);
        Platform platName = ShareSDK.getPlatform(platStr);
        doAuthorize(platName);
        Log.e("WWW", " plat " + platName + " ====> " + call.arguments.toString());
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
        Log.e("WWW", call.arguments.toString());
    }

    /** 获得用户信息 **/
    private void getUserInfoWithArgs(MethodCall call, Result result) {
        HashMap<String, Object> params = call.arguments();
        String num = String.valueOf(params.get("platform"));
        String platStr = Utils.platName(num);
        Platform platName = ShareSDK.getPlatform(platStr);
        doUserInfo(platName);

        Log.e("WWW", " platName " + platName + " ====> " + call.arguments.toString());

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
