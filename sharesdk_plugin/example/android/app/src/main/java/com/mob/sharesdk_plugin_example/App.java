package com.mob.sharesdk_plugin_example;

import android.util.Log;

import com.bytedance.sdk.account.open.aweme.share.Share;
import com.yoozoo.sharesdk.FlutterLoopSharePrepare;
import com.yoozoo.sharesdk.SharesdkPlugin;

import cn.sharesdk.framework.ShareSDK;
import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication  {

    @Override
    public void onCreate() {
        super.onCreate();
        Log.e("WWW", "App onCreate" );

        FlutterLoopSharePrepare flutterLoopSharePrepare = new FlutterLoopSharePrepare();
        flutterLoopSharePrepare.prepare(this, MainActivity.class);

        //ShareSDK.prepareLoopShare(new SharesdkPlugin.LoopshareListener());

    }

}
