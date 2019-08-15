import './sharesdk_defines.dart';

/// Model used to register the platforms
class ShareSDKRegister {
  static const String _ssdkAppkey = "app_key";
  static const String _ssdkAppId = "app_id";
  static const String _ssdkConsumerKey = "consumer_key";
  static const String _ssdkApikey = "api_key";
  static const String _ssdkClientId = "client_id";
  static const String _ssdkRestApiKey = "rest_api_key";
  static const String _ssdkApplicationId = "application_id";
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

  /// set up sina platform info
  void setupSinaWeibo(String appkey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkAppSecret: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.sina.id] = info;
  }

  /// set up wechat platform info
  void setupWechat(String appId, String appSecret) {
    Map info = {_ssdkAppId: appId, _ssdkAppSecret: appSecret};
    platformsInfo[ShareSDKPlatforms.wechatSeries.id] = info;
  }

  /// set up qq platform info
  void setupQQ(String appId, String appkey) {
    Map info = {_ssdkAppId: appId, _ssdkAppkey: appkey};
    platformsInfo[ShareSDKPlatforms.qqSeries.id] = info;
  }

  /// set up twitter platform info
  void setupTwitter(
      String consumerKey, String consumerSecret, String redirectUrl) {
    Map info = {
      _ssdkConsumerKey: consumerKey,
      _ssdkConsumerSecret: consumerSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.twitter.id] = info;
  }

  /// set up facebook platform info
  void setupFacebook(String appkey, String appSecret, String displayName) {
    Map info = {
      _ssdkApikey: appkey,
      _ssdkAppSecret: appSecret,
      _ssdkDisplayName: displayName
    };

    platformsInfo[ShareSDKPlatforms.facebook.id] = info;
  }

  /// set up TencentWeibo platform info
  void setupTencentWeibo(String appkey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkAppSecret: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.tencentWeibo.id] = info;
  }

  /// set up yixin platform info
  void setupYiXin(String appid, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkAppId: appid,
      _ssdkAppSecret: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.yixinSeries.id] = info;
  }

  /// set up evernote platform info
  void setupEvernote(String consumerKey, String consumerSecret, bool sandbox) {
    Map info = {
      _ssdkConsumerKey: consumerKey,
      _ssdkConsumerSecret: consumerSecret,
      _ssdkSandbox: sandbox
    };

    platformsInfo[ShareSDKPlatforms.yinXiang.id] = info;
  }

  /// set up douban platform info
  void setupDouBan(String apikey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkApikey: apikey,
      _ssdkAppSecret: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.douBan.id] = info;
  }

  /// set up kaixin platform info
  void setupKaiXin(String apikey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkApikey: apikey,
      _ssdkSecretKey: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.kaixin.id] = info;
  }

  /// set up pocket platform info
  void setupPocket(String consumerKey, String redirectUrl) {
    Map info = {_ssdkConsumerKey: consumerKey, _ssdkRedirectUrl: redirectUrl};

    platformsInfo[ShareSDKPlatforms.pocket.id] = info;
  }

  /// set up google+ platform info
  void setupGooglePlus(
      String clientId, String clientSecret, String redirectUrl) {
    Map info = {
      _ssdkClientId: clientId,
      _ssdkClientSecret: clientSecret,
      _ssdkRedirectUrl: redirectUrl
    };
    platformsInfo[ShareSDKPlatforms.googlePlus.id] = info;
  }

  /// set up Instagram platform info
  void setupInstagram(
      String clientId, String clientSecret, String redirectUrl) {
    Map info = {
      _ssdkClientId: clientId,
      _ssdkClientSecret: clientSecret,
      _ssdkRedirectUrl: redirectUrl
    };
    platformsInfo[ShareSDKPlatforms.instagram.id] = info;
  }

  /// set up linkedin platform info
  void setupLinkedIn(String apikey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkApikey: apikey,
      _ssdkSecretKey: appSecret,
      "redirect_url": redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.linkedIn.id] = info;
  }

  /// set up tumblr platform info
  void setupTumblr(
      String consumerKey, String consumerSecret, String redirectUrl) {
    Map info = {
      _ssdkConsumerKey: consumerKey,
      _ssdkConsumerSecret: consumerSecret,
      "callback_url": redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.tumblr.id] = info;
  }

  /// set up flick platform info
  void setupFlick(String apikey, String apiSecret) {
    Map info = {
      _ssdkApikey: apikey,
      _ssdkApiSecret: apiSecret,
    };

    platformsInfo[ShareSDKPlatforms.flickr.id] = info;
  }

  /// set up youdao platform info
  void setupYouDao(
      String consumerKey, String consumerSecret, String oauthCallback) {
    Map info = {
      _ssdkConsumerKey: consumerKey,
      _ssdkConsumerSecret: consumerSecret,
      _ssdkOAuthCallback: oauthCallback
    };

    platformsInfo[ShareSDKPlatforms.youdaoNote.id] = info;
  }

  /// set up alisocial platform info
  void setupAliSocial(String appId) {
    Map info = {
      _ssdkAppId: appId,
    };

    platformsInfo[ShareSDKPlatforms.aliSocial.id] = info;
  }

  /// set up Pinterest platform info
  void setupPinterest(String clientId) {
    Map info = {
      _ssdkClientId: clientId,
    };

    platformsInfo[ShareSDKPlatforms.pinterest.id] = info;
  }

  /// set up linkedin kakao info
  void setupKakao(String appkey, String restApiKey, String redirectUrl) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkRestApiKey: restApiKey,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.kakaoSeries.id] = info;
  }

  /// set up dropbox platform info
  void setupDropbox(String appkey, String appSecret, String redirectUrl) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkAppSecret: appSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.dropbox.id] = info;
  }

  /// set up VKontakte platform info
  void setupVKontakte(String applicationId, String secretKey) {
    Map info = {
      _ssdkApplicationId: applicationId,
      _ssdkSecretKey: secretKey,
    };

    platformsInfo[ShareSDKPlatforms.vKontakte.id] = info;
  }

  /// set up Instapaper platform info
  void setupInstapaper(String consumerKey, String consumerSecret) {
    Map info = {
      _ssdkConsumerKey: consumerKey,
      _ssdkConsumerSecret: consumerSecret,
    };

    platformsInfo[ShareSDKPlatforms.instapaper.id] = info;
  }

  /// set up DingTalk platform info
  void setupDingTalk(String appId) {
    Map info = {
      _ssdkAppId: appId,
    };

    platformsInfo[ShareSDKPlatforms.dingding.id] = info;
  }

  /// set up meipai platform info
  void setupMeiPai(String appkey) {
    Map info = {
      _ssdkAppkey: appkey,
    };

    platformsInfo[ShareSDKPlatforms.meiPai.id] = info;
  }

  /// set up youtube platform info
  void setupYouTube(String clientId, String clientSecret, String redirectUrl) {
    Map info = {
      _ssdkClientId: clientId,
      _ssdkClientSecret: clientSecret,
      _ssdkRedirectUrl: redirectUrl
    };

    platformsInfo[ShareSDKPlatforms.youtube.id] = info;
  }

  /// set up telegram platform info
  void setupTelegram(String botToken, String botDomain) {
    Map info = {
      "bot_token": botToken,
      "bot_domain": botDomain,
    };

    platformsInfo[ShareSDKPlatforms.telegram.id] = info;
  }

  /// set up reddit platform info
  void setupReddit(String appkey, String redirectUrl) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkRedirectUrl: redirectUrl,
    };

    platformsInfo[ShareSDKPlatforms.reddit.id] = info;
  }

  /// set up reddit platform info
  void setupDouyin(String appkey, String appSecret) {
    Map info = {
      _ssdkAppkey: appkey,
      _ssdkAppSecret: appSecret,
    };

    platformsInfo[ShareSDKPlatforms.douyin.id] = info;
  }
}
