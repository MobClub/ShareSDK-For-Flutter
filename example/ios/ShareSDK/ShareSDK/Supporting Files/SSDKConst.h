//
//  SSDKConst.h
//  ShareSDK
//
//  Created by Max on 2018/5/4.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#ifndef SSDKConst_h
#define SSDKConst_h

#import <UIKit/UIKit.h>

/**
 *  平台标识
 */
static const NSInteger SSDKPlatform = 2;

/**
 *  产商
 */
static NSString *const SSDKFactory = @"apple";

/**
 *  SDK版本字符串
 */
static NSString *const SSDKVersionString = @"4.2.0";

/**
 *  缓存数据域
 */
static NSString *const SSDKCacheDataDomain = @"ShareSDK";


#pragma mark - SSDKInit Keys

static NSString *const SSDKAppkey = @"app_key";
static NSString *const SSDKAppId = @"app_id";
static NSString *const SSDKConsumerKey = @"consumer_key";
static NSString *const SSDKApikey = @"api_key";
static NSString *const SSDKClientId = @"client_id";
//static NSString *const SSDKChannelId = @"channel_id";
static NSString *const SSDKRestApiKey= @"rest_api_key";
static NSString *const SSDKApplicationId= @"application_id";
static NSString *const SSDKClientSecret = @"client_secret";
static NSString *const SSDKConsumerSecret = @"consumer_secret";
static NSString *const SSDKAppSecret = @"app_secret";
static NSString *const SSDKSecret = @"secret";
static NSString *const SSDKSecretKey = @"secret_key";
static NSString *const SSDKApiSecret = @"api_secret";
static NSString *const SSDKRedirectUrl = @"redirect_uri";
static NSString *const SSDKOAuthCallback = @"oauth_callback";
static NSString *const SSDKDisplayName = @"display_name";
static NSString *const SSDKAuthTypeKey = @"auth_type";
static NSString *const SSDKSandbox = @"sandbox_mode";
static NSString *const SSDKOpenCountryList = @"open_countryList";
static NSString *const SSDKCovertUrl = @"covert_url";
static NSString *const SSDKDisplayUI = @"displayUI";

#pragma mark - SSDKSession Keys

static NSString *const SSDKTextKey              = @"text";
static NSString *const SSDKThumbImageKey        = @"thumb_image";
static NSString *const SSDKImagesKey            = @"images";
static NSString *const SSDKUrlKey               = @"url";
static NSString *const SSDKTypeKey              = @"type";
static NSString *const SSDKLatKey               = @"lat";
static NSString *const SSDKLongKey              = @"long";
static NSString *const SSDKTitleKey             = @"title";
static NSString *const SSDKAudioUrlKey          = @"audio_url";
static NSString *const SSDKExtensionKey         = @"ext_info";
static NSString *const SSDKFileKey              = @"file_data";
static NSString *const SSDKEmoticonKey          = @"emoticon_data";
static NSString *const SSDKWeChatSceneKey       = @"wechat_scene";
static NSString *const SSDKWeiboObjectIdKey     = @"object_id";
static NSString *const SSDKWeiboIsStoryKey      = @"sina_isStory";
static NSString *const SSDKAttachmentsKey       = @"attachments";
static NSString *const SSDKRecipientsKey        = @"recipients";
static NSString *const SSDKCCRecipientsKey      = @"cc_recipients";
static NSString *const SSDKBCCRecipientsKey     = @"bcc_recipients";
static NSString *const SSDKDescKey              = @"desc";
static NSString *const SSDKAlbumIdKey           = @"album_id";
static NSString *const SSDKTagsKey              = @"tags";
static NSString *const SSDKTweetIdKey           = @"tweet_id";
static NSString *const SSDKDeepLinkIdKey        = @"deep_link_id";
static NSString *const SSDKMenuDisplayX         = @"menu_display_x";
static NSString *const SSDKMenuDisplayY         = @"menu_display_y";
static NSString *const SSDKVisibilityKey        = @"visibility";
static NSString *const SSDKBlogNameKey          = @"blog_name";
static NSString *const SSDKIsPublicKey          = @"is_public";
static NSString *const SSDKIsFriendKey          = @"is_friend";
static NSString *const SSDKIsFamilyKey          = @"is_family";
static NSString *const SSDKSafetyLevelKey       = @"safety_level";
static NSString *const SSDKContentTypeKey       = @"content_type";
static NSString *const SSDKHiddenKey            = @"hidden";
static NSString *const SSDKAudioKey             = @"audio";
static NSString *const SSDKVideoKey             = @"video";
static NSString *const SSDKSourceKey            = @"source";
static NSString *const SSDKAuthorKey            = @"author";
static NSString *const SSDKNoteBookKey          = @"notebook";
static NSString *const SSDKBoardKey             = @"board";
static NSString *const SSDKPermissionKey        = @"permission";
static NSString *const SSDKTemplateId           = @"templateId";
static NSString *const SSDKTemplateArgs         = @"templateArgs";
static NSString *const SSDKEnableShare          = @"enable_share";
static NSString *const SSDKAndroidExecParam     = @"android_exec_param";
static NSString *const SSDKIPhoneExecParam      = @"iphone_exec_param";
static NSString *const SSDKGroupId              = @"group_id";
static NSString *const SSDKPrivateFromSourceKey = @"private_from_source";
static NSString *const SSDKFolderIdKey          = @"folder_id";
static NSString *const SSDKResolveFinalUrlKey   = @"resolve_final_url";
static NSString *const SSDKCommentKey           = @"comment";
static NSString *const SSDKUidKey               = @"uid";
static NSString *const SSDKWeChatFileKey        = @"source_file";
static NSString *const SSDKWeChatFileExtension  = @"source_extension";
static NSString *const SSDKAudioFlashURL        = @"audio_flash_url";
static NSString *const SSDKVideoFlashURL        = @"video_flash_url";
static NSString *const SSDKVideoAssetURL        = @"video_asset_url";
static NSString *const SSDKURLName              = @"url_name";

