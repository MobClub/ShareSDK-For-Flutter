import './sharesdk_defines.dart';

/// const
const String kText = "text";
const String kThumbImage = "thumb_image";
const String kImages = "images";
const String kImageUrlAndroid = "imageUrl_android";
const String kImagePathAndroid = "imagePath_android";
const String kImageDataAndroid = "imageData";
const String kTitleUrlAndroid = "titleUrl_android";
const String kMusicUrlAndroid = "musicUrl_android";
const String kVideoUrlAndroid = "videoUrl_android";
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
const String kLinkURL = "linkURL";
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
const String kFacebookShareType = "facebook_shareType";

const String ksina_summary = "sina_cardSummary";
const String ksina_displayname = "sina_displayname";
const String ksina_cardTitle = "sina_cardTitle";
const String ksina_linkcard = "sina_linkCard";
const String kimage_url = "image_url";
const String kimage_x = "image_x";
const String kimage_y = "image_y";

const String ksite = "site";
const String ksiteUrl = "siteUrl";

const String kFilePath = "filePath";
const String kAsset_localIds = "asset_localIds";

const String kYXLowBandUrl = "yx_lowBand";
const String kYXLowBandDataUrl  = "yx_lowBandData";
const String kYXDataUrl = "yx_Data";
const String kYXVideoLowBandDataUrl = "yx_lowvideoBandData";
const String KHASHTAGS = "HASHTAGS";
const String KVIDEO_ARRAY = "videoArray";



/// Set sharing parameters map
class SSDKMap {
  final Map map = {};

  /// Set common share parameters
  void setGeneral(
      String title,
      String text,
      dynamic images,
      String imageUrlAndroid,
      String imagePathAndroid,
      String url,
      String titleUrlAndroid,
      String musicUrlAndroid,
      String videoUrlAndroid,
      String filePath,
      SSDKContentType contentType) {
    map[kType] = contentType.value;
    map[kText] = text;
    map[kTitle] = title;
    map[kImages] = images;
    map[kUrl] = url;
    map[kTitleUrlAndroid] = titleUrlAndroid;
    map[kMusicUrlAndroid] = musicUrlAndroid;
    map[kVideoUrlAndroid] = videoUrlAndroid;
    map[kImageUrlAndroid] = imageUrlAndroid;
    map[kImagePathAndroid] = imagePathAndroid;
    map[kFilePath] = filePath;
  }

  //相册选择图片/视频的通用参数设置
  void setImageAndVideoAssets(
      String imageAssets,
      Map videoAsset) {
    map["imageAssets"] = imageAssets;
    map["videoAsset"] = videoAsset;
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
      String imageUrl,
      dynamic imageData,
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
    params[kImageUrlAndroid] = imageUrl;
    params[kImageDataAndroid] = imageData;
    int? id = subPlatform.id;
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

    int? id = subPlatform.id;
    map["@platform($id)"] = params;
  }

  /// Set QQ platform share parameters
  void setQQ(
      String text,
      String title,
      String url,
      String audio,
      String video,
      String musicUrl,
      String videoUrl,
      String thumbImage,
      dynamic images,
      String imageUrlAndroid,
      String imagePathAndroid,
      String titleUrlAndroid,
      String siteAndroid,
      String siteUrlAndroid,
      SSDKContentType type,
      ShareSDKPlatform subPlatform) {
    Map params = {};

    params[kType] = type.value;
    params[kText] = text;
    params[kTitle] = title;
    params[kTitleUrlAndroid] = titleUrlAndroid;
    params[kUrl] = url;
    params[kMusicUrlAndroid] = musicUrl;
    params[kVideoUrlAndroid] = videoUrl;
    params[kAudioFlashURL] = audio;
    params[kVideoFlashURL] = video;
    params[kThumbImage] = thumbImage;
    params[kImages] = images;
    params[kImageUrlAndroid] = imageUrlAndroid;
    params[kImagePathAndroid] = imagePathAndroid;
    params[ksite] = siteAndroid;
    params[ksiteUrl] = siteUrlAndroid;

    int? id = subPlatform.id;
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
      String imageUrl,
      String imagePath,
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
    params[kImagePathAndroid] = imagePath;
    params[kImageUrlAndroid] = imageUrl;

    int? id = ShareSDKPlatforms.sina.id;
    map["@platform($id)"] = params;
  }

