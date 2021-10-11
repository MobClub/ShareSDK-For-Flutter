package com.yoozoo.sharesdk;

import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import cn.sharesdk.framework.utils.SSDKLog;

public final class ThreadManager {
    private static final ExecutorService service = Executors.newSingleThreadExecutor();

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
    public static final void execute(SafeRunnable runnable){
        if (null == service){
            return;
        }
        service.execute(runnable);
    }
    public static abstract class SafeRunnable implements Runnable {

        @Override
        final public void run() {
            try {
                if (!TextUtils.isEmpty(threadName())) {
                    Thread.currentThread().setName(threadName());
                }
                safeRun();
            } catch (Throwable e) {
                try {
                    error(e);
                } catch (Throwable t) {
                    // ignore
                }
                Log.e("",e.getMessage());
            }
        }

        public abstract void safeRun() throws Throwable;

        /**
         * 如果有异常需要在catch里处理，实现这个方法
         *
         * @param e
         */
        public void error(Throwable e) {

        }

        /**
         * 改变线程的名称
         *
         * @return
         */
        public String threadName() {
            return "";
        }
    }

}