static NSString *const SSDKPrivacyStatusKey     = @"privacy_status";
static NSString *const SSDKYouTubePartsKey      = @"youtube_parts";
static NSString *const SSDKYouTubeJsonStringKey = @"youtube_json_string";

static NSString *const SSDKFlagsKey             = @"@flags";
static NSString *const SSDKClientShareKey       = @"@client_share";
static NSString *const SSDKAdvancedShareKey     = @"@advanced_share"; //v4.0.1弃用 新浪原本的api已废弃------
static NSString *const SSDKExtensionShareKey    = @"@extension_share";//v4.0.2 第三方应用插件进行分享 (暂只支持微信 QQ TIM)

//3.6.3 为微信小程序增加
static NSString *const SSDKWXMPUserName         = @"wxmp_user_name";
static NSString *const SSDKWXMPPath             = @"wxmp_path";
static NSString *const SSDKWXMPWithTicket       = @"wxmp_with_ticket";
static NSString *const SSDKWXMPType             = @"wxmp_type";
static NSString *const SSDKWXMPHdThumbImage     = @"wxmp_hdthumbimage";

//4.2.0
static const NSInteger kShortUrlRSAKeySize      = 1024;
static NSString *const kShortUrlRSAPublicKey    = @"bb7addd7e33383b74e82aba9b1d274c73aea6c0c71fcc88730270f630dbe490e1d162004f74e9532f98e17004630fbea9b346de63c23e83a7dfad70dd47cebfd";
static NSString *const kShortUrlRSAModulus      = @"288e7c44e01569a905386e6341baabfcde63ec37d0f0835cc662c299a5d0072970808a7fa434f0a51fa581d09d5ec4350ba5d548eafbe1fd956fb3afd678c1fb6134c904668652ec5cceb5d85da337a0f2f13ea457cca74a01b3ba0f4c809ad30d382bba2562ec9b996ae44c3700731c1b914997ef826331759e4084a019a03f";

static NSString *const SSDKFacebookHashtagKey   = @"facebook_hashtag";
static NSString *const SSDKFacebookQuoteKey     = @"facebook_quote";

//v4.2.1 天翼
static NSString *const SSDKAppName              = @"app_name";

#pragma mark - Notification Keys

static NSString *const SSDKDidCancelSessionNotificationKey = @"SSDKDidCancelSessionNotificationKey";

#endif /* SSDKConst_h */
