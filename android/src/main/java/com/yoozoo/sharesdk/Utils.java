package com.yoozoo.sharesdk;

import java.util.HashMap;

import cn.sharesdk.facebook.Facebook;
import cn.sharesdk.sina.weibo.SinaWeibo;
import cn.sharesdk.tencent.qq.QQ;
import cn.sharesdk.twitter.Twitter;
import cn.sharesdk.wechat.friends.Wechat;
import cn.sharesdk.wechat.moments.WechatMoments;

/**
 * Created by xiangli on 2018/11/29.
 */

public class Utils {

    public static String platName(String platId) {
        switch (platId) {
            case "1":
                return SinaWeibo.NAME;
            case "2":
                return "tencentWeibo";
            case "5":
                return "douBan";
            case "6":
                return "qZone";
            case "7":
                return "renren";
            case "8":
                return "kaixin";
            case "10":
                return Facebook.NAME;
            case "11":
                return Twitter.NAME;
            case "12":
                return "yinXiang";
            case "14":
                return "googlePlus";
            case "15":
                return "instagram";
            case "16":
                return "linkedIn";
            case "17":
                return "tumblr";
            case "18":
                return "mail";
            case "19":
                return "sms";
            case "20":
                return "print";
            case "21":
                return "copy";
            case "22":
                return Wechat.NAME;  //"wechatSession";
            case "23":
                return WechatMoments.NAME; //"wechatTimeline"
            case "24":
                return QQ.NAME;
            case "25":
                return "instapaper";
            case "26":
                return "pocket";
            case "27":
                return "youdaoNote";
            case "30":
                return "pinterest";
            case "34":
                return "flickr";
            case "35":
                return "dropbox";
            case "36":
                return "vKontakte";
            case "37":
                return "weChatFavorites";
            case "38":
                return "yixinSession";
            case "39":
                return "yixinTimeline";
            case "40":
                return "yixinFav";
            case "41":
                return "mingDao";
            case "42":
                return "line";
            case "43":
                return "whatsApp";
            case "44":
                return "kakaoTalk";
            case "45":
                return "kakaoStory";
            case "46":
                return "messenger";
            case "47":
                return "telegram";
            case "50":
                return "aliSocial";
            case "51":
                return "aliSocialTimeline";
            case "52":
                return "dingding";
            case "54":
                return "meiPai";
            case "55":
                return "cmcc";
            case "56":
                return "reddit";
            case "994":
                return "yixinSeries";
            case "995":
                return "kakaoSeries";
            case "997":
                return "wechatSeries";
            case "998":
                return "qqSeries";
        }
        return null;
    }
   public enum platParams{
       sina("SDF", 2);

       platParams(String sdf, int i) {

       }
   }

    private void initPlat(String platId, String  platName) {
        if (platName != null && platId != null) {
            HashMap<String, String> platMap = new HashMap<String, String>();
            platMap.put(platId, platName);
        }
    }


}
