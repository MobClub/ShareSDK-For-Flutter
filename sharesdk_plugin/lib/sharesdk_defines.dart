import 'package:flutter/foundation.dart';

enum SSDKResponseState { Success, Fail, Cancel, Unknown }

class SSDKError extends Error {
  final dynamic? rawData;
  final int? code;
  final dynamic? userInfo;

  SSDKError({this.rawData})
      : code = rawData != null ? rawData["code"] : 0,
        userInfo = rawData != null ? rawData["userInfo"] : {},
        super();
}

class ShareSDKMethod {
  final String? name;
  final int? id;

  ShareSDKMethod({@required this.name, @required this.id})
      : assert(name != null && id != null),
        super();
}

class ShareSDKMethods {
  static final ShareSDKMethod getVersion =
      ShareSDKMethod(name: 'getVersion', id: 0);
  static final ShareSDKMethod share = ShareSDKMethod(name: 'share', id: 1);
  static final ShareSDKMethod auth = ShareSDKMethod(name: 'auth', id: 2);
  static final ShareSDKMethod hasAuthed =
      ShareSDKMethod(name: 'hasAuthed', id: 3);
  static final ShareSDKMethod cancelAuth =
      ShareSDKMethod(name: 'cancelAuth', id: 4);
  static final ShareSDKMethod getUserInfo =
      ShareSDKMethod(name: 'getUserInfo', id: 5);
  static final ShareSDKMethod regist = ShareSDKMethod(name: 'regist', id: 6);
  static final ShareSDKMethod showMenu =
      ShareSDKMethod(name: 'showMenu', id: 7);
  static final ShareSDKMethod showEditor =
      ShareSDKMethod(name: 'showEditor', id: 8);
  static final ShareSDKMethod openMiniProgram =
      ShareSDKMethod(name: 'openMiniProgram', id: 9);
  static final ShareSDKMethod activePlatforms =
      ShareSDKMethod(name: 'activePlatforms', id: 10);
  static final ShareSDKMethod isClientInstalled =
      ShareSDKMethod(name: 'isClientInstalled', id: 11);
  static final ShareSDKMethod uploadPrivacyPermissionStatus =
      ShareSDKMethod(name: 'uploadPrivacyPermissionStatus', id: 12);
  static final ShareSDKMethod setAllowShowPrivacyWindow =
      ShareSDKMethod(name: 'setAllowShowPrivacyWindow', id: 13);
  static final ShareSDKMethod getPrivacyPolicy =
      ShareSDKMethod(name: 'getPrivacyPolicy', id: 14);
  static final ShareSDKMethod setPrivacyUI =
      ShareSDKMethod(name: 'setPrivacyUI', id: 15);
  static final ShareSDKMethod shareWithActivity =
      ShareSDKMethod(name: 'shareWithActivity', id: 16);
  static final ShareSDKMethod getSharedFilePath =
      ShareSDKMethod(name: 'targetFilePath', id: 17);
}

class ShareSDKPlatform {
  final String? name;
  final int? id;

  ShareSDKPlatform({@required this.id, @required this.name})
      : assert(id != null && name != null),
        super();
}

