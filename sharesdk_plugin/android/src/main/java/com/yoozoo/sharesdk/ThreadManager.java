package com.yoozoo.sharesdk;

import android.os.Handler;
import android.os.Looper;

public final class ThreadManager {

    // UI线程
    private static Handler mManinHandler;
    private static Object mMainHandlerLock = new Object();

    /**
     * 取得UI线程Handler
     * 
     * @return
     */
    public static Handler getMainHandler() {
        if (mManinHandler == null) {
            synchronized (mMainHandlerLock) {
                if (mManinHandler == null) {
                    mManinHandler = new Handler(Looper.getMainLooper());
                }
            }
        }
        return mManinHandler;
    }

}
