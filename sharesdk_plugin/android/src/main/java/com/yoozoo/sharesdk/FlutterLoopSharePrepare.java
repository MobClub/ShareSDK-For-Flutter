package com.yoozoo.sharesdk;

import android.content.Context;
import android.content.Intent;

import com.mob.tools.utils.Hashon;

import java.util.HashMap;

import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.framework.loopshare.LoopShareResultListener;

import static com.yoozoo.sharesdk.SharesdkPlugin.IS_ALIVE;

public class FlutterLoopSharePrepare {

    public static final String LOOPSHARE_NEWS = "loopsharenews";

    public void prepare(final Context context, final Class<?> targetActivity) {
        /**
         * loopshare init and set Listener
         * **/
        ShareSDK.prepareLoopShare(new LoopShareResultListener() {
            @Override
            public void onResult(Object var1) {
                String test = new Hashon().fromHashMap((HashMap<String, Object>) var1);
                Log.e("WWW", "LoopShareResultListener onResult " + test);

                Log.e("WWW", "SP的数据=====》 " + ShareSDK.getCustomDataFromLoopShare());

                Intent intent = new Intent();
                intent.setClass(context, targetActivity);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(intent);
                IS_ALIVE = 456;
            }

            @Override
            public void onError(Throwable t) {
                Log.e("WWW", "LoopShareResultListener onError " + t);
            }
        });
    }
}
