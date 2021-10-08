package com.mob.sharesdk_plugin_example;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  // @Override
  // protected void onCreate(Bundle savedInstanceState) {
  //   super.onCreate(savedInstanceState);
  //   GeneratedPluginRegistrant.registerWith(this);
  //   Log.e("WWW", " ================example android MainActivity  onCreate");
  // }


	@Override
	public void configureFlutterEngine(FlutterEngine flutterEngine){
		GeneratedPluginRegistrant.registerWith(flutterEngine);
	}

}
