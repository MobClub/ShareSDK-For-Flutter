//
//  SSDKImage.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/25.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKImage.h"

NSString *const SSDKImageFormatJpeg             = @"JPEG";
NSString *const SSDKImageFormatPng              = @"PNG";
NSString *const SSDKImageSettingQualityKey      = @"JPEG-IMAGE-QUALITY";

@interface SSDKImage ()

@property (nonatomic, strong) MOBFImageGetter *theGetter;
@property (nonatomic, strong) MOBFImageObserver *theObserver;

@end

@implementation SSDKImage

- (id)initWithURL:(NSURL *)URL
{
    if (!URL)
    {
        return nil;
    }
    
    if (self = [super init])
    {
        self.URL = URL;
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image format:(NSString *)format settings:(NSDictionary *)settings
{
    if (!image)
    {
        return nil;
    }
    
    if (self = [super init])
    {
        //将图片保存到本地的临时目录下
        NSData *imageData = nil;
        NSString *fileExt = nil;
        
        if ([format isEqualToString:SSDKImageFormatPng])
        {
            fileExt = @"png";
            imageData = UIImagePNGRepresentation(image);
        }
        else
        {
            fileExt = @"jpg";
            CGFloat quality = 1.0;
            NSNumber *imageQualityNum = settings [SSDKImageSettingQualityKey];
            if (imageQualityNum != nil)
            {
                quality = [imageQualityNum floatValue];
            }
            
            imageData = UIImageJPEGRepresentation(image, quality);
        }
        
        if (!imageData)
        {
            return nil;
        }
        
        //写入本地
        static NSInteger fileIndex = 0;
        NSString *localImageFile = [NSString stringWithFormat:@"%@i%.0f%ld.%@", NSTemporaryDirectory(), [[NSDate date] timeIntervalSince1970], (long)fileIndex, fileExt];
        fileIndex ++;
        [imageData writeToFile:localImageFile atomically:YES];
        
        self.URL = [NSURL fileURLWithPath:localImageFile];
    }
    return self;
}

- (void)getNativeImage:(void(^)(UIImage *image))handler
{
    _theGetter = [MOBFImageGetter sharedInstance];
    _theObserver = [[MOBFImageGetter sharedInstance] getImageWithURL:self.URL
                                                              result:^(UIImage *image, NSError *error) {
                                                                  
                                                                  if (error)
                                                                  {
                                                                      if (handler)
                                                                      {
                                                                          handler(nil);
                                                                      }
                                                                  }
                                                                  else
                                                                  {
                                                                      if (handler)
                                                                      {
                                                                          handler(image);
                                                                      }
                                                                  }
                                                              }];
}

- (void)getNativeImageData:(void(^)(NSData *imageData))handler
{
    _theGetter = [MOBFImageGetter sharedInstance];
    _theObserver = [[MOBFImageGetter sharedInstance] getImageDataWithURL:self.URL result:^(NSData *imageData, NSError *error) {
        
        if (error)
        {
            if (handler)
            {
                handler(nil);
            }
        }
        else
        {
            if (handler)
            {
                handler(imageData);
            }
        }
    }];
}

-(void)dealloc
{
//    NSLog(@"ssdkimage dealloc");
    [_theGetter removeImageObserver:_theObserver];
    _theObserver = nil;
    _theGetter = nil;
}

- (NSString *)description
{
    if (self.URL.isFileURL)
    {
        return self.URL.path;
    }
    
    return self.URL.absoluteString;
}

/**
 *  获取图片数据
 *
 *  @param imagePath      图片路径
 *  @param thumbImagePath 缩略图路径
 *  @param handler        返回回调
 */
+ (void)getImage:(NSString *)imagePath
  thumbImagePath:(NSString *)thumbImagePath
          result:(void(^)(NSData *thumbImage, NSData *image))handler
{
    NSURL *thumbImageURL = nil;
    NSURL *imageURL = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([MOBFRegex isMatchedByRegex:@"^(file\\:/)?/" options:MOBFRegexOptionsCaseless inRange:NSMakeRange(0, thumbImagePath.length) withString:thumbImagePath])
    {
        if ([fileManager fileExistsAtPath:thumbImagePath isDirectory:NULL])
        {
            //存在缩略图
            thumbImageURL = [NSURL fileURLWithPath:thumbImagePath];
        }
    }
    else
    {
        thumbImageURL = [NSURL URLWithString:thumbImagePath];
    }
    
    if ([MOBFRegex isMatchedByRegex:@"^(file\\:/)?/" options:MOBFRegexOptionsCaseless inRange:NSMakeRange(0, imagePath.length) withString:imagePath])
    {
        if ([fileManager fileExistsAtPath:imagePath isDirectory:NULL])
        {
            //存在缩略图
            imageURL = [NSURL fileURLWithPath:imagePath];
        }
    }
    else
    {
        imageURL = [NSURL URLWithString:imagePath];
    }
    
    if (imageURL)
    {
        __weak __typeof__ (self) weakSelf = self;
        [self _getImage:imageURL onResult:^(NSData *imageData) {
            
            if (thumbImageURL)
            {
                [weakSelf _getImage:thumbImageURL onResult:^(NSData *thumbImageData) {
                    
                    if (handler)
                    {
                        handler (thumbImageData, imageData);
                    }
                    
                }];
            }
            else
            {
                //根据原图生成缩略图, 400 * 400尺寸
                NSData *thumbImageData = nil;
                if (imageData)
                {
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    UIImage *thumbImage = [MOBFImage scaleImage:image withSize:CGSizeMake(image.size.width * .75, image.size.height * .75)];
                    thumbImageData = UIImageJPEGRepresentation(thumbImage, 0.75);
                }
                
                if (handler)
                {
                    handler (thumbImageData, imageData);
                }
            }
        }];
    }
    else if (thumbImageURL)
    {
        [self _getImage:thumbImageURL
               onResult:^(NSData *thumbImageData){
             if (handler)
             {
                 handler (thumbImageData, thumbImageData);
             }
         }];
    }
}

+ (void)_getImage:(NSURL *)url onResult:(void(^)(NSData *imageData))handler
{
    [[MOBFImageGetter sharedInstance] getImageDataWithURL:url
                                                   result:^(NSData *imageData, NSError *error) {
                                                       if (error)
                                                       {
                                                           if (handler)
                                                           {
                                                               handler(nil);
                                                           }
                                                       }
                                                       else
                                                       {
                                                           if (handler)
                                                           {
                                                               handler(imageData);
                                                           }
                                                       }
                                                   }];
}

+ (NSData *)checkThumbImageSize:(NSData *)thumbImageData
{
    static NSInteger maxThumbImageDataLen = 32 * 1024;
    static CGFloat thumbImageCompressionQuality = 0.75;
    
    if (thumbImageData.length > maxThumbImageDataLen)
    {
        UIImage *image = [[UIImage alloc] initWithData:thumbImageData];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        
        if (data.length > maxThumbImageDataLen)
        {
            if(image.size.width > 400 || image.size.height > 400)
            {
                //尺寸减到400＊400
                image = [MOBFImage scaleImage:image withSize:CGSizeMake(400, 400)];
                data = UIImageJPEGRepresentation(image, 0.5);
            }
            
            if (data.length > maxThumbImageDataLen)
            {
                //尺寸减到250＊250
                if (image.size.width > 250 || image.size.height > 250)
                {
                    image = [MOBFImage scaleImage:image withSize:CGSizeMake(250, 250)];
                    data = UIImageJPEGRepresentation(image, thumbImageCompressionQuality);
                }
                
                if(data.length > maxThumbImageDataLen)
                {
                    //尺寸减到200＊200
                    if (image.size.width > 150 || image.size.height > 150)
                    {
                        image = [MOBFImage scaleImage:image withSize:CGSizeMake(150, 150)];
                        data = UIImageJPEGRepresentation(image, thumbImageCompressionQuality);
                    }
                    
                    if (data.length > maxThumbImageDataLen)
                    {
                        if (image.size.width > 100 || image.size.height > 100)
                        {
                            //尺寸减到100*100
                            image = [MOBFImage scaleImage:image withSize:CGSizeMake(100, 100)];
                            data = UIImageJPEGRepresentation(image, thumbImageCompressionQuality);
                        }
                    }
                }
            }
        }
        thumbImageData = data;
    }
    
    return thumbImageData;
}

#pragma mark - Private

+ (instancetype)imageWithObject:(id)object
{
    SSDKImage *image = nil;
    
    if ([object isKindOfClass:[UIImage class]])
    {
        image = [[SSDKImage alloc] initWithImage:object
                                          format:SSDKImageFormatPng
                                        settings:nil];
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        if ([MOBFRegex isMatchedByRegex:@"^(file\\:/)?/"
                                options:MOBFRegexOptionsCaseless
                                inRange:NSMakeRange(0, [object length])
                             withString:object])
        {
            //本地图片
            if ([[NSFileManager defaultManager] fileExistsAtPath:object isDirectory:NULL])
            {
                image = [[SSDKImage alloc] initWithURL:[NSURL fileURLWithPath:object]];
            }
        }
        else
        {
            //网络图片
            image = [[SSDKImage alloc] initWithURL:[NSURL URLWithString:object]];
        }
    }
    else if ([object isKindOfClass:[NSURL class]])
    {
        image = [[SSDKImage alloc] initWithURL:object];
    }
    else if ([object isKindOfClass:[SSDKImage class]])
    {
        image = object;
    }
    else if ([object isKindOfClass:[NSData class]])
    {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dataPath = [cachesPath stringByAppendingPathComponent:[MOBFString md5String:[MOBFData hexStringByData:object]]];
        
        NSURL *url = [NSURL fileURLWithPath:dataPath];
        NSError *error;
        [object writeToURL:url options:NSDataWritingAtomic error:&error];
        
        if (!error)
        {
            image = [[SSDKImage alloc] initWithURL:url];
        }
        else
        {
            ReleaseLog(@"%@",error);
        }
    }
    
    return image;
}

@end
