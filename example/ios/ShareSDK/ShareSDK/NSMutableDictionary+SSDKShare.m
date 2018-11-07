//
//  NSMutableDictionary+SSDKShare.m
//  ShareSDK
//
//  Created by Max on 2018/5/8.
//  Copyright © 2018年 掌淘科技. All rights reserved.
//

#import "NSMutableDictionary+SSDKShare.h"
#import "SSDKImage.h"
#import "SSDKData.h"

@implementation NSMutableDictionary (SSDKShare)

- (void)SSDKSetShareFlags:(NSArray <NSString *>*)flags
{
    self[SSDKFlagsKey] = flags;
}

- (void)SSDKSetupShareParamsByText:(NSString *)text
                            images:(id)images
                               url:(NSURL *)url
                             title:(NSString *)title
                              type:(SSDKContentType)type
{
    self[SSDKTypeKey] = @(type);
    self[SSDKTextKey] = text;
    self[SSDKImagesKey] = [self _convertToImages:images];
    self[SSDKUrlKey] = url;
    self[SSDKTitleKey] = title;
}

- (void)SSDKSetupWeChatParamsByText:(NSString *)text
                              title:(NSString *)title
                                url:(NSURL *)url
                         thumbImage:(id)thumbImage
                              image:(id)image
                       musicFileURL:(NSURL *)musicFileURL
                            extInfo:(NSString *)extInfo
                           fileData:(id)fileData
                       emoticonData:(id)emoticonData
                sourceFileExtension:(NSString *)fileExtension
                     sourceFileData:(id)sourceFileData
                               type:(SSDKContentType)type
                 forPlatformSubType:(SSDKPlatformType)platformSubType
{
    if (platformSubType != SSDKPlatformSubTypeWechatSession && platformSubType != SSDKPlatformSubTypeWechatTimeline && platformSubType != SSDKPlatformSubTypeWechatFav)
    {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = url;
    params[SSDKThumbImageKey] = [SSDKImage imageWithObject:thumbImage];
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKAudioUrlKey] = musicFileURL;
    params[SSDKExtensionKey] = extInfo;
    params[SSDKFileKey] = [SSDKData dataWithObject:fileData];
    params[SSDKWeChatFileExtension] = fileExtension;
    params[SSDKWeChatFileKey] = [SSDKData dataWithObject:sourceFileData];
    params[SSDKEmoticonKey] = [SSDKData dataWithObject:emoticonData];;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformSubType]];
}

- (void)SSDKSetupWeChatMiniProgramShareParamsByTitle:(NSString *)title
                                         description:(NSString *)description
                                          webpageUrl:(NSURL *)webpageUrl
                                                path:(NSString *)path
                                          thumbImage:(id)thumbImage
                                        hdThumbImage:(id)hdThumbImage
                                            userName:(NSString *)userName
                                     withShareTicket:(BOOL)withShareTicket
                                     miniProgramType:(NSUInteger)type
                                  forPlatformSubType:(SSDKPlatformType)platformSubType
{
    if (platformSubType != SSDKPlatformSubTypeWechatSession)
    {
        ReleaseLog(@"%@",SSDKLocalized(@"ShareSDK_Error_WechatMini"));
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[SSDKTypeKey] = @(SSDKContentTypeMiniProgram);
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = webpageUrl;
    params[SSDKWXMPPath] = path;
    params[SSDKWXMPUserName] = userName;
    params[SSDKThumbImageKey] = [SSDKImage imageWithObject:thumbImage];
    params[SSDKWXMPHdThumbImage] = [SSDKImage imageWithObject:hdThumbImage];
    params[SSDKWXMPType] = @(type);
    params[SSDKWXMPWithTicket] = @(withShareTicket);
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformSubType]];
}

- (void)SSDKSetupQQParamsByText:(NSString *)text
                          title:(NSString *)title
                            url:(NSURL *)url
                  audioFlashURL:(NSURL *)audioFlashURL
                  videoFlashURL:(NSURL *)videoFlashURL
                     thumbImage:(id)thumbImage
                         images:(id)images
                           type:(SSDKContentType)type
             forPlatformSubType:(SSDKPlatformType)platformSubType
{
    if (platformSubType != SSDKPlatformSubTypeQZone && platformSubType != SSDKPlatformSubTypeQQFriend)
    {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = url;
    params[SSDKAudioFlashURL] = audioFlashURL;
    params[SSDKVideoFlashURL] = videoFlashURL;
    params[SSDKThumbImageKey] = [SSDKImage imageWithObject:thumbImage];
    params[SSDKImagesKey] = [self _convertToImages:images];
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformSubType]];
}

