import './sharesdk_defines.dart';

/// const
const String kText = "text";
const String kThumbImage = "thumb_image";
const String kImages = "images";
const String kImageUrlAndroid = "imageUrl_android";
const String kImagePathAndroid = "imagePath_android";
const String kUrl = "url";
const String kType = "type";
const String kLat = "lat";
const String kLong = "long";
const String kTitle = "title";
const String kAudioUrl = "audio_url";
const String kExtension = "ext_info";
const String kFile = "file_data";
const String kEmoticon = "emoticon_data";
const String kWeChatScene = "wechat_scene";
const String kWeiboObjectId = "object_id";
const String kWeiboIsStory = "sina_isStory";
const String kAttachments = "attachments";
const String kRecipients = "recipients";
const String kCCRecipients = "cc_recipients";
const String kBCCRecipients = "bcc_recipients";
const String kDesc = "desc";
const String kAlbumId = "album_id";
const String kTags = "tags";
const String kTweetId = "tweet_id";
const String kDeepLinkId = "deep_link_id";
const String kMenuDisplayX = "menu_display_x";
const String kMenuDisplayY = "menu_display_y";
const String kVisibility = "visibility";
const String kBlogName = "blog_name";
const String kIsPublic = "is_public";
const String kIsFriend = "is_friend";
const String kIsFamily = "is_family";
const String kSafetyLevel = "safety_level";
const String kContentType = "content_type";
const String kHidden = "hidden";
const String kAudio = "audio";
const String kVideo = "video";
const String kSource = "source";
const String kAuthor = "author";
const String kNoteBook = "notebook";
const String kBoard = "board";
const String kPermission = "permission";
const String kTemplateId = "templateId";
const String kTemplateArgs = "templateArgs";
const String kEnableShare = "enable_share";
const String kAndroidExecParam = "android_exec_param";
const String kIPhoneExecParam = "iphone_exec_param";
const String kGroupId = "group_id";
const String kPrivateFromSource = "private_from_source";
const String kFolderId = "folder_id";
const String kResolveFinalUrl = "resolve_final_url";
const String kComment = "comment";
const String kUid = "uid";
const String kWeChatFile = "source_file";
const String kWeChatFileExtension = "source_extension";
const String kAudioFlashURL = "audio_flash_url";
const String kVideoFlashURL = "video_flash_url";
const String kVideoAssetURL = "video_asset_url";
const String kURLName = "url_name";
const String kPrivacyStatus = "privacy_status";
const String kYouTubeParts = "youtube_parts";
const String kYouTubeJsonString = "youtube_json_string";

const String kWXMPUserName = "wxmp_user_name";
const String kWXMPPath = "wxmp_path";
const String kWXMPWithTicket = "wxmp_with_ticket";
const String kWXMPType = "wxmp_type";
const String kWXMPHdThumbImage = "wxmp_hdthumbimage";

const String kFacebookHashtag = "facebook_hashtag";
const String kFacebookQuote = "facebook_quote";

/// Set sharing parameters map
class SSDKMap {
  final Map map = {};

  /// Set common share parameters
  void setGeneral(
      String text,
      dynamic images,
      String imageUrlAndroid,
      String imagePathAndroid,
      String url,
      String title,
      SSDKContentType contentType) {
    map[kType] = contentType.value;
    map[kText] = text;
    map[kTitle] = title;
    map[kImages] = images;
    map[kUrl] = url;
    map[kImageUrlAndroid] = imageUrlAndroid;
    map[kImagePathAndroid] = imagePathAndroid;
  }

