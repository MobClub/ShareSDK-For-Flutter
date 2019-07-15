import 'package:flutter/foundation.dart';

enum SSDKResponseState { Success, Fail, Cancel, Unknown }

/// custom error
class SSDKError extends Error {
  SSDKError({this.rawData})
      : code = rawData != null ? rawData["code"] : 0,
        userInfo = rawData != null ? rawData["userInfo"] : {},
        super();
  final Map rawData;
  final int code;
  final Map userInfo;
}

/// model for method
class ShareSDKMethod {
  ShareSDKMethod({@required this.name, @required this.id})
      : assert(name != null && id != null),
        super();
  final String name;
  final int id;
}

/// method defines
class ShareSDKMethods {
  static final ShareSDKMethod getVersion =
      ShareSDKMethod(name: "getVersion", id: 0);
  static final ShareSDKMethod share = ShareSDKMethod(name: "share", id: 1);
  static final ShareSDKMethod auth = ShareSDKMethod(name: "auth", id: 2);
  static final ShareSDKMethod hasAuthed =
      ShareSDKMethod(name: "hasAuthed", id: 3);
  static final ShareSDKMethod cancelAuth =
      ShareSDKMethod(name: "cancelAuth", id: 4);
  static final ShareSDKMethod getUserInfo =
      ShareSDKMethod(name: "getUserInfo", id: 5);
  static final ShareSDKMethod regist = ShareSDKMethod(name: "regist", id: 6);
  static final ShareSDKMethod showMenu =
      ShareSDKMethod(name: "showMenu", id: 7);
  static final ShareSDKMethod showEditor =
      ShareSDKMethod(name: "showEditor", id: 8);
  static final ShareSDKMethod openMiniProgram =
      ShareSDKMethod(name: "openMiniProgram", id: 9);
  static final ShareSDKMethod activePlatforms =
      ShareSDKMethod(name: "activePlatforms", id: 10);
  static final ShareSDKMethod isClientInstalled =
      ShareSDKMethod(name: "isClientInstalled", id: 11);//只iOS支持
}

class ShareSDKPlatform {
  ShareSDKPlatform({@required this.id, @required this.name})
      : assert(id != null && name != null),
        super();
  final int id;
  final String name;
}