- (void)SSDKSetupQQParamsByText:(NSString *)text
                          title:(NSString *)title
                            url:(NSURL *)url
                     thumbImage:(id)thumbImage
                          image:(id)image
                           type:(SSDKContentType)type
             forPlatformSubType:(SSDKPlatformType)platformSubType
{
    [self SSDKSetupQQParamsByText:text
                            title:title
                              url:url
                    audioFlashURL:nil
                    videoFlashURL:nil
                       thumbImage:thumbImage
                           images:image
                             type:type
               forPlatformSubType:platformSubType];
}

- (void)SSDKSetupSinaWeiboShareParamsByText:(NSString *)text
                                      title:(NSString *)title
                                     images:(id)images
                                      video:(NSString *)video
                                        url:(NSURL *)url
                                   latitude:(double)latitude
                                  longitude:(double)longitude
                                   objectID:(NSString *)objectID
                             isShareToStory:(BOOL)shareToStory
                                       type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKImagesKey] = [self _convertToImages:images];
    params[SSDKVideoKey] = video;
    params[SSDKUrlKey] = url;
    params[SSDKLatKey] = @(latitude);
    params[SSDKLongKey] = @(longitude);
    params[SSDKWeiboObjectIdKey] = objectID;
    params[SSDKWeiboIsStoryKey] = @(shareToStory);
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeSinaWeibo]];
}

- (void)SSDKSetupTwitterParamsByText:(NSString *)text
                              images:(id)images
                               video:(NSURL*)video
                            latitude:(double)latitude
                           longitude:(double)longitude
                                type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTextKey] = text;
    params[SSDKTypeKey] = @(type);
    params[SSDKImagesKey] = [self _convertToImages:images];
    params[SSDKLatKey] = @(latitude);
    params[SSDKLongKey] = @(longitude);
    params[SSDKVideoKey] = video;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeTwitter]];
}


- (void)SSDKSetupFacebookParamsByText:(NSString *)text
                                image:(id)image
                                  url:(NSURL *)url
                             urlTitle:(NSString *)title
                              urlName:(NSString *)urlName
                       attachementUrl:(NSURL *)attachementUrl
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    if (image)
    {
        if([image isKindOfClass:[NSArray class]])
        {
            NSArray *imageArr = [self _convertToImages:image];
            if (imageArr)
            {
                [dict setObject:imageArr forKey:SSDKImagesKey];
            }
        }
        else
        {
            SSDKImage *item = [SSDKImage imageWithObject:image];
            if (item)
            {
                [dict setObject:@[item] forKey:SSDKImagesKey];
            }
        }
    }
    if (url && [url isKindOfClass:[NSURL class]])
    {
        if([url.scheme isEqualToString:@"assets-library"])
        {
            [dict setObject:url forKey:SSDKVideoAssetURL];
        }
        else
        {
            [dict setObject:url forKey:SSDKUrlKey];
        }
    }
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    if (urlName)
    {
        [dict setObject:urlName forKey:SSDKURLName];
    }
    if (attachementUrl)
    {
        [dict setObject:attachementUrl forKey:SSDKAttachmentsKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeFacebook]];
}

- (void)SSDKSetupFacebookParamsByText:(NSString *)text
                                image:(id)image
                                  url:(NSURL *)url
                             urlTitle:(NSString *)title
                              urlName:(NSString *)urlName
                       attachementUrl:(NSURL *)attachementUrl
                              hashtag:(NSString *)hashtag
                                quote:(NSString *)quote
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    if (image)
    {
        if([image isKindOfClass:[NSArray class]])
        {
            NSArray *imageArr = [self _convertToImages:image];
            if (imageArr)
            {
                [dict setObject:imageArr forKey:SSDKImagesKey];
            }
        }
        else
        {
            SSDKImage *item = [SSDKImage imageWithObject:image];
            if (item)
            {
                [dict setObject:@[item] forKey:SSDKImagesKey];
            }
        }
    }
    if (url && [url isKindOfClass:[NSURL class]])
    {
        if([url.scheme isEqualToString:@"assets-library"])
        {
            [dict setObject:url forKey:SSDKVideoAssetURL];
        }
        else
        {
            [dict setObject:url forKey:SSDKUrlKey];
        }
    }
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    if (urlName)
    {
        [dict setObject:urlName forKey:SSDKURLName];
    }
    if (attachementUrl)
    {
        [dict setObject:attachementUrl forKey:SSDKAttachmentsKey];
    }
    if (hashtag)
    {
        [dict setObject:hashtag forKey: SSDKFacebookHashtagKey];
    }
    if (quote)
    {
        [dict setObject:quote forKey: SSDKFacebookQuoteKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeFacebook]];
}