class ShareSDKPlatforms {
  static final ShareSDKPlatform sina = ShareSDKPlatform(name: 'sina', id: 1);
  static final ShareSDKPlatform tencentWeibo =
      ShareSDKPlatform(name: 'tencentWeibo', id: 2);
  static final ShareSDKPlatform douBan =
      ShareSDKPlatform(name: 'douBan', id: 5);
  static final ShareSDKPlatform qZone = ShareSDKPlatform(name: 'qZone', id: 6);
  static final ShareSDKPlatform renren =
      ShareSDKPlatform(name: 'renren', id: 7);
  static final ShareSDKPlatform kaixin =
      ShareSDKPlatform(name: 'kaixin', id: 8);
  static final ShareSDKPlatform facebook =
      ShareSDKPlatform(name: 'facebook', id: 10);
  static final ShareSDKPlatform twitter =
      ShareSDKPlatform(name: 'twitter', id: 11);
  static final ShareSDKPlatform yinXiang =
      ShareSDKPlatform(name: 'yinXiang', id: 12);
  static final ShareSDKPlatform googlePlus =
      ShareSDKPlatform(name: 'googlePlus', id: 14);
  static final ShareSDKPlatform instagram =
      ShareSDKPlatform(name: 'instagram', id: 15);
  static final ShareSDKPlatform linkedIn =
      ShareSDKPlatform(name: 'linkedIn', id: 16);
  static final ShareSDKPlatform tumblr =
      ShareSDKPlatform(name: 'tumblr', id: 17);
  static final ShareSDKPlatform mail = ShareSDKPlatform(name: 'mail', id: 18);
  static final ShareSDKPlatform sms = ShareSDKPlatform(name: 'sms', id: 19);
  static final ShareSDKPlatform print = ShareSDKPlatform(name: 'print', id: 20);
  static final ShareSDKPlatform copy = ShareSDKPlatform(name: 'copy', id: 21);
  static final ShareSDKPlatform wechatSession =
      ShareSDKPlatform(name: 'wechatSession', id: 22);
  static final ShareSDKPlatform wechatTimeline =
      ShareSDKPlatform(name: 'wechatTimeline', id: 23);
  static final ShareSDKPlatform qq = ShareSDKPlatform(name: 'qq', id: 24);
  static final ShareSDKPlatform instapaper =
      ShareSDKPlatform(name: 'instapaper', id: 25);
  static final ShareSDKPlatform pocket =
      ShareSDKPlatform(name: 'pocket', id: 26);
  static final ShareSDKPlatform youdaoNote =
      ShareSDKPlatform(name: 'youdaoNote', id: 27);
  static final ShareSDKPlatform pinterest =
      ShareSDKPlatform(name: 'pinterest', id: 30);
  static final ShareSDKPlatform flickr =
      ShareSDKPlatform(name: 'flickr', id: 34);
  static final ShareSDKPlatform dropbox =
      ShareSDKPlatform(name: 'dropbox', id: 35);
  static final ShareSDKPlatform vKontakte =
      ShareSDKPlatform(name: 'vKontakte', id: 36);
  static final ShareSDKPlatform weChatFavorites =
      ShareSDKPlatform(name: 'weChatFavorites', id: 37);
  static final ShareSDKPlatform yixinSession =
      ShareSDKPlatform(name: 'yixinSession', id: 38);
  static final ShareSDKPlatform yixinTimeline =
      ShareSDKPlatform(name: 'yixinTimeline', id: 39);
  static final ShareSDKPlatform yiXinFav =
      ShareSDKPlatform(name: 'yiXinFav', id: 40);
  static final ShareSDKPlatform mingDao =
      ShareSDKPlatform(name: 'mingDao', id: 41);
  static final ShareSDKPlatform line = ShareSDKPlatform(name: 'line', id: 42);
  static final ShareSDKPlatform whatsApp =
      ShareSDKPlatform(name: 'whatsApp', id: 43);
  static final ShareSDKPlatform kakaoTalk =
      ShareSDKPlatform(name: 'kakaoTalk', id: 44);
  static final ShareSDKPlatform kakaoStory =
      ShareSDKPlatform(name: 'kakaoStory', id: 45);
  static final ShareSDKPlatform messenger =
      ShareSDKPlatform(name: 'messenger', id: 46);
  static final ShareSDKPlatform telegram =
      ShareSDKPlatform(name: 'telegram', id: 47);
  static final ShareSDKPlatform aliSocial =
      ShareSDKPlatform(name: 'aliSocial', id: 50);
  static final ShareSDKPlatform aliSocialTimeline =
      ShareSDKPlatform(name: 'aliSocialTimeline', id: 51);
  static final ShareSDKPlatform dingding =
      ShareSDKPlatform(name: 'dingding', id: 52);
  static final ShareSDKPlatform youtube =
      ShareSDKPlatform(name: 'youtube', id: 53);
  static final ShareSDKPlatform meiPai =
      ShareSDKPlatform(name: 'meiPai', id: 54);
  static final ShareSDKPlatform cmcc = ShareSDKPlatform(name: 'cmcc', id: 55);
  static final ShareSDKPlatform reddit =
      ShareSDKPlatform(name: 'reddit', id: 56);
  static final ShareSDKPlatform douyin =
      ShareSDKPlatform(name: 'douyin', id: 59);
  static final ShareSDKPlatform wework =
      ShareSDKPlatform(name: 'wework', id: 60);
  static final ShareSDKPlatform apple = ShareSDKPlatform(name: 'apple', id: 61);
  static final ShareSDKPlatform hwaccount =
      ShareSDKPlatform(name: 'HWAccount', id: 63);
  static final ShareSDKPlatform oasis = ShareSDKPlatform(name: 'oasis', id: 64);
  static final ShareSDKPlatform xmaccount =
      ShareSDKPlatform(name: 'XMAccount', id: 65);
  static final ShareSDKPlatform snapchat =
      ShareSDKPlatform(name: 'snapchat', id: 66);
  static final ShareSDKPlatform xhs = ShareSDKPlatform(name: 'xhs', id: 67);
  static final ShareSDKPlatform kuaishou =
      ShareSDKPlatform(name: 'kuaishou', id: 68);
  static final ShareSDKPlatform watermelonvideo =
      ShareSDKPlatform(name: 'watermelonvideo', id: 69);
  static final ShareSDKPlatform tiktok =
      ShareSDKPlatform(name: 'tiktok', id: 70);
  static final ShareSDKPlatform yixinSeries =
      ShareSDKPlatform(name: 'yixinSeries', id: 994);
  static final ShareSDKPlatform kakaoSeries =
      ShareSDKPlatform(name: 'kakaoSeries', id: 995);
  static final ShareSDKPlatform evernote =
      ShareSDKPlatform(name: 'evernote', id: 996);
  static final ShareSDKPlatform wechatSeries =
      ShareSDKPlatform(name: 'wechatSeries', id: 997);
  static final ShareSDKPlatform qqSeries =
      ShareSDKPlatform(name: 'qqSeries', id: 998);
}