  /// Set wechat platform share parameters
  void setWechat(
      String text,
      String title,
      String url,
      String thumbImage,
      dynamic images,
      String musicFileURL,
      String extInfo,
      String fileData,
      String emoticonData,
      String fileExtension,
      String sourceFileData,
      SSDKContentType contentType,
      ShareSDKPlatform subPlatform) {
    Map params = {};
    params[kType] = contentType.value;
    params[kText] = text;
    params[kTitle] = title;
    params[kUrl] = url;
    params[kThumbImage] = thumbImage;
    params[kImages] = images;
    params[kAudioUrl] = musicFileURL;
    params[kExtension] = extInfo;
    params[kFile] = fileData;
    params[kWeChatFileExtension] = fileExtension;
    params[kWeChatFile] = sourceFileData;
    params[kEmoticon] = emoticonData;

    int id = subPlatform.id;
    map["@platform($id)"] = params;
  }

  /// Set wechat mini program share parameters
  void setWeChatMiniProgram(
      String title,
      String desc,
      String webUrl,
      String path,
      String thumbImage,
      String hdThumbImage,
      String imageUrlAndroid,
      String userName,
      bool withShareTicket,
      int miniProgramType,
      ShareSDKPlatform subPlatform) {
    Map params = {};
    params[kType] = SSDKContentTypes.miniProgram.value;
    params[kTitle] = title;
    params[kUrl] = webUrl;
    params[kWXMPUserName] = userName;
    params[kWXMPPath] = path;
    params[kThumbImage] = thumbImage;
    params[kWXMPHdThumbImage] = hdThumbImage;
    params[kWXMPType] = miniProgramType;
    params[kWXMPWithTicket] = withShareTicket;
    params[kImageUrlAndroid] = imageUrlAndroid;

    int id = subPlatform.id;
    map["@platform($id)"] = params;
  }

  /// Set QQ platform share parameters
  void setQQ(
      String text,
      String title,
      String url,
      String audio,
      String video,
      String thumbImage,
      dynamic images,
      SSDKContentType type,
      ShareSDKPlatform subPlatform) {
    Map params = {};

    params[kType] = type.value;
    params[kText] = text;
    params[kTitle] = title;
    params[kUrl] = url;
    params[kAudioFlashURL] = audio;
    params[kVideoFlashURL] = video;
    params[kThumbImage] = thumbImage;
    params[kImages] = images;

    int id = subPlatform.id;
    map["@platform($id)"] = params;
  }

  /// Set sina platform share parameters
  void setSina(
      String text,
      String title,
      images,
      String video,
      String url,
      double latitude,
      double longitude,
      String objectId,
      bool isStory,
      SSDKContentType type) {
    Map params = {};

    params[kType] = type.value;
    params[kText] = text;
    params[kImages] = images;
    params[kTitle] = title;
    params[kVideo] = video;
    params[kUrl] = url;
    params[kLat] = latitude;
    params[kLong] = longitude;
    params[kWeiboIsStory] = isStory;
    params[kWeiboObjectId] = objectId;

    int id = ShareSDKPlatforms.sina.id;
    map["@platform($id)"] = params;
  }

  /// Set twitter platform share parameters
  void setTwitter(String text, images, String video, double latitude,
      double longitude, SSDKContentType type) {
    Map params = {};

    params[kText] = text;
    params[kType] = type.value;
    params[kImages] = images;
    params[kLat] = latitude;
    params[kLong] = longitude;
    params[kVideo] = video;

    int id = ShareSDKPlatforms.twitter.id;
    map["@platform($id)"] = params;
  }

  /// Set facebook platform share parameters
  void setFacebook(
      String text,
      images,
      String url,
      String urlTitle,
      String urlName,
      String attachementUrl,
      String hasTag,
      String quote,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kText] = text;
    params[kImages] = images;

    if (url.contains("assets-library")) {
      params[kVideoAssetURL] = url;
    } else {
      params[kUrl] = url;
    }

    params[kTitle] = urlTitle;
    params[kURLName] = urlName;
    params[kAttachments] = attachementUrl;
    params[kFacebookHashtag] = hasTag;
    params[kFacebookQuote] = quote;

    int id = ShareSDKPlatforms.facebook.id;
    map["@platform($id)"] = params;
  }
}
