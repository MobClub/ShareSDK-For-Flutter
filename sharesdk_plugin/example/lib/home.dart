import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void shareSdkVersion(BuildContext context) {
    SharesdkPlugin.sdkVersion.then((dynamic version) {
      if (version.length > 0) {
        if (Platform.isIOS) {
          showAlertText("ShareSDK iOS 版本", version.toString(), context);
        } else if (Platform.isAndroid) {
          showAlertText("ShareSDK Android 版本", version.toString(), context);
        }
      } else {
        showAlertText("ShareSDK版本", "获取失败", context);
      }
    });
  }

  /// @param 隐私协议返回数据的格式
  /// POLICY_TYPE_URL = 1
  /// POLICY_TYPE_TXT = 2
  getPrivacyPolicyUrl(BuildContext context) {
    SharesdkPlugin.getPrivacyPolicy("1", "en-CN", (dynamic data, dynamic error) {
      String? policyData, errorStr;
      if (data != null) {
        policyData = data["data"];
        print("==============>policyData " + policyData!);
      }

      if (error != null) {
        errorStr = error["error"];
        print("==============>errorStr " + errorStr!);
      }

      if (policyData != null) {
        showAlertText("隐私协议", policyData, context);
      } else if (errorStr != null) {
        showAlertText("隐私协议", errorStr, context);
      } else {
        showAlertText("隐私协议", "获取隐私协议失败", context);
      }
    });
  }

  /// 0 ===> 不同意隐私政策
  /// 1 ===> 同意
  submitPrivacyGrantResult(BuildContext context) {
    SharesdkPlugin.uploadPrivacyPermissionStatus(1, (bool success) {
      if (success == true) {
        showAlertText("隐私协议授权提交结果", "成功", context);
      } else {
        showAlertText("隐私协议授权提交结果", "失败", context);
      }
    });
  }

  //微信分享文件示例
