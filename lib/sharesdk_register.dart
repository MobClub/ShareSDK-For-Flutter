import './sharesdk_defines.dart';

class ShareSDKRegister
{
  static const String _ssdkAppkey = "app_key";
  static const String _ssdkAppId = "app_id";
  static const String _ssdkConsumerKey = "consumer_key";
  static const String _ssdkApikey = "api_key";
  static const String _ssdkClientId = "client_id";
  static const String _ssdkRestApiKey= "rest_api_key";
  static const String _ssdkApplicationId= "application_id";
  static const String _ssdkClientSecret = "client_secret";
  static const String _ssdkConsumerSecret = "consumer_secret";
  static const String _ssdkAppSecret = "app_secret";
  static const String _ssdkSecretKey = "secret_key";
  static const String _ssdkApiSecret = "api_secret";
  static const String _ssdkRedirectUrl = "redirect_uri";
  static const String _ssdkOAuthCallback = "oauth_callback";
  static const String _ssdkDisplayName = "display_name";
  static const String _ssdkSandbox = "sandbox_mode";

  final Map platformsInfo = {};

  void setupSinaWeibo(String appkey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkAppkey:appkey,
      _ssdkAppSecret:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.sina.id] = info;
  }

  void setupWechat(String appId, String appSecret)
  {
    Map info = {
      _ssdkAppId:appId,
      _ssdkAppSecret:appSecret
    };
    platformsInfo[ShareSDKPlatforms.wechatSeries.id] = info;
  }

  void setupQQ(String appId, String appkey)
  {
    Map info = {
      _ssdkAppId:appId,
      _ssdkAppkey:appkey
    };
    platformsInfo[ShareSDKPlatforms.qqSeries.id] = info;
  }

  void setupTwitter(String consumerKey, String consumerSecret, String redirectUrl)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkConsumerSecret:consumerSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.twitter.id] = info;
  }

  void setupFacebook(String appkey, String appSecret, String displayName)
  {
    Map info = {
      _ssdkApikey:appkey,
      _ssdkAppSecret:appSecret,
      _ssdkDisplayName:displayName
    };

    platformsInfo[ShareSDKPlatforms.facebook.id] = info;
  }

  void setupTencentWeibo(String appkey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkAppkey:appkey,
      _ssdkAppSecret:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.tencentWeibo.id] = info;
  }

  void setupYiXin(String appid, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkAppId:appid,
      _ssdkAppSecret:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.yixinSeries.id] = info;
  }

  void setupEvernote(String consumerKey, String consumerSecret, bool sandbox)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkConsumerSecret:consumerSecret,
      _ssdkSandbox:sandbox
    };

    platformsInfo[ShareSDKPlatforms.yinXiang.id] = info;
  }

  void setupDouBan(String apikey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkApikey:apikey,
      _ssdkAppSecret:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.douBan.id] = info;
  }

  void setupKaiXin(String apikey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkApikey:apikey,
      _ssdkSecretKey:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.kaixin.id] = info;
  } 

  void setupPocket(String consumerKey, String redirectUrl)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.pocket.id] = info;
  }

  void setupGooglePlus(String clientId, String clientSecret, String redirectUrl)
  {
    Map info = {
      _ssdkClientId:clientId,
      _ssdkClientSecret:clientSecret,
      _ssdkRedirectUrl:redirectUrl
    };
    platformsInfo[ShareSDKPlatforms.googlePlus.id] = info;
  }

  void setupInstagram(String clientId, String clientSecret, String redirectUrl)
  {
        Map info = {
      _ssdkClientId:clientId,
      _ssdkClientSecret:clientSecret,
      _ssdkRedirectUrl:redirectUrl
    };
    platformsInfo[ShareSDKPlatforms.instagram.id] = info;
  }

 void setupLinkedIn(String apikey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkApikey:apikey,
      _ssdkSecretKey:appSecret,
      "redirect_url":redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.linkedIn.id] = info;
  }

  void setupTumblr(String consumerKey, String consumerSecret, String redirectUrl)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkConsumerSecret:consumerSecret,
      "callback_url":redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.tumblr.id] = info;
  }

  void setupFlick(String apikey, String apiSecret)
  {
    Map info = {
      _ssdkApikey:apikey,
      _ssdkApiSecret:apiSecret,
    };

    platformsInfo[ShareSDKPlatforms.flickr.id] = info;
  }

  void setupYouDao(String consumerKey, String consumerSecret, String oauthCallback)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkConsumerSecret:consumerSecret,
      _ssdkOAuthCallback:oauthCallback
    };

    platformsInfo[ShareSDKPlatforms.youdaoNote.id] = info;
  }

  void setupAliSocial(String appId)
  {
    Map info = {
      _ssdkAppId:appId,
    };

    platformsInfo[ShareSDKPlatforms.aliSocial.id] = info;
  }

   void setupPinterest(String clientId)
  {
    Map info = {
      _ssdkClientId:clientId,
    };

    platformsInfo[ShareSDKPlatforms.pinterest.id] = info;
  }

  void setupKakao(String appkey, String restApiKey, String redirectUrl)
  {
    Map info = {
      _ssdkAppkey:appkey,
      _ssdkRestApiKey:restApiKey,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.kakaoSeries.id] = info;
  }

  void setupDropbox(String appkey, String appSecret, String redirectUrl)
  {
    Map info = {
      _ssdkAppkey:appkey,
      _ssdkAppSecret:appSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.dropbox.id] = info;
  }

   void setupVKontakte(String applicationId, String secretKey)
  {
    Map info = {
      _ssdkApplicationId:applicationId,
      _ssdkSecretKey:secretKey,
    };

    platformsInfo[ShareSDKPlatforms.vKontakte.id] = info;
  }

  void setupInstapaper(String consumerKey, String consumerSecret)
  {
    Map info = {
      _ssdkConsumerKey:consumerKey,
      _ssdkConsumerSecret:consumerSecret,
    };

    platformsInfo[ShareSDKPlatforms.instapaper.id] = info;
  }

  void setupDingTalk(String appId)
  {
    Map info = {
      _ssdkAppId:appId,
    };

    platformsInfo[ShareSDKPlatforms.dingding.id] = info;
  }

  void setupMeiPai(String appkey)
  {
    Map info = {
      _ssdkAppkey:appkey,
    };

    platformsInfo[ShareSDKPlatforms.meiPai.id] = info;
  }

  void setupYouTube(String clientId, String clientSecret, String redirectUrl)
  {
    Map info = {
      _ssdkClientId:clientId,
      _ssdkClientSecret:clientSecret,
      _ssdkRedirectUrl:redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.youtube.id] = info;
  }

    void setupTelegram(String botToken, String botDomain)
  {
    Map info = {
      "bot_token":botToken,
      "bot_domain":botDomain,
    };

    platformsInfo[ShareSDKPlatforms.telegram.id] = info;
  }

  void setupReddit(String appkey, String redirectUrl)
  {
    Map info = {
      _ssdkAppkey:appkey,
      _ssdkRedirectUrl:redirectUrl,
    };

    platformsInfo[ShareSDKPlatforms.reddit.id] = info;
  }
}