-(void)SSDKSetupFacebookMessengerParamsByImage:(id)image
                                           gif:(id)gif
                                         audio:(id)audio
                                         video:(id)video
                                          type:(SSDKContentType)type
{
    [self SSDKSetupFacebookMessengerParamsByTitle:nil
                                              url:nil
                                        quoteText:nil
                                           images:image
                                              gif:gif
                                            audio:audio
                                            video:video
                                             type:type];
}

- (void)SSDKSetupFacebookMessengerParamsByTitle:(NSString *)title
                                            url:(NSURL *)url
                                      quoteText:(NSString *)text
                                         images:(id)images
                                            gif:(id)gif
                                          audio:(id)audio
                                          video:(id)video
                                           type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    NSArray *imageArr = [self _convertToImages:images];
    if (imageArr)
    {
        [dict setObject:imageArr forKey:SSDKImagesKey];
    }
    
    
    if (gif)
    {
        SSDKData *item = [SSDKData dataWithObject:gif];
        if (item)
        {
            [dict setObject:item forKey:SSDKEmoticonKey];
        }
    }
    
    if (audio)
    {
        SSDKData *item = [SSDKData dataWithObject:audio];
        if (item)
        {
            [dict setObject:item forKey:SSDKAudioKey];
        }
    }
    
    if (video)
    {
        if([video isKindOfClass:[NSString class]])
        {
            if([video hasPrefix:@"assets-library"])
            {
                [dict setObject:video forKey:SSDKVideoKey];
            }
            else
            {
                SSDKData *item = [SSDKData dataWithObject:video];
                if (item)
                {
                    [dict setObject:item forKey:SSDKVideoKey];
                }
            }
        }
        else if([video isKindOfClass:[NSURL class]])
        {
            NSURL *url = (NSURL *)video;
            if([url.scheme isEqualToString:@"assets-library"])
            {
                [dict setObject:video forKey:SSDKVideoKey];
            }
            else
            {
                SSDKData *item = [SSDKData dataWithObject:video];
                if (item)
                {
                    [dict setObject:item forKey:SSDKVideoKey];
                }
            }
        }
        else
        {
            SSDKData *item = [SSDKData dataWithObject:video];
            if (item)
            {
                [dict setObject:item forKey:SSDKVideoKey];
            }
        }
    }
    [self setObject:dict
             forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeFacebookMessenger]];
}

- (void)SSDKSetupInstagramByImage:(id)image
                 menuDisplayPoint:(CGPoint)point
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(SSDKContentTypeImage) forKey:SSDKTypeKey];
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    [dict setObject:@(point.x) forKey:SSDKMenuDisplayX];
    [dict setObject:@(point.y) forKey:SSDKMenuDisplayY];
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeInstagram]];
}

- (void)SSDKSetupInstagramByVideo:(NSURL *)video
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(SSDKContentTypeVideo) forKey:SSDKTypeKey];
    BOOL isAssets = NO;
    if([video isKindOfClass:[NSURL class]])
    {
        NSURL *url = (NSURL *)video;
        if([url.scheme isEqualToString:@"assets-library"])
        {
            isAssets = YES;
            [dict setObject:video forKey:SSDKVideoAssetURL];
        }
    }
    if(!isAssets)
    {
        //非相册
        if (video)
        {
            [dict setObject:video forKey:SSDKVideoKey];
        }
    }
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeInstagram]];
}


- (void)SSDKSetupDingTalkParamsByText:(NSString *)text
                                image:(id)image
                                title:(NSString *)title
                                  url:(NSURL *)url
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeDingTalk]];
    
}


- (void)SSDKSetupAliSocialParamsByText:(NSString *)text
                                 image:(id)image
                                 title:(NSString *)title
                                   url:(NSURL *)url
                                  type:(SSDKContentType)type
                          platformType:(SSDKPlatformType)platformType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = url;
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformType]];
}

