package com.yoozoo.sharesdk;

import android.text.TextUtils;

public class Log {
	private static boolean isDebug = false;
	public static final String TAG = "SharesdkPlugin";

	public static void e(String tag, String msg) {
		if (!isDebug) {
			return;
		}
		if (TextUtils.isEmpty(tag)) {
			tag = TAG;
		}
		android.util.Log.e(tag, msg);
	}

	public static void d(String tag, String msg) {
		if (!isDebug) {
			return;
		}
		if (TextUtils.isEmpty(tag)) {
			tag = TAG;
		}
		android.util.Log.d(tag, msg);
	}

	public static void setIsDebug(boolean isDebug) {
		Log.isDebug = isDebug;
	}
}