  void setSinaLinkCard(
    // linkCard
    String text,
    String title,
    String url,
    String sinaSummary,
    String imageUrl,
    String imageX,
    String imageY,
  ) {
    Map params = {};
    params[kText] = text;
    params[ksina_cardTitle] = title;
    params[ksina_displayname] = title;
    params[ksina_summary] = sinaSummary;
    params[kUrl] = url;
    params[ksina_linkcard] = true;
    params[kimage_url] = imageUrl;
    params[kimage_x] = imageX;
    params[kimage_y] = imageY;
    params[kType] = SSDKContentTypes.webpage.value;

    int? id = ShareSDKPlatforms.sina.id;
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

    int? id = ShareSDKPlatforms.twitter.id;
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
      SSDKFacebookShareType shareType,
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
    params[kFacebookShareType] = shareType.value;
    int? id = ShareSDKPlatforms.facebook.id;
    map["@platform($id)"] = params;
  }

  //setFacebookAssetImagesOrVideo，设置相册中的image或者video的localIdentifier
  void setFacebookAssetLocalIdentifier(
      String imageLocalIdentifiers, String videoLocalIdentifier) {
    map["facebookAssetLocalIdentifierKey_image"] = imageLocalIdentifiers;
    map["facebookAssetLocalIdentifierKey_video"] = videoLocalIdentifier;
  }