- (void)SSDKSetupPinterestParamsByImage:(id)image
                                   desc:(NSString *)desc
                                    url:(NSURL *)url
                              boardName:(NSString *)boardName
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTextKey] = desc;
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKBoardKey] = boardName;
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypePinterest]];
}

- (void)SSDKSetupDouBanParamsByText:(NSString *)text
                              image:(id)image
                              title:(NSString *)title
                                url:(NSURL *)url
                            urlDesc:(NSString *)urlDesc
                               type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    if (urlDesc)
    {
        [dict setObject:urlDesc forKey:SSDKDescKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeDouBan]];
}


- (void)SSDKSetupDropboxParamsByAttachment:(id)attachment
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (attachment)
    {
        SSDKData *item = [SSDKData dataWithObject:attachment];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKAttachmentsKey];
        }
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeDropbox]];
}


- (void)SSDKSetupYiXinParamsByText:(NSString *)text
                             title:(NSString *)title
                               url:(NSURL *)url
                        thumbImage:(id)thumbImage
                             image:(id)image
                      musicFileURL:(NSURL *)musicFileURL
                           extInfo:(NSString *)extInfo
                          fileData:(id)fileData
                           comment:(NSString *)comment
                          toUserId:(NSString *)userId
                              type:(SSDKContentType)type
                forPlatformSubType:(SSDKPlatformType)platformSubType
{
    if (platformSubType != SSDKPlatformSubTypeYiXinSession
        && platformSubType != SSDKPlatformSubTypeYiXinTimeline
        && platformSubType != SSDKPlatformSubTypeYiXinFav)
    {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = url;
    params[SSDKThumbImageKey] = [SSDKImage imageWithObject:thumbImage];
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKAudioKey] = musicFileURL;
    params[SSDKExtensionKey] = extInfo;
    params[SSDKFileKey] = [SSDKData dataWithObject:fileData];
    params[SSDKCommentKey] = comment;
    params[SSDKUidKey] = userId;
    
    [self setObject:params
             forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformSubType]];
}

- (void)SSDKSetupFlickrParamsByText:(NSString *)text
                              image:(id)image
                              title:(NSString *)title
                               tags:(NSArray *)tags
                           isPublic:(BOOL)isPublic
                           isFriend:(BOOL)isFriend
                           isFamily:(BOOL)isFamily
                        safetyLevel:(NSInteger)safetyLevel
                        contentType:(NSInteger)contentType
                             hidden:(NSInteger)hidden
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(isPublic) forKey:SSDKIsPublicKey];
    [dict setObject:@(isFriend) forKey:SSDKIsFriendKey];
    [dict setObject:@(isFamily) forKey:SSDKIsFamilyKey];
    [dict setObject:@(safetyLevel) forKey:SSDKSafetyLevelKey];
    [dict setObject:@(contentType) forKey:SSDKContentTypeKey];
    [dict setObject:@(hidden) forKey:SSDKHiddenKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    if (tags)
    {
        [dict setObject:tags forKey:SSDKTagsKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeFlickr]];
}

- (void)SSDKSetupInstapaperParamsByUrl:(NSURL *)url
                                 title:(NSString *)title
                                  desc:(NSString *)desc
                               content:(NSString *)content
                   isPrivateFromSource:(BOOL)isPrivateFromSource
                              folderId:(NSInteger)folderId
                       resolveFinalUrl:(BOOL)resolveFinalUrl
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@(isPrivateFromSource) forKey:SSDKPrivateFromSourceKey];
    [dict setObject:@(folderId) forKey:SSDKFolderIdKey];
    [dict setObject:@(resolveFinalUrl) forKey:SSDKResolveFinalUrlKey];
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    if (desc)
    {
        [dict setObject:desc forKey:SSDKDescKey];
    }
    
    if (content)
    {
        [dict setObject:content forKey:SSDKTextKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeInstapaper]];
}

- (void)SSDKSetupLineParamsByText:(NSString *)text
                            image:(id)image
                             type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeLine]];
}