/// supported platform defines
class ShareSDKPlatforms {
  static final ShareSDKPlatform sina = ShareSDKPlatform(name: "sina", id: 1);
  static final ShareSDKPlatform tencentWeibo =
      ShareSDKPlatform(name: "tencentWeibo", id: 2);
  static final ShareSDKPlatform douBan =
      ShareSDKPlatform(name: "douBan", id: 5);
  static final ShareSDKPlatform qZone = ShareSDKPlatform(name: "qZone", id: 6);
  static final ShareSDKPlatform renren =
      ShareSDKPlatform(name: "renren", id: 7);
  static final ShareSDKPlatform kaixin =
      ShareSDKPlatform(name: "kaixin", id: 8);
  static final ShareSDKPlatform facebook =
      ShareSDKPlatform(name: "facebook", id: 10);
  static final ShareSDKPlatform twitter =
      ShareSDKPlatform(name: "twitter", id: 11);
  static final ShareSDKPlatform yinXiang =
      ShareSDKPlatform(name: "yinXiang", id: 12);
  static final ShareSDKPlatform googlePlus =
      ShareSDKPlatform(name: "googlePlus", id: 14);
  static final ShareSDKPlatform instagram =
      ShareSDKPlatform(name: "instagram", id: 15);
  static final ShareSDKPlatform linkedIn =
      ShareSDKPlatform(name: "linkedIn", id: 16);
  static final ShareSDKPlatform tumblr =
      ShareSDKPlatform(name: "tumblr", id: 17);
  static final ShareSDKPlatform mail = ShareSDKPlatform(name: "mail", id: 18);
  static final ShareSDKPlatform sms = ShareSDKPlatform(name: "sms", id: 19);
  static final ShareSDKPlatform print = ShareSDKPlatform(name: "print", id: 20);
  static final ShareSDKPlatform copy = ShareSDKPlatform(name: "copy", id: 21);
  static final ShareSDKPlatform wechatSession =
      ShareSDKPlatform(name: "wechatSession", id: 22);
  static final ShareSDKPlatform wechatTimeline =
      ShareSDKPlatform(name: "wechatTimeline", id: 23);
  static final ShareSDKPlatform qq = ShareSDKPlatform(name: "qq", id: 24);
  static final ShareSDKPlatform instapaper =
      ShareSDKPlatform(name: "instapaper", id: 25);
  static final ShareSDKPlatform pocket =
      ShareSDKPlatform(name: "pocket", id: 26);
  static final ShareSDKPlatform youdaoNote =
      ShareSDKPlatform(name: "youdaoNote", id: 27);
  static final ShareSDKPlatform pinterest =
      ShareSDKPlatform(name: "pinterest", id: 30);
  static final ShareSDKPlatform flickr =
      ShareSDKPlatform(name: "flickr", id: 34);
  static final ShareSDKPlatform dropbox =
      ShareSDKPlatform(name: "dropbox", id: 35);
  static final ShareSDKPlatform vKontakte =
      ShareSDKPlatform(name: "vKontakte", id: 36);
  static final ShareSDKPlatform weChatFavorites =
      ShareSDKPlatform(name: "weChatFavorites", id: 37);
  static final ShareSDKPlatform yixinSession =
      ShareSDKPlatform(name: "yixinSession", id: 38);
  static final ShareSDKPlatform yixinTimeline =
      ShareSDKPlatform(name: "yixinTimeline", id: 39);
  static final ShareSDKPlatform yiXinFav =
      ShareSDKPlatform(name: "yixinFav", id: 40);
  static final ShareSDKPlatform mingDao =
      ShareSDKPlatform(name: "mingDao", id: 41);
  static final ShareSDKPlatform line = ShareSDKPlatform(name: "line", id: 42);
  static final ShareSDKPlatform whatsApp =
      ShareSDKPlatform(name: "whatsApp", id: 43);
  static final ShareSDKPlatform kakaoTalk =
      ShareSDKPlatform(name: "kakaoTalk", id: 44);
  static final ShareSDKPlatform kakaoStory =
      ShareSDKPlatform(name: "kakaoStory", id: 45);

  static final ShareSDKPlatform messenger =
      ShareSDKPlatform(name: "messenger", id: 46);
  static final ShareSDKPlatform telegram =
      ShareSDKPlatform(name: "telegram", id: 47);

  static final ShareSDKPlatform aliSocial =
      ShareSDKPlatform(name: "aliSocial", id: 50);
  static final ShareSDKPlatform aliSocialTimeline =
      ShareSDKPlatform(name: "aliSocialTimeline", id: 51);
  static final ShareSDKPlatform dingding =
      ShareSDKPlatform(name: "dingding", id: 52);
  static final ShareSDKPlatform youtube =
      ShareSDKPlatform(name: "youtube", id: 53);
  static final ShareSDKPlatform meiPai =
      ShareSDKPlatform(name: "meiPai", id: 54);
  static final ShareSDKPlatform cmcc = ShareSDKPlatform(name: "cmcc", id: 55);
  static final ShareSDKPlatform reddit =
      ShareSDKPlatform(name: "reddit", id: 56);
  static final ShareSDKPlatform douyin =
      ShareSDKPlatform(name: "douyin", id: 59);

  static final ShareSDKPlatform yixinSeries =
      ShareSDKPlatform(name: "yixinSeries", id: 994);
  static final ShareSDKPlatform kakaoSeries =
      ShareSDKPlatform(name: "kakaoSeries", id: 995);
  static final ShareSDKPlatform evernote =
      ShareSDKPlatform(name: "evernote", id: 996);
  static final ShareSDKPlatform wechatSeries =
      ShareSDKPlatform(name: "wechatSeries", id: 997);
  static final ShareSDKPlatform qqSeries =
      ShareSDKPlatform(name: "qqSeries", id: 998);
}

/// model for contentType
class SSDKContentType {
  SSDKContentType({this.value}) : super();
  final int value;
}

/// supported share content types
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
}
