package com.yoozoo.sharesdk;

import java.util.HashMap;

/**
 * Created by xiangli on 2018/11/29.
 */

public class Utils {

    public static String platName(String platId) {
        switch (platId) {
            case "1":
                return "SinaWeibo";
            case "2":
                return "TencentWeibo";
            case "5":
                return "Douban";
            case "6":
                return "QZone";
            case "7":
                return "Renren";
            case "8":
                return "KaiXin";
            case "10":
                return "Facebook";
            case "11":
                return "Twitter";
            case "12":
                return "Evernote";
            case "14":
                return "GooglePlus";
            case "15":
                return "Instagram";
            case "16":
                return "LinkedIn";
            case "17":
                return "Tumblr";
            case "18":
                return "Email";
            case "19":
                return "ShortMessage";
           /* case "20":
                return "print";
            case "21":
                return "copy";*/
            case "22":
                return "Wechat";  //"wechatSession";
            case "23":
                return "WechatMoments"; //"wechatTimeline"
            case "24":
                return "QQ";
            case "25":
                return "Instapaper";
            case "26":
                return "Pocket";
            case "27":
                return "YouDao";
            case "30":
                return "Pinterest";
            case "34":
                return "Flickr";
            case "35":
                return "Dropbox";
            case "36":
                return "VKontakte";
            /*case "37":
                return "weChatFavorites";*/
            case "38":
                return "Yixin";
            case "39":
                return "YixinMoments";
           /* case "40":
                return "yixinFav";*/
            case "41":
                return "Mingdao";
            case "42":
                return "Line";
            case "43":
                return "WhatsApp";
            case "44":
                return "KakaoTalk";
            case "45":
                return "KakaoStory";
            case "46":
                return "FacebookMessenger";
            case "47":
                return "Telegram";
            case "50":
                return "Alipay";
            case "51":
                return "AlipayMoments";
            case "52":
                return "Dingding";
            case "54":
                return "Meipai";
            case "55":
                return "Cmcc";
            case "56":
                return "Reddit";
           /* case "994":
                return "yixinSeries";
            case "995":
                return "kakaoSeries";
            case "997":
                return "wechatSeries";
            case "998":
                return "qqSeries";*/
        }
        return null;
    }

    private void initPlat(String platId, String  platName) {
        if (platName != null && platId != null) {
            HashMap<String, String> platMap = new HashMap<String, String>();
            platMap.put(platId, platName);
        }
    }


}