  void setFacebookMessenger(
      String title,
      String url,
      dynamic images,
      dynamic video,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kImages] = images;
    params[kTitle] = title;
    params[kUrl] = url;
    if (video != null) {
      params[kVideo] = video;
    }
    int? id = ShareSDKPlatforms.messenger.id;
    map["@platform($id)"] = params;
  }

  void setOasis(String title, String text, assetLoacalIds, image, String? video,
      String fileExtension, SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kText] = text;
    params[kImages] = image;
    params[kTitle] = title;
    if (assetLoacalIds != null) {
      params[kAsset_localIds] = assetLoacalIds;
    }
    params[kWeChatFileExtension] = fileExtension;
    if (video != null) {
      params[kVideo] = video;
    }
    int? id = ShareSDKPlatforms.oasis.id;
    map["@platform($id)"] = params;
  }

  void setSnapchat(
      String title,
      String attachmentUrl,
      String image,
      String? video,
      String sticker,
      bool stickerAnimated,
      double stickerRotation,
      bool cameraViewState,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kImages] = image;
    params[kTitle] = title;
    params["Sticker"] = sticker;
    params[kAttachments] = attachmentUrl;
    params["Sticker_animated"] = stickerAnimated;
    params["Sticker_rotation"] = stickerRotation;
    params["Sticker_cameraviewstate"] = cameraViewState;
    if (video != null) {
      params[kVideo] = video;
    }

    int? id = ShareSDKPlatforms.snapchat.id;
    map["@platform($id)"] = params;
  }

  void setKuaiShou(
      String title,
      String desc,
      String linkURL,
      String thumbImage,
      String openID,
      String receiverOpenID,
      String localIdentifier,
      List tags,
      String extraInfo,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kTitle] = title;
    params[kDesc] = desc;
    params[kLinkURL] = linkURL;
    params["thumbImage"] = thumbImage;
    params["openID"] = openID;
    params["receiverOpenID"] = receiverOpenID;
    params["localIdentifier"] = localIdentifier;
    params["tags"] = tags;
    params["extraInfo"] = extraInfo;

    int? id = ShareSDKPlatforms.kuaishou.id;
    map["@platform($id)"] = params;
  }

  void setDouYinShareActionMode(
      int shareActionMode){
      map["kSSDKDouYinShareAction"] = shareActionMode;
  }

  void setDouYin(
      List assetLocalIds,
      String hashtag,
      Map extraInfo,
      int shareActionMode,
      SSDKContentType type) {
    Map params = {};
    params[kAsset_localIds] = assetLocalIds;
    params["douyin_hashtag"] = hashtag;
    params["douyin_extraInfo"] = extraInfo;
    params["kSSDKDouYinShareAction"] = shareActionMode;
    params[kType] = type.value;

    int? id = ShareSDKPlatforms.douyin.id;
    map["@platform($id)"] = params;
  }

  void setTikTok(
      List assetLocalIds,
      String hashtag,
      Map extraInfo,
      SSDKContentType type) {
    Map params = {};
    params[kAsset_localIds] = assetLocalIds;
    params["tiktok_hashtag"] = hashtag;
    params["tiktok_extraInfo"] = extraInfo;
    params[kType] = type.value;

    int? id = ShareSDKPlatforms.tiktok.id;
    map["@platform($id)"] = params;
  }

  void setKakaoTalk(
      String url,
      String templateId,
      Map templateArgs) {
    Map params = {};
    params[kUrl] = url;
    params["templateId"] = templateId;
    params["templateArgs"] = templateArgs;
    int? id = ShareSDKPlatforms.kakaoTalk.id;
    map["@platform($id)"] = params;
  }

  void setKakaoStory(
      String text,
      dynamic images,
      String title,
      String url,
      int permission,
      int enableShare,
      Map androidExecParam,
      Map iOSExecParams,
      SSDKContentType type) {
    Map params = {};
    params[kText] = text;
    params[kImages] = images;
    params[kTitle] = title;
    params[kUrl] = url;
    params[kPermission] = permission;
    params[kEnableShare] = enableShare;
    params[kAndroidExecParam] = androidExecParam;
    params[kIPhoneExecParam] = iOSExecParams;
    int? id = ShareSDKPlatforms.kakaoStory.id;
    map["@platform($id)"] = params;
  }

  void setInstagram(
      dynamic images,
      dynamic x,
      dynamic y) {
    Map params = {};
    params[kImages] = images;
    params[kMenuDisplayX] = x;
    params[kMenuDisplayY] = y;
    int? id = ShareSDKPlatforms.instagram.id;
    map["@platform($id)"] = params;
  }

  void setWhatsApp(
      String text,
      dynamic images,
      dynamic audio,
      dynamic video,
      dynamic x,
      dynamic y,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kImages] = images;
    params[kText] = text;
    if (audio != null) {
      params[kAudio] = audio;
    }
    if (video != null) {
      params[kVideo] = video;
    }
    params[kMenuDisplayX] = x;
    params[kMenuDisplayY] = y;
    int? id = ShareSDKPlatforms.whatsApp.id;
    map["@platform($id)"] = params;
  }

  void setLinkedIn(
      String text,
      dynamic images,
      String url,
      String title,
      String urlDesc,
      dynamic visibility,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kImages] = images;
    params[kText] = text;
    params[kTitle] = title;
    params[kUrl] = url;
    params[kDesc] = urlDesc;
    params[kVisibility] = visibility;
    int? id = ShareSDKPlatforms.linkedIn.id;
    map["@platform($id)"] = params;
  }

  void setTelegram(
      String text,
      dynamic images,
      dynamic audio,
      dynamic video,
      dynamic file,
      dynamic x,
      dynamic y,
      SSDKContentType type) {
    Map params = {};
    params[kType] = type.value;
    params[kText] = text;
    params[kImages] = images;
    if (audio != null) {
      params[kAudio] = audio;
    }
    if (video != null) {
      params[kVideo] = video;
    }
    if (file != null) {
      params[kFile] = file;
    }
    int? id = ShareSDKPlatforms.telegram.id;
    map["@platform($id)"] = params;
  }

  void setDropbox(
      dynamic attachment) {
    Map params = {};
    params[kAttachments] = attachment;
    int? id = ShareSDKPlatforms.dropbox.id;
    map["@platform($id)"] = params;
  }

  void setPinterest(
      String image,
      String desc,
      String url,
      String boardName) {
    Map params = {};
    params[kImages] = image;
    params[kText] = desc;
    params[kUrl] = url;
    params[kBoard] = boardName;
    int? id = ShareSDKPlatforms.pinterest.id;
    map["@platform($id)"] = params;
  }

  void setYouDaoNote(
      String text,
      dynamic images,
      String title,
      String source,
      String author,
      String notebook) {
    Map params = {};
    params[kText] = text;
    params[kImages] = images;
    params[kTitle] = title;
    params[kSource] = source;
    params[kAuthor] = author;
    params[kNoteBook] = notebook;
    int? id = ShareSDKPlatforms.youdaoNote.id;
    map["@platform($id)"] = params;
  }

  void setYiXin(
      String text,
      String title,
      String url,
      dynamic thumbImage,
      dynamic images,
      String musicFileURL,
      String musicLowBandUrl,
      String musicDataUrl,
      String musicLowBandDataUrl,
      String extInfo,
      String fileData,
      String videoLowBandUrl,
      String comment,
      String userId,
      SSDKContentType type,
      int platformSubType) {
    Map params = {};
    params[kText] = text;
    params[kTitle] = title;
    params[kUrl] = url;
    params[kThumbImage] = thumbImage;
    params[kImages] = images;
    params[kAudio] = musicFileURL;
    params[kYXLowBandUrl] = musicLowBandUrl;
    params[kYXDataUrl] = musicDataUrl;
    params[kYXLowBandDataUrl] = musicLowBandDataUrl;
    params[kExtension] = extInfo;
    params[kFile] = fileData;
    params[kYXVideoLowBandDataUrl] = videoLowBandUrl;
    params[kComment] = comment;
    params[kUid] = userId;
    params[kType] = type;

    int? id = platformSubType;
    map["@platform($id)"] = params;
  }
}