- (void)SSDKSetupEvernoteParamsByText:(NSString *)text
                               images:(id)images
                                video:(NSURL *)video
                                title:(NSString *)title
                             notebook:(NSString *)notebook
                                 tags:(NSArray *)tags
                         platformType:(SSDKPlatformType)platformType
{
    if (platformType == SSDKPlatformTypeYinXiang || platformType == SSDKPlatformTypeEvernote)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[SSDKTextKey] = text;
        params[SSDKImagesKey] = [self _convertToImages:images];
        params[SSDKTitleKey] = title;
        params[SSDKUrlKey] = video;
        params[SSDKNoteBookKey] = notebook;
        params[SSDKTagsKey] = tags;
        
        [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformType]];
    }
}

- (void)SSDKSetupEvernoteParamsByText:(NSString *)text
                               images:(id)images
                                title:(NSString *)title
                             notebook:(NSString *)notebook
                                 tags:(NSArray *)tags
                         platformType:(SSDKPlatformType)platformType
{
    [self SSDKSetupEvernoteParamsByText:text images:images video:nil title:title notebook:notebook tags:tags platformType:platformType];
}

- (void)SSDKSetupGooglePlusParamsByText:(NSString *)text
                                    url:(NSURL *)url
                                   type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKUrlKey] = url;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeGooglePlus]];
}

- (void)SSDKSetupKaKaoParamsByText:(NSString *)text
                            images:(id)images
                             title:(NSString *)title
                               url:(NSURL *)url
                        permission:(NSString *)permission
                       enableShare:(BOOL)enableShare
                         imageSize:(CGSize)imageSize
                    appButtonTitle:(NSString *)appButtonTitle
                  androidExecParam:(NSDictionary *)androidExecParam
                  androidMarkParam:(NSString *)androidMarkParam
                  iphoneExecParams:(NSDictionary *)iphoneExecParams
                   iphoneMarkParam:(NSString *)iphoneMarkParam
                    ipadExecParams:(NSDictionary *)ipadExecParams
                     ipadMarkParam:(NSString *)ipadMarkParam
                              type:(SSDKContentType)type
                forPlatformSubType:(SSDKPlatformType)platformSubType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:images];
    params[SSDKTitleKey] = title;
    params[SSDKUrlKey] = url;
    params[SSDKPermissionKey] = permission;
    params[SSDKEnableShare] = @(enableShare);
    //    params[SSDKImageWidth] = @(imageSize.width);
    //    params[SSDKImageHeight] = @(imageSize.height);
    //    params[SSDKAppButtonTitle] = appButtonTitle;
    params[SSDKAndroidExecParam] = [MOBFJson jsonStringFromObject:androidExecParam];
    //    params[SSDKAndroidMarketParam] = androidMarkParam;
    params[SSDKIPhoneExecParam] = [MOBFJson jsonStringFromObject:iphoneExecParams];
    //    params[SSDKIPhoneMarketParam] = iphoneMarkParam;
    //    params[SSDKIPadExecParam] = [MOBFJson jsonStringFromObject:ipadExecParams];
    //    params[SSDKIPadMarketParam] = ipadMarkParam;
    //
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)platformSubType]];
}

- (void)SSDKSetupKaKaoTalkParamsByUrl:(NSURL *)url
                           templateId:(NSString *)templateId
                         templateArgs:(NSDictionary *)templateArgs
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKUrlKey] = url;
    params[SSDKTemplateId] = templateId;
    params[SSDKTemplateArgs] = templateArgs;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformSubTypeKakaoTalk]];
}

- (void)SSDKSetupKakaoStoryParamsByContent:(NSString *)content
                                     title:(NSString *)title
                                    images:(NSArray *)images
                                       url:(NSURL *)url
                                permission:(int)permission
                                  sharable:(BOOL)sharable
                          androidExecParam:(NSDictionary *)androidExecParam
                              iosExecParam:(NSDictionary *)iosExecParam
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTextKey] = content;
    params[SSDKTitleKey] = title;
    params[SSDKImagesKey] = [self _convertToImages:images];
    params[SSDKUrlKey] = url;
    params[SSDKEnableShare] = @(sharable);
    params[SSDKAndroidExecParam] = androidExecParam;
    params[SSDKIPhoneExecParam] = iosExecParam;
    params[SSDKPermissionKey] = @(permission);
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformSubTypeKakaoStory]];
}

- (void)SSDKSetupLinkedInParamsByText:(NSString *)text
                                image:(id)image
                                  url:(NSURL *)url
                                title:(NSString *)title
                              urlDesc:(NSString *)urlDesc
                           visibility:(NSString *)visibility
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKUrlKey] = url;
    params[SSDKTitleKey] = title;
    params[SSDKDescKey] = urlDesc;
    params[SSDKVisibilityKey] = visibility;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeLinkedIn]];
}