/* void shareToWechat(BuildContext context) {
   SSDKMap params = SSDKMap()
     ..setWechat(
         "title",
         "text",
         null,
         null,
         null,
         null,
         null,
         "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
         null,
         "/storage/emulated/0/Mob/cn.sharesdk.demo/cache/images/aa.jpg",
         null,
         null,
         null,
         SSDKContentTypes.file,
         ShareSDKPlatforms.wechatSession
     );

   SharesdkPlugin.share(
       ShareSDKPlatforms.wechatSession, params, (SSDKResponseState state,
       dynamic userdata, dynamic contentEntity, SSDKError error) {
     showAlert(state, error.rawData, context);
   });
 }*/

  void shareToWechat(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png"
          ],
          "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png",
          "",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.wechatSession, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareToWechatFavorite(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setWechat(
          "text",
          "title",
          "www.baidu.com",
          "",
          null,
          "",
          "",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          null,
          "",
          "",
          "",
          "",
          SSDKContentTypes.webpage,
          ShareSDKPlatforms.weChatFavorites);

    SharesdkPlugin.share(ShareSDKPlatforms.weChatFavorites, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void authToWechat(BuildContext context) {
    SharesdkPlugin.auth(ShareSDKPlatforms.wechatSession, Map(),
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void getUserInfoToWechat(BuildContext context) {
    SharesdkPlugin.getUserInfo(ShareSDKPlatforms.wechatSession,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }
  void getUserInfoToHw(BuildContext context) {
    getUserInfoByPlatform(context, ShareSDKPlatforms.hwaccount);
  }

  void getUserInfoToXm(BuildContext context) {
    getUserInfoByPlatform(context, ShareSDKPlatforms.xmaccount);
  }

  void getUserInfoByPlatform(BuildContext context, ShareSDKPlatform platform) {
    SharesdkPlugin.getUserInfo(platform,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }
  void cancelAuth(BuildContext context) {
    SharesdkPlugin.cancelAuth(ShareSDKPlatforms.wechatSession,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }
  void cancelAuthXm(BuildContext context) {
    cancelAuthByPlatform(context, ShareSDKPlatforms.xmaccount);
  }

  void cancelAuthHw(BuildContext context) {
    cancelAuthByPlatform(context, ShareSDKPlatforms.hwaccount);
  }

  void cancelAuthByPlatform(BuildContext context, ShareSDKPlatform platform) {
    SharesdkPlugin.cancelAuth(platform,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }
  void hasAuthed(BuildContext context) {
    SharesdkPlugin.hasAuthed(ShareSDKPlatforms.wechatSession,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, error.rawData , context);
    });
  }
 void hasAuthedHw(BuildContext context) {
    hasAuthedByPlatform(context, ShareSDKPlatforms.hwaccount);
  }

  void hasAuthedXm(BuildContext context) {
    hasAuthedByPlatform(context, ShareSDKPlatforms.xmaccount);
  }

  void hasAuthedByPlatform(BuildContext context, ShareSDKPlatform platform) {
    SharesdkPlugin.hasAuthed(platform,
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }
  void shareToSina(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.auto);

    SharesdkPlugin.share(ShareSDKPlatforms.sina, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void showActivityCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "闭环分享重磅上线！一键实现闭环分享！错过它，就错过了全世界~ahmn.t4m.cn/ziqMNf点击立即使用",
          null,
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          SSDKContentTypes.text);

    SharesdkPlugin.shareWithActivity(ShareSDKPlatforms.twitter, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void authToSina(BuildContext context) {
    SharesdkPlugin.getUserInfo(ShareSDKPlatforms.sina,
        (SSDKResponseState state, dynamic userdata, SSDKError error) {
      print("--------------------------> authToSina:");
      showAlert(state, userdata, context);
    });
  }

  void showShareMenu(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);
    SharesdkPlugin.showMenu(null, null, params, (SSDKResponseState state,
        ShareSDKPlatform platform,
        dynamic userData,
        dynamic contentEntity,
        SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void showEditor(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.auto);
    SharesdkPlugin.showEditor(ShareSDKPlatforms.sina, params,
        (SSDKResponseState state, ShareSDKPlatform platform, dynamic userData,
            dynamic contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void openMiniProgram(BuildContext context) {
    SharesdkPlugin.openWeChatMiniProgram(
            "gh_52568203455c", "pages/index/index", 0)
        .then((dynamic open) {
      if (open) {
        showAlert(SSDKResponseState.Success, Map(), context);
      } else {
        showAlert(SSDKResponseState.Fail, Map(), context);
      }
    });
  }

  void shareMiniProgram(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setWeChatMiniProgram(
          "MiniProgram",
          "test MiniProgram",
          "http://www.mob.com",
          "pages/index/index",
          "",
          "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "gh_afb25ac019c9",
          true,
          0,
          ShareSDKPlatforms.wechatSession);
    SharesdkPlugin.share(ShareSDKPlatforms.wechatSession, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareSinaCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setSina(
          "text",
          "title",
          [
            "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png"
          ],
          "",
          "http://www.mob.com/",
          0.0,
          0.0,
          "",
          false,
          "http://wx4.sinaimg.cn/large/006WfoFPly1fq0jo9svnaj30dw0dwdhv.jpg",
          "",
          SSDKContentTypes.auto);
    SharesdkPlugin.share(ShareSDKPlatforms.sina, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareSinaLinkCard(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setSinaLinkCard(
          "linkcard_text",
          "linkcard_title",
          "http://www.mob.com/",
          "全新品牌，优质服务",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fq0jo9svnaj30dw0dwdhv.jpg",
          "120",
          "120");
    SharesdkPlugin.share(ShareSDKPlatforms.sina, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareTwitterCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setTwitter(
          "text",
          "http://download.sdk.mob.com/web/images/2019/07/30/14/1564468183056/750_750_65.12.png",
          "",
          0.0,
          0.0,
          SSDKContentTypes.auto);
    SharesdkPlugin.share(ShareSDKPlatforms.twitter, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareFacebookCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setFacebook(
          "Share SDK Link Desc",
          "http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg",
          "http://www.mob.com",
          "Share SDK",
          "",
          "",
          "#MobData",
          "Mob官网 - 全球领先的移动开发者服务平台",
          SSDKFacebookShareTypes.native,
          SSDKContentTypes.image);
    params
      ..setFacebookAssetLocalIdentifier(
          "57C6BB71-7A69-49F3-AA05-C04F5D2829B2/L0/001",
          "asdf");
    SharesdkPlugin.share(ShareSDKPlatforms.facebook, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareFacebookMessengerCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
    ..setFacebookMessenger("Share SDK",
        "http://www.mob.com",
        "http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg",
        null, SSDKContentTypes.image);
    SharesdkPlugin.share(ShareSDKPlatforms.messenger, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }
  

  void shareQQCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setQQ(
          "text",
          "title",
          "http://m.93lj.com/sharelink?mobid=ziqMNf",
          "",
          "",
          "",
          "",
          "",
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          "",
          "",
          "http://m.93lj.com/sharelink?mobid=ziqMNf",
          "",
          "",
          SSDKContentTypes.webpage,
          ShareSDKPlatforms.qq);
    SharesdkPlugin.share(ShareSDKPlatforms.qq, params, (SSDKResponseState state,
        dynamic userdata, dynamic contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareOassisCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setOasis(
          "title",
          "text",
          null,
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          "",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.oasis, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareSnapchatCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setSnapchat(
          "https://www.mob.com",
          "http://m.93lj.com/sharelink?mobid=ziqMNf",
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          "",
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          false,
          0.3,
          false,
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.snapchat, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }


  void shareKuaiShouCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setKuaiShou(
          "title",
          "desc",
          "https://www.mob.com",
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          "",
          "",
          "57C6BB71-7A69-49F3-AA05-C04F5D2829B2/L0/001",
          List .filled(0, 0, growable: true),
          "message",
          SSDKContentTypes.message);

    SharesdkPlugin.share(ShareSDKPlatforms.kuaishou, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareToDouyinCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.douyin, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareToDouyinIMCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);
      params
        ..setDouYinShareActionMode(1);

    SharesdkPlugin.share(ShareSDKPlatforms.douyin, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }
  ///抖音分享图片
  void shareToDouyinImages(BuildContext context) {
    Map params = {KHASHTAGS: ["我的图片"], 
    kImages: ["/sdcard/Android/data/cn.sharesdk.demo/image.jpg"], 
    kType: SSDKContentTypes.image.value};

    SharesdkPlugin.shareByMap(ShareSDKPlatforms.douyin, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }
  ///抖音分享视频
 void shareToDouyinVideo(BuildContext context) {
    Map params = {KHASHTAGS: ["我的视频"], 
    KVIDEO_ARRAY: ["/sdcard/Android/data/cn.sharesdk.demo/video.mp4"], 
    kType: SSDKContentTypes.video.value};

    SharesdkPlugin.shareByMap(ShareSDKPlatforms.douyin, params,
        (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareTikTokCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.tiktok, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareKakaoTalkCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setKakaoTalk("http://www.mob.com/", "11820", {});

    SharesdkPlugin.share(ShareSDKPlatforms.kakaoTalk, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareKakaoStoryCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setKakaoStory(
          "",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "",
          "",
          0,
          1,
          {"andParam1":"value1","andParam2":"value2"},
          {"andParam1":"value1","andParam2":"value2"},
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.kakaoStory, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareInstagramCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setInstagram(
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          0,
          0);

    SharesdkPlugin.share(ShareSDKPlatforms.instagram, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareWhatsAppCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setWhatsApp(
          "Share SDK",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          null,
          null,
          0,
          0,
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.whatsApp, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareLineCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.line, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareLinkedIn(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setLinkedIn(
          "text",
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "http://www.mob.com/",
          "title",
          "Mob",
          null,
          SSDKContentTypes.webpage);

    SharesdkPlugin.share(ShareSDKPlatforms.linkedIn, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }


  void shareVK(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.vKontakte, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareTelegram(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setTelegram("text",
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          null,
          null,
          null,
          0,
          0,
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.telegram, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareFlickr(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.flickr, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void sharePocket(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.webpage);

    SharesdkPlugin.share(ShareSDKPlatforms.pocket, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void sharePinterest(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setPinterest(
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "desc",
          "",
          "ShareSDK");

    SharesdkPlugin.share(ShareSDKPlatforms.pinterest, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareReddit(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.webpage);

    SharesdkPlugin.share(ShareSDKPlatforms.reddit, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }


  void shareInstapaper(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.webpage);

    SharesdkPlugin.share(ShareSDKPlatforms.instapaper, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareDingTalk(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.dingding, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareYouDaoNote(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setYouDaoNote(
          "Share SDK",
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "title",
          "MOB",
          "mob",
          "");

    SharesdkPlugin.share(ShareSDKPlatforms.youdaoNote, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareMingDao(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.webpage);

    SharesdkPlugin.share(ShareSDKPlatforms.mingDao, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareYinXiang(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.yinXiang, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareEvernote(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.evernote, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareYiXinSession(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.yixinSession, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareYiXinMoments(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.yixinTimeline, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareYiXinFavorite(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.yiXinFav, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareSMS(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          ["http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg","http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg"],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          "",
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          "",
          SSDKContentTypes.image);

    SharesdkPlugin.share(ShareSDKPlatforms.sms, params,
            (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }


  void isClientInstalledQQ(BuildContext context) {
    SharesdkPlugin.isClientInstalled(ShareSDKPlatforms.qq)
        .then((dynamic hasClient) {
      showAlertText("是否安装了QQ客户端", hasClient.toString(), context);
    });
  }
  void authToHWAccount(BuildContext context) {
    SharesdkPlugin.auth(ShareSDKPlatforms.hwaccount, Map(),
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void authToXMAccount(BuildContext context) {
    SharesdkPlugin.auth(ShareSDKPlatforms.xmaccount, Map(),
        (SSDKResponseState state, dynamic user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }
  void showAlert(SSDKResponseState state, dynamic content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
        break;
      case SSDKResponseState.Fail:
        title = "失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消";
        break;
      default:
        title = state.toString();
        break;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(content != null ? content.toString() : ""),
                actions: <Widget>[
                  new TextButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  void showAlertText(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(content != null ? content : ""),
                actions: <Widget>[
                  new TextButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  Widget _creatRow(String methodName, String methodDes, Function method,
      BuildContext context) {
    return new GestureDetector(
      onTap: () {
        method(context);
      },
      child: new Container(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withAlpha(10),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.only(bottom: 2.0),
          children: [
            new Container(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: new Text(
                methodName,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Text(
              methodDes,
              style: new TextStyle(
                color: Colors.grey[500],
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Container(
                padding: const EdgeInsets.only(top: 0.33),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEvent(dynamic event) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    Map resMapT = event;
    Map<String, dynamic> resMap = Map<String, dynamic>.from(resMapT);
    String path = resMap['path'];
    // Map<String, dynamic> params = Map<String, dynamic>.from(resMap['params']);
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onSuccess:' + resMap.toString());
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(path),
                content: new Text(resMap.toString()),
                actions: <Widget>[
                  new TextButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  void _onError(dynamic event) {
    setState(() {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onError:' + event.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    ShareSDKRegister register = ShareSDKRegister();

    if (Platform.isIOS) {
      //ios相关代码
      register.setupWechat(
          "wx617c77c82218ea2c", "c7253e5289986cf4c4c74d1ccc185fb1", "https://70imc.share2dlink.com/");
      register.setupSinaWeibo(
          "568898243", "38a4f8204cc784f81f9f0daaf31e02e3", "http://www.sharesdk.cn", "https://70imc.share2dlink.com/");
      register.setupQQ(
          "1110451818", "OlbzvuSP3Hgj5yNS");
      register.setupDouyin(
          "awycvl19mldccyso", "8793a4dfdc3636cbda0924a3cfbc8424");
      register.setupTikTok(
          "aw3vqar8qg1oy91q", "18cf1714c53e9f9c64aec484ca4f2e29");
      register.setupFacebook(
          "1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
      register.setupTwitter(
          "viOnkeLpHBKs6KXV7MPpeGyzE", "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
      register.setupOasis("568898243");
      register.setupSnapchat("dc8e6068-0578-41b8-8392-4da009519725", "", "ssdkmoba0b0c0d0://mob");
      register.setupKuaiShou(
          "ks705657770555308030", "RQ17enXUOioeoDMrwk3j2Q", "https://70imc.share2dlink.com/");
      register.setupKakao(
          "9c17eb03317e0e627ec95a400f5785fb", "802e551a5048c3172fc1dedaaf40fcf1", "http://www.mob.com/oauth");
      register.setupInstagram(
          "1145188725813939", "256191f3abb381a9d481f6f9bbaef179", "https://www.mob.com/");
      register.setupVKontakte(
          "5312801", "ZHG2wGymmNUCRLG2r6CY");
      register.setupTelegram(
          "792340449:AAE9EZeQaXU9wq_r6X7Jalg8jITUEKYr9vw", "https://www.mob.com");
      register.setupLinkedIn(
          "75x5xdhllzno44", "uiS3nlE7XBGmTL3P", "http://mob.com");
      register.setupPocket(
          "11496-de7c8c5eb25b2c9fcdc2b627", "pocketapp1234");
      register.setupFlick(
          "cbed81d4a1bc7417693ab7865e354717", "4c490343869091f2");
      register.setupPinterest("5057854497590653616");
      register.setupReddit(
          "ObzXn50T7Cg0Xw", "https://www.mob.com/reddit_callback");
      register.setupInstapaper(
          "4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA", "GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe");
      register.setupDingTalk("dingoabcwtuab76wy0kyzo");
      register.setupDingTalkAuth(
          "dingoax9s2mdekb7a6748n", "dxx9KwP4BYN975umF6Mi2QW3jL7O3k3qHCSvcCbes5Y5R7mFF1ocd19p4NdzOKD4", "https://www.mob.com/sharesdk/dingding");
      register.setupYouDao(
          "dcde25dca105bcc36884ed4534dab940", "d98217b4020e7f1874263795f44838fe", "http://www.sharesdk.cn/");
      register.setupMingDao(
          "97230F25CA5C", "A5DC29AF7C5A5851F28E903AE9EAC0", "http://mob.com");
      register.setupEvernote(
          "46131514-6903", "08d7a6f3afcc888a", true);
      register.setupYiXin(
          "yxfddfe3934340436da964fd20885fe2a4", "574471e102e1e5d2a", "http://www.mob.com");
      register.setupSMS(false);


    } else if (Platform.isAndroid) {
      //android相关代码
      register.setupWechat("wx617c77c82218ea2c",
          "c7253e5289986cf4c4c74d1ccc185fb1", "https://bj2ks.share2dlink.com/");
      register.setupSinaWeibo("568898243", "38a4f8204cc784f81f9f0daaf31e02e3",
          "http://www.sharesdk.cn", "https://bj2ks.share2dlink.com/");
      register.setupQQ("100371282", "aed9b0303e3ed1e27bae87c33761161d");
      register.setupDouyin(
          "aw9ivykfjvi4hpwo", "42b4caa6bda60bd49f05f06d0a4956e1");
      register.setupTikTok(
          "aw3vqar8qg1oy91q", "18cf1714c53e9f9c64aec484ca4f2e29");
      register.setupFacebook(
          "1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
      register.setupTwitter(
          "viOnkeLpHBKs6KXV7MPpeGyzE",
          "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey",
          "http://mob.com");
      register.setupOasis("568898243");
      register.setupSnapchat(
          "dbe54b15-1939-4bfc-b6a0-c30a4af426a6", "", "ssdkmoba0b0c0d0://mob");
      register.setupKuaiShou("ks705657770555308030", "RQ17enXUOioeoDMrwk3j2Q",
          "https://bj2ks.share2dlink.com/");
    }
    SharesdkPlugin.regist(register);
    //SharesdkPlugin.uploadPrivacyPermissionStatus(0, getPrivacyPolicy);
    SharesdkPlugin.addRestoreReceiver(_onEvent, _onError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Plugin example app'),
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        children: <Widget>[
          _creatRow("ShareSDK版本号", "ShareSDK版本号", shareSdkVersion, context),
          _creatRow("获取隐私协议内容", "", getPrivacyPolicyUrl, context),
          _creatRow("设置同意隐私政策", "", submitPrivacyGrantResult, context),
          _creatRow("判断客户端安装", "是否安装了QQ客户端", isClientInstalledQQ, context),
          _creatRow("判断微信是否授权", "判断微信平台是否授权", hasAuthed, context),
          _creatRow("微信用户信息", "获取微信用户信息", getUserInfoToWechat, context),
          _creatRow("微信授权", "微信授权(不返回用户数据)", authToWechat, context),
          _creatRow("取消微信授权", "取消微信平台的授权", cancelAuth, context),
          _creatRow("华为用户信息", "获取华为用户信息", getUserInfoToHw, context),
          _creatRow("华为授权", "华为授权(不返回用户数据)", authToHWAccount, context),
          _creatRow("取消华为授权", "取消华为平台的授权", cancelAuthHw, context),
          _creatRow("小米用户信息", "获取小米用户信息", getUserInfoToXm, context),
          _creatRow("小米授权", "小米授权(不返回用户数据)", authToXMAccount, context),
          _creatRow("取消小米授权", "取消小米平台的授权", cancelAuthXm, context),
          _creatRow("新浪/QQ授权", "新浪/QQ授权(返回用户数据)", authToSina, context),
          _creatRow("弹出分享菜单", "弹出分享菜单", showShareMenu, context),
          _creatRow("弹出编辑界面", "分享直接进行内容编辑(IOS)", showEditor, context),
          _creatRow("分享到微信", "分享图片到微信", shareToWechat, context),
          _creatRow("分享到微信收藏", "分享网页类型到微信收藏", shareToWechatFavorite, context),
          _creatRow("分享小程序到微信", "测试自定义参数", shareMiniProgram, context),
          _creatRow("打开微信小程序", "需要导入WechatConnector", openMiniProgram, context),
          _creatRow("分享到QQ", "测试自定义参数", shareQQCustom, context),
          _creatRow("分享到新浪微博", "测试通用参数", shareToSina, context),
          _creatRow("分享到新浪微博", "测试自定义参数", shareSinaCustom, context),
          // _creatRow(
          //     "分享到新浪微博LinkCard", "分享到LinkCard", shareSinaLinkCard, context),
          _creatRow("分享图片到Facebook", "测试自定义参数", shareFacebookCustom, context),
          _creatRow("分享图片到FacebookMessenger", "测试自定义参数", shareFacebookMessengerCustom, context),
          _creatRow("分享图片到Twitter", "测试自定义参数", shareTwitterCustom, context),
          _creatRow("系统分享图片到Twitter", "测试系统分享", showActivityCustom, context),
          _creatRow("分享图片到Snapchat", "测试自定义参数", shareSnapchatCustom, context),
          _creatRow("分享图片到绿洲", "测试自定义参数", shareOassisCustom, context),
          _creatRow("分享图片到快手", "测试自定义参数", shareKuaiShouCustom, context),
          _creatRow("分享图片到抖音", "需要传入当前图片到抖音", shareToDouyinCustom, context),
          _creatRow("分享图片到抖音IM", "需要传入当前图片到抖音", shareToDouyinIMCustom, context),

          _creatRow("分享图片到TikTok", "测试自定义参数", shareTikTokCustom, context),
          _creatRow("分享链接到KakaoTalk", "测试自定义参数", shareKakaoTalkCustom, context),
          _creatRow("分享图片到KakaoStory", "测试自定义参数", shareKakaoStoryCustom, context),
          _creatRow("分享图片到Instagram", "测试自定义参数", shareInstagramCustom, context),
          _creatRow("分享图片到WhatsApp", "测试自定义参数", shareWhatsAppCustom, context),
          _creatRow("分享图片到Line", "测试自定义参数", shareLineCustom, context),
          _creatRow("分享链接到LinkedIn", "测试自定义参数", shareLinkedIn, context),
          _creatRow("分享图片到VK", "测试自定义参数", shareVK, context),
          _creatRow("分享图片到Telegram", "测试自定义参数", shareTelegram, context),
          _creatRow("分享图片到Flickr", "测试自定义参数", shareFlickr, context),
          _creatRow("分享链接到Pocket", "测试自定义参数", sharePocket, context),
          _creatRow("分享图片到Pinterest", "测试自定义参数", sharePinterest, context),
          _creatRow("分享链接到Reddit", "测试自定义参数", shareReddit, context),
          _creatRow("分享链接到Instapaper", "测试自定义参数", shareInstapaper, context),
          _creatRow("分享图片到DingTalk", "测试自定义参数", shareDingTalk, context),
          _creatRow("分享图片到YouDaoNote", "测试自定义参数", shareYouDaoNote, context),
          _creatRow("分享链接到MingDao", "测试自定义参数", shareMingDao, context),
          _creatRow("分享图片到YinXiang", "测试自定义参数", shareYinXiang, context),
          _creatRow("分享图片到Evernote", "测试自定义参数", shareEvernote, context),
          _creatRow("分享图片到易信聊天", "测试自定义参数", shareYiXinSession, context),
          _creatRow("分享图片到易信朋友圈", "测试自定义参数", shareYiXinMoments, context),
          _creatRow("分享图片到易信收藏", "测试自定义参数", shareYiXinFavorite, context),
          _creatRow("分享图片到SMS", "测试自定义参数", shareSMS, context),

        ],
      ),
    );
  }
}
