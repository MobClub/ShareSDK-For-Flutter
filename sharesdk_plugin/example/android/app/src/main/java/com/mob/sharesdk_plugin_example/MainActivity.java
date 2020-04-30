package com.mob.sharesdk_plugin_example;

import android.os.Bundle;
import android.util.Log;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Log.e("WWW", " ================example android MainActivity  onCreate");
  }

  @Subscribe(threadMode = ThreadMode.MAIN)
  public void onReceiveMsg(String message) {
    Log.e("WWW", "MainActivity =============> " + message);
  }

}