- (void)SSDKSetupTumblrParamsByText:(NSString *)text
                              image:(id)image
                                url:(NSURL *)url
                              title:(NSString *)title
                           blogName:(NSString *)blogName
                               type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKUrlKey] = url;
    params[SSDKTitleKey] = title;
    params[SSDKBlogNameKey] = blogName;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeTumblr]];
}

- (void)SSDKSetupMeiPaiParamsByUrl:(NSURL *)url contentType:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKUrlKey] = url;
    params[SSDKTypeKey] = @(type);
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeMeiPai]];
}

- (void)SSDKSetupMeiPaiParamsByUrl:(NSURL *)url type:(SSDKContentType)type
{
    [self SSDKSetupMeiPaiParamsByUrl:url contentType:type];
}

- (void)SSDKSetupPocketParamsByUrl:(NSURL *)url
                             title:(NSString *)title
                              tags:(id)tags
                           tweetId:(NSString *)tweetId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKUrlKey] = url;
    params[SSDKTitleKey] = title;
    
    if ([tags isKindOfClass:[NSString class]])
    {
        params[SSDKTagsKey] = [tags componentsSeparatedByString:@","];
    }
    else if ([tags isKindOfClass:[NSArray class]])
    {
        params[SSDKTagsKey] = tags;
    }
    params[SSDKTweetIdKey] = tweetId;
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypePocket]];
}

- (void)SSDKSetupSMSParamsByText:(NSString *)text
                           title:(NSString *)title
                          images:(id)images
                     attachments:(NSArray *)attachments
                      recipients:(NSArray *)recipients
                            type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKTitleKey] = title;
    params[SSDKImagesKey] = [self _convertToImages:images];
    
    if ([attachments isKindOfClass:[NSArray class]])
    {
        NSMutableArray *attachmentArr = [NSMutableArray array];
        [attachments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SSDKData *item = [SSDKData dataWithObject:obj];
            if (item)
            {
                [attachmentArr addObject:item];
            }
            
        }];
        params[SSDKAttachmentsKey] = attachmentArr;
    }
    else if (attachments)
    {
        SSDKData *item = [SSDKData dataWithObject:attachments];
        if (item)
        {
            params[SSDKAttachmentsKey] = @[item];
        }
    }
    
    params[SSDKRecipientsKey] = recipients;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeSMS]];
}

- (void)SSDKSetupCopyParamsByText:(NSString *)text
                           images:(id)images
                              url:(NSURL *)url
                             type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:images];
    params[SSDKUrlKey] = url;
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeCopy]];
}

- (void)SSDKSetupKaiXinParamsByText:(NSString *)text
                              image:(id)image
                               type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTypeKey] = @(type);
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:image];
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeKaixin]];
}

- (void)SSDKSetupMingDaoParamsByText:(NSString *)text
                               image:(id)image
                                 url:(NSURL *)url
                               title:(NSString *)title
                                type:(SSDKContentType)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[SSDKTextKey] = text;
    params[SSDKImagesKey] = [self _convertToImages:image];
    params[SSDKUrlKey] = url;
    params[SSDKTitleKey] = title;
    params[SSDKTypeKey] = @(type);
    
    [self setObject:params forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeMingDao]];
}

- (void)SSDKSetupVKontakteParamsByText:(NSString *)text
                                images:(id)images
                                   url:(NSURL *)url
                               groupId:(NSString *)groupId
                           friendsOnly:(BOOL)friendsOnly
                              latitude:(double)latitude
                             longitude:(double)longitude
                                  type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@(type) forKey:SSDKTypeKey];
    [dict setObject:@(friendsOnly) forKey:SSDKIsFriendKey];
    [dict setObject:@(latitude) forKey:SSDKLatKey];
    [dict setObject:@(longitude) forKey:SSDKLongKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    NSArray *imageArr = [self _convertToImages:images];
    if (imageArr)
    {
        [dict setObject:imageArr forKey:SSDKImagesKey];
    }
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    if (groupId)
    {
        [dict setObject:groupId forKey:SSDKGroupId];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeVKontakte]];
}

