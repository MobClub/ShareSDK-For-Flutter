package com.mob.sharesdk_plugin_example;

import com.yoozoo.sharesdk.FlutterLoopSharePrepare;
import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication  {

    @Override
    public void onCreate() {
        super.onCreate();
        FlutterLoopSharePrepare flutterLoopSharePrepare = new FlutterLoopSharePrepare();
        flutterLoopSharePrepare.prepare(this, MainActivity.class);

        //ShareSDK.prepareLoopShare(new SharesdkPlugin.LoopshareListener());

    }

}
