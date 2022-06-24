import './sharesdk_defines.dart';

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
	static const String _ssdkAppUniversalLink = "app_universalLink";
	static const String _ssdkclientIdUnsafe = "client_id_unsafe";
	static const String _ssdkOpen_countryList = "open_countryList";
	final Map platformsInfo = Map();
	static const String _ssdkCorp_id = "corp_id";
	static const String _ssdkAgent_id = "agent_id";

	void setupSinaWeibo(String appkey, String appSecret, String redirectUrl, String universalLink) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl,
			_ssdkAppUniversalLink: universalLink
		};

		platformsInfo[ShareSDKPlatforms.sina.id] = info;
	}

	void setupWechat(String appId, String appSecret, String appUniversalLink) {
		Map info = {
			_ssdkAppId: appId,
			_ssdkAppSecret: appSecret,
			_ssdkAppUniversalLink: appUniversalLink
		};
		platformsInfo[ShareSDKPlatforms.wechatSeries.id] = info;
	}

	void setupQQ(String appId, String appkey) {
		Map info = {_ssdkAppId: appId, _ssdkAppkey: appkey};
		platformsInfo[ShareSDKPlatforms.qqSeries.id] = info;
	}

	void setupWework(String schema, String appKey, String agentId, String appSecret) {
		Map info = {
			_ssdkAppkey: schema,
			_ssdkCorp_id: appKey,
			_ssdkAgent_id: agentId,
			_ssdkAppSecret: appSecret
		};

		platformsInfo[ShareSDKPlatforms.wework.id] = info;
	}

	void setupTwitter(String consumerKey, String consumerSecret, String redirectUrl) {
		Map info = {
			_ssdkConsumerKey: consumerKey,
			_ssdkConsumerSecret: consumerSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.twitter.id] = info;
	}

	void setupFacebook(String appkey, String appSecret, String displayName) {
		Map info = {
			_ssdkApikey: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkDisplayName: displayName
		};

		platformsInfo[ShareSDKPlatforms.facebook.id] = info;
	}

	void setupSnapchat(String appkey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkclientIdUnsafe: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.snapchat.id] = info;
	}

	void setupTencentWeibo(String appkey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.tencentWeibo.id] = info;
	}

	void setupMingDao(String appKey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkAppkey: appKey,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.mingDao.id] = info;
	}

	void setupYiXin(String appid, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkAppId: appid,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.yixinSeries.id] = info;
	}

	void setupEvernote(String consumerKey, String consumerSecret, bool sandbox) {
		Map info = {
			_ssdkConsumerKey: consumerKey,
			_ssdkConsumerSecret: consumerSecret,
			_ssdkSandbox: sandbox
		};
		platformsInfo[ShareSDKPlatforms.yinXiang.id] = info;
	}

	void setupDouBan(String apikey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkApikey: apikey,
			_ssdkAppSecret: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.douBan.id] = info;
	}

	void setupKaiXin(String apikey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkApikey: apikey,
			_ssdkSecretKey: appSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.kaixin.id] = info;
	}

	void setupPocket(String consumerKey, String redirectUrl) {
		Map info = {_ssdkConsumerKey: consumerKey, _ssdkRedirectUrl: redirectUrl};

		platformsInfo[ShareSDKPlatforms.pocket.id] = info;
	}

	void setupGooglePlus(String clientId, String clientSecret, String redirectUrl) {
		Map info = {
			_ssdkClientId: clientId,
			_ssdkClientSecret: clientSecret,
			_ssdkRedirectUrl: redirectUrl
		};
		platformsInfo[ShareSDKPlatforms.googlePlus.id] = info;
	}

	void setupInstagram(String clientId, String clientSecret, String redirectUrl) {
		Map info = {
			_ssdkClientId: clientId,
			_ssdkClientSecret: clientSecret,
			_ssdkRedirectUrl: redirectUrl
		};
		platformsInfo[ShareSDKPlatforms.instagram.id] = info;
	}

	void setupLinkedIn(String apikey, String appSecret, String redirectUrl) {
		Map info = {
			_ssdkApikey: apikey,
			_ssdkSecretKey: appSecret,
			"redirect_url": redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.linkedIn.id] = info;
	}

	void setupTumblr(String consumerKey, String consumerSecret, String redirectUrl) {
		Map info = {
			_ssdkConsumerKey: consumerKey,
			_ssdkConsumerSecret: consumerSecret,
			"callback_url": redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.tumblr.id] = info;
	}

	void setupFlick(String apikey, String apiSecret) {
		Map info = {
			_ssdkApikey: apikey,
			_ssdkApiSecret: apiSecret
		};

		platformsInfo[ShareSDKPlatforms.flickr.id] = info;
	}

	void setupYouDao(String consumerKey, String consumerSecret, String oauthCallback) {
		Map info = {
			_ssdkConsumerKey: consumerKey,
			_ssdkConsumerSecret: consumerSecret,
			_ssdkOAuthCallback: oauthCallback
		};

		platformsInfo[ShareSDKPlatforms.youdaoNote.id] = info;
	}

	void setupAliSocial(String appId) {
		Map info = {
			_ssdkAppId: appId
		};

		platformsInfo[ShareSDKPlatforms.aliSocial.id] = info;
	}

	void setupPinterest(String clientId) {
		Map info = {
			_ssdkClientId: clientId,
		};

		platformsInfo[ShareSDKPlatforms.pinterest.id] = info;
	}

	void setupKakao(String appkey, String restApiKey, String redirectUrl) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkRestApiKey: restApiKey,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.kakaoSeries.id] = info;
	}

	void setupDropbox(String appkey, String appSecret, String oauthCallback) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkOAuthCallback: oauthCallback
		};

		platformsInfo[ShareSDKPlatforms.dropbox.id] = info;
	}

	void setupVKontakte(String applicationId, String secretKey) {
		Map info = {
			_ssdkApplicationId: applicationId,
			_ssdkSecretKey: secretKey
		};
		platformsInfo[ShareSDKPlatforms.vKontakte.id] = info;
	}

	void setupInstapaper(String consumerKey, String consumerSecret) {
		Map info = {
			_ssdkConsumerKey: consumerKey,
			_ssdkConsumerSecret: consumerSecret
		};

		platformsInfo[ShareSDKPlatforms.instapaper.id] = info;
	}

	void setupDingTalk(String appId) {
		Map info = {
			_ssdkAppId: appId
		};

		if (platformsInfo[ShareSDKPlatforms.dingding.id] == null) {
			platformsInfo[ShareSDKPlatforms.dingding.id] = info;
		} else {
			Map param = platformsInfo[ShareSDKPlatforms.dingding.id];
			info.addEntries(param.entries);
			platformsInfo[ShareSDKPlatforms.dingding.id] = info;
		}
	}

	void setupDingTalkAuth(String appId, String appSecret, String redirectUrl) {
		Map info = {
			"auth"+_ssdkAppId: appId,
			"auth"+_ssdkAppSecret: appSecret,
			"auth"+_ssdkRedirectUrl: redirectUrl
		};

		if (platformsInfo[ShareSDKPlatforms.dingding.id] == null) {
			platformsInfo[ShareSDKPlatforms.dingding.id] = info;
		} else {
			Map param = platformsInfo[ShareSDKPlatforms.dingding.id];
			info.addEntries(param.entries);
			platformsInfo[ShareSDKPlatforms.dingding.id] = info;
		}
	}

	void setupMeiPai(String appkey) {
		Map info = {
			_ssdkAppkey: appkey
		};
		platformsInfo[ShareSDKPlatforms.meiPai.id] = info;
	}

	void setupYouTube(String clientId, String clientSecret, String redirectUrl) {
		Map info = {
			_ssdkClientId: clientId,
			_ssdkClientSecret: clientSecret,
			_ssdkRedirectUrl: redirectUrl
		};

		platformsInfo[ShareSDKPlatforms.youtube.id] = info;
	}

	void setupTelegram(String botToken, String botDomain) {
		Map info = {
			"bot_token": botToken,
			"bot_domain": botDomain
		};
		platformsInfo[ShareSDKPlatforms.telegram.id] = info;
	}

	void setupReddit(String appkey, String redirectUrl) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkRedirectUrl: redirectUrl
		};
		platformsInfo[ShareSDKPlatforms.reddit.id] = info;
	}

	void setupDouyin(String appkey, String appSecret) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkAppSecret: appSecret
		};

		platformsInfo[ShareSDKPlatforms.douyin.id] = info;
	}

	void setupKuaiShou(String appkey, String appSecret, String appUniversalLink) {
		Map info = {
			_ssdkAppId: appkey,
			_ssdkAppSecret: appSecret,
			_ssdkAppUniversalLink: appUniversalLink
		};

		platformsInfo[ShareSDKPlatforms.kuaishou.id] = info;
	}

	void setupTikTok(String appkey, String appSecret) {
		Map info = {
			_ssdkAppkey: appkey,
			_ssdkAppSecret: appSecret,
		};

		platformsInfo[ShareSDKPlatforms.tiktok.id] = info;
	}

	void setupOasis(String appkey) {
		Map info = {
			_ssdkAppkey: appkey
		};
		platformsInfo[ShareSDKPlatforms.oasis.id] = info;
	}

	void setupSMS(bool openCountryList) {
		Map info = {
			_ssdkOpen_countryList: openCountryList
		};
		platformsInfo[ShareSDKPlatforms.sms.id] = info;
	}
}