- (void)SSDKSetupYouTubeParamsByVideo:(id)video
                                title:(NSString *)title
                          description:(NSString *)description
                                 tags:(id)tags
                        privacyStatus:(SSDKPrivacyStatus)privacyStatus
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(SSDKContentTypeVideo) forKey:SSDKTypeKey];
    if (video)
    {
        SSDKData *item = [SSDKData dataWithObject:video];
        if (item)
        {
            [dict setObject:item forKey:SSDKVideoKey];
            
        }
    }
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    if (description)
    {
        [dict setObject:description forKey:SSDKTextKey];
    }
    if(tags)
    {
        if ([tags isKindOfClass:[NSString class]])
        {
            [dict setObject:[tags componentsSeparatedByString:@","] forKey:SSDKTagsKey];
        }
        else if ([tags isKindOfClass:[NSArray class]])
        {
            [dict setObject:tags forKey:SSDKTagsKey];
        }
    }
    [dict setObject:@(privacyStatus) forKey:SSDKPrivacyStatusKey];
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeYouTube]];
}

- (void)SSDKSetupYouTubeParamsByVideo:(id)video
                                parts:(NSString *)parts
                           jsonString:(NSString *)jsonString
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(SSDKContentTypeVideo) forKey:SSDKTypeKey];
    if (video)
    {
        SSDKData *item = [SSDKData dataWithObject:video];
        if (item)
        {
            [dict setObject:item forKey:SSDKVideoKey];
            
        }
    }
    if(parts)
    {
        [dict setObject:parts forKey:SSDKYouTubePartsKey];
    }
    if(jsonString)
    {
        [dict setObject:jsonString forKey:SSDKYouTubeJsonStringKey];
    }
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeYouTube]];
}

- (void)SSDKSetupWhatsAppParamsByText:(NSString *)text
                                image:(id)image
                                audio:(id)audio
                                video:(id)video
                     menuDisplayPoint:(CGPoint)point
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (audio)
    {
        SSDKData *item = [SSDKData dataWithObject:audio];
        if (item)
        {
            [dict setObject:item forKey:SSDKAudioKey];
        }
    }
    
    if (video)
    {
        SSDKData *item = [SSDKData dataWithObject:video];
        if (item)
        {
            [dict setObject:item forKey:SSDKVideoKey];
        }
    }
    
    [dict setObject:@(point.x) forKey:SSDKMenuDisplayX];
    [dict setObject:@(point.y) forKey:SSDKMenuDisplayY];
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeWhatsApp]];
}


- (void)SSDKSetupTencentWeiboShareParamsByText:(NSString *)text
                                        images:(id)images
                                      latitude:(double)latitude
                                     longitude:(double)longitude
                                          type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@(type) forKey:SSDKTypeKey];
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    NSArray *imageArr = [self _convertToImages:images];
    if (imageArr)
    {
        [dict setObject:imageArr forKey:SSDKImagesKey];
    }
    
    [dict setObject:@(latitude) forKey:SSDKLatKey];
    [dict setObject:@(longitude) forKey:SSDKLongKey];
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeTencentWeibo]];
}

- (void)SSDKSetupMailParamsByText:(NSString *)text
                            title:(NSString *)title
                           images:(id)images
                      attachments:(id)attachments
                       recipients:(NSArray *)recipients
                     ccRecipients:(NSArray *)ccRecipients
                    bccRecipients:(NSArray *)bccRecipients
                             type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    NSArray *imageArr = [self _convertToImages:images];
    if (imageArr)
    {
        [dict setObject:imageArr forKey:SSDKImagesKey];
    }
    
    if ([attachments isKindOfClass:[NSArray class]])
    {
        NSMutableArray *attachmentArr = [NSMutableArray array];
        [attachments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SSDKData *item = [SSDKData dataWithObject:obj];
            if (item)
            {
                [attachmentArr addObject:item];
            }
            
        }];
        [dict setObject:attachmentArr forKey:SSDKAttachmentsKey];
    }
    else if (attachments)
    {
        SSDKData *item = [SSDKData dataWithObject:attachments];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKAttachmentsKey];
        }
    }
    
    if (recipients)
    {
        [dict setObject:recipients forKey:SSDKRecipientsKey];
    }
    
    if (ccRecipients)
    {
        [dict setObject:ccRecipients forKey:SSDKCCRecipientsKey];
    }
    
    if (bccRecipients)
    {
        [dict setObject:bccRecipients forKey:SSDKBCCRecipientsKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeMail]];
}

