package com.mob.flutter.sharesdk.impl;

import java.util.HashMap;

import cn.sharesdk.framework.Platform;

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
            case "37":
                return "WechatFavorite";
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
            case "53":
                return "Youtube";
            case "54":
                return "Meipai";
            case "55":
                return "Cmcc";
            case "56":
                return "Reddit";
            case "59":
                return "Douyin";
            case "60":
                return "Wework";
            case "63":
                return "HWAccount";
            case "64":
                return "Oasis";
            case "65":
                return "XMAccount";
            case "66":
                return "Snapchat";
            case "67":
                return "Littleredbook";
            case "68":
                return "Kuaishou";
            case "69":
                return "Watermelonvideo";
            case "70":
                return "Tiktok";
            case "71":
                return "Taptap";
            case "72":
                return "HonorAccount";
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


    public static int getShareType(String type,int shareAction) {
        int shareType = 0;
        switch (type) {
            case "1":
                shareType = Platform.SHARE_TEXT;
                break;
            case "2":
                shareType = Platform.SHARE_IMAGE;
                if (1 == shareAction) {
                    shareType = Platform.SHARE_DYIM_IMG;
                }
                break;
            case "3":
                shareType = Platform.SHARE_WEBPAGE;
                if (1 == shareAction) {
                    shareType = Platform.SHARE_DYIM_WEBPAGE;
                }
                break;
            case "4":
                shareType = Platform.SHARE_APPS;
                break;
            case "5":
                shareType = Platform.SHARE_MUSIC;
                break;
            case "6":
                shareType = Platform.SHARE_VIDEO;
                break;
            case "7":
                shareType = Platform.SHARE_FILE;
                break;
            case "10":
                shareType = Platform.SHARE_WXMINIPROGRAM;
                break;
            case "12":
                shareType = Platform.OPEN_WXMINIPROGRAM;
                break;
	        case "13":
		        shareType = Platform.INSTAGRAM_FRIEND;
		        break;
	        case "14":
		        shareType = Platform.QQ_MINI_PROGRAM;
		        break;
	        case "15":
		        shareType = Platform.KAKAO_FEED_TEMPLATE;
		        break;
	        case "16":
		        shareType = Platform.KAKAO_URL_TEMPLATE;
		        break;
	        case "17":
		        shareType = Platform.KAKAO_COMMERCE_TEMPLATE;
		        break;
	        case "18":
		        shareType = Platform.KAKAO_TEXT_TEMPLATE;
		        break;
	        case "19":
		        shareType = Platform.KAKAO_CUSTOM_TEMPLATE;
		        break;
	        case "20":
		        shareType = Platform.OPEN_QQMINIPROGRAM;
		        break;
	        case "21":
		        shareType = Platform.DY_MIXFILE;
		        break;
        }
        return shareType;
    }

    private void initPlat(String platId, String  platName) {
        if (platName != null && platId != null) {
            HashMap<String, String> platMap = new HashMap<String, String>();
            platMap.put(platId, platName);
        }
    }


}
