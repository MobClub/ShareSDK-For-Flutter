package com.yoozoo.sharesdk;

public class Log {
	private static boolean isDebug = false;

	public static void e(String tag, String msg) {
		if (!isDebug) {
			return;
		}
		android.util.Log.e(tag, msg);
	}

	public static void d(String tag, String msg) {
		if (!isDebug) {
			return;
		}
		android.util.Log.d(tag, msg);
	}

	public static void setIsDebug(boolean isDebug) {
		Log.isDebug = isDebug;
	}
}