class SSDKFacebookShareType {
  final int? value;

  SSDKFacebookShareType({this.value}) : super();
}

class SSDKFacebookShareTypes extends Object {
  static SSDKFacebookShareType get native => SSDKFacebookShareType(value: 1);

  static SSDKFacebookShareType get sheet => SSDKFacebookShareType(value: 2);
}

class SSDKContentType {
  final int? value;

  SSDKContentType({this.value}) : super();
}

class SSDKContentTypes extends Object {
  static SSDKContentType get auto => SSDKContentType(value: 0);

  static SSDKContentType get text => SSDKContentType(value: 1);

  static SSDKContentType get image => SSDKContentType(value: 2);

  static SSDKContentType get webpage => SSDKContentType(value: 3);

  static SSDKContentType get app => SSDKContentType(value: 4);

  static SSDKContentType get audio => SSDKContentType(value: 5);

  static SSDKContentType get video => SSDKContentType(value: 6);

  static SSDKContentType get file => SSDKContentType(value: 7);

  static SSDKContentType get miniProgram => SSDKContentType(value: 10);

  static SSDKContentType get message => SSDKContentType(value: 11);

  static SSDKContentType get open_wxMiniProgram => SSDKContentType(value: 12);

  static SSDKContentType get instagram_friend => SSDKContentType(value: 13);

  static SSDKContentType get qq_miniProgram => SSDKContentType(value: 14);

  static SSDKContentType get kakao_feed_template => SSDKContentType(value: 15);

  static SSDKContentType get kakao_url_template => SSDKContentType(value: 16);

  static SSDKContentType get kakao_commerce_template => SSDKContentType(value: 17);

  static SSDKContentType get kakao_text_template => SSDKContentType(value: 18);

  static SSDKContentType get kakao_custom_template => SSDKContentType(value: 19);

  static SSDKContentType get open_qqMiniProgram => SSDKContentType(value: 20);

  static SSDKContentType get dy_mixFile => SSDKContentType(value: 21);
}