- (void)SSDKSetupRenRenParamsByText:(NSString *)text
                              image:(id)image
                                url:(NSURL *)url
                            albumId:(NSString *)albumId
                               type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (url)
    {
        [dict setObject:url forKey:SSDKUrlKey];
    }
    
    if (albumId)
    {
        [dict setObject:albumId forKey:SSDKAlbumIdKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeRenren]];
}

- (void)SSDKSetupYouDaoNoteParamsByText:(NSString *)text
                                 images:(id)images
                                  title:(NSString *)title
                                 source:(NSString *)source
                                 author:(NSString *)author
                               notebook:(NSString *)notebook
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    NSArray *imageArr = [self _convertToImages:images];
    if (imageArr)
    {
        [dict setObject:imageArr forKey:SSDKImagesKey];
    }
    
    if (title)
    {
        [dict setObject:title forKey:SSDKTitleKey];
    }
    
    if (source)
    {
        [dict setObject:source forKey:SSDKSourceKey];
    }
    
    if (author)
    {
        [dict setObject:author forKey:SSDKAuthorKey];
    }
    
    if (notebook)
    {
        [dict setObject:notebook forKey:SSDKNoteBookKey];
    }
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeYouDaoNote]];
}

- (void)SSDKSetupTelegramParamsByText:(NSString *)text
                                image:(id)image
                                audio:(NSURL *)audio
                                video:(NSURL *)video
                                 file:(NSURL *)file
                     menuDisplayPoint:(CGPoint)point
                                 type:(SSDKContentType)type
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(type) forKey:SSDKTypeKey];
    
    if (text)
    {
        [dict setObject:text forKey:SSDKTextKey];
    }
    
    if (image)
    {
        SSDKImage *item = [SSDKImage imageWithObject:image];
        if (item)
        {
            [dict setObject:@[item] forKey:SSDKImagesKey];
        }
    }
    
    if (audio)
    {
        SSDKData *item = [SSDKData dataWithObject:audio];
        if (item)
        {
            [dict setObject:item forKey:SSDKAudioKey];
        }
    }
    
    if (video)
    {
        SSDKData *item = [SSDKData dataWithObject:video];
        if (item)
        {
            [dict setObject:item forKey:SSDKVideoKey];
        }
    }
    
    if (file)
    {
        SSDKData *item = [SSDKData dataWithObject:file];
        if (item)
        {
            [dict setObject:item forKey:SSDKFileKey];
        }
    }
    
    [dict setObject:@(point.x) forKey:SSDKMenuDisplayX];
    [dict setObject:@(point.y) forKey:SSDKMenuDisplayY];
    
    [self setObject:dict forKey:[NSString stringWithFormat:@"@platform(%lu)", (unsigned long)SSDKPlatformTypeTelegram]];
}

#pragma mark - Privite

- (NSArray *)_convertToImages:(id)data
{
    if ([data isKindOfClass:[NSArray class]])
    {
        NSMutableArray *imageArr = [NSMutableArray array];
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SSDKImage *item = [SSDKImage imageWithObject:obj];
            if (item)
            {
                [imageArr addObject:item];
            }
            
        }];
        return imageArr;
    }
    else if (data)
    {
        SSDKImage *item = [SSDKImage imageWithObject:data];
        if (item)
        {
            return @[item];
        }
    }
    
    return nil;
}

- (void)SSDKEnableUseClientShare {
    ReleaseLog(@"Method:%s deprecated !",__func__);
}
- (void)SSDKEnableExtensionShare {
    ReleaseLog(@"Method:%s deprecated !",__func__);
}

- (void)SSDKSetupTwitterParamsByText:(NSString *)text
                              images:(id)images
                            latitude:(double)latitude
                           longitude:(double)longitude
                                type:(SSDKContentType)type __deprecated_msg("Discard form v4.2.0, using \"SSDKSetupTwitterParamsByText:images:video:latitude:longitude:type:\" instead.")
{
    [self SSDKSetupTwitterParamsByText:text images:images video:nil latitude:latitude longitude:longitude type:type];
}

- (void)SSDKSetupTwitterParamsByText:(NSString *)text
                               video:(NSURL*)video
                            latitude:(double)latitude
                           longitude:(double)longitude
                                 tag:(NSString *)str
{
    [self SSDKSetupTwitterParamsByText:text images:nil video:video latitude:latitude longitude:longitude type:SSDKContentTypeAuto];
}

@end
