package com.mob.flutter.sharesdk.impl;

import android.text.TextUtils;

import com.mob.tools.MobLog;

public class Log {
	public static final String TAG = "SharesdkPlugin";

	public static void e(String tag, String msg) {
		if (TextUtils.isEmpty(tag)) {
			tag = TAG;
		}
		MobLog.getInstance().e("TAG:" + tag + "MSG:" + msg);
	}

	public static void d(String tag, String msg) {
		if (TextUtils.isEmpty(tag)) {
			tag = TAG;
		}
		MobLog.getInstance().d("TAG:" + tag + "MSG:" + msg);
	}
}
