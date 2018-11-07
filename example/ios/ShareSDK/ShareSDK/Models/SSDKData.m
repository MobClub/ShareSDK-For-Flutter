//
//  SSDKData.m
//  ShareSDK
//
//  Created by fenghj on 15/6/5.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKData.h"
#import "SSDKImage.h"

static NSInteger fileIndex = 0;

@interface SSDKData()

@property (strong, nonatomic) NSURL *URL;

@end

@implementation SSDKData

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

- (id)initWithData:(NSData *)data
{
    if (!data)
    {
        return nil;
    }
    
    if (self = [super init])
    {
        //将数据保存到本地的临时目录下
        
        //写入本地
        NSString *localImageFile = [NSString stringWithFormat:@"%@d%.0f%ld", NSTemporaryDirectory(), [[NSDate date] timeIntervalSince1970], (long)fileIndex];
        fileIndex ++;
        [data writeToFile:localImageFile atomically:YES];
        
        self.URL = [NSURL fileURLWithPath:localImageFile];
    }
    return self;
}

- (NSString *)description
{
    if (self.URL.isFileURL)
    {
        return self.URL.path;
    }
    
    return self.URL.absoluteString;
}

+ (instancetype)dataWithObject:(id)object
{
    SSDKData *data = nil;
    if ([object isKindOfClass:[NSData class]])
    {
        data = [[SSDKData alloc] initWithData:object];
    }
    else if ([object isKindOfClass:[UIImage class]])
    {
        //转化为PNG的数据
        NSData *tmpData = UIImagePNGRepresentation(object);
        NSString *localImageFile = [NSString stringWithFormat:@"%@d%.0f%ld.png", NSTemporaryDirectory(), [[NSDate date] timeIntervalSince1970], (long)fileIndex];
        fileIndex ++;
        [tmpData writeToFile:localImageFile atomically:YES];
        
        data = [[SSDKData alloc] initWithURL:[NSURL fileURLWithPath:localImageFile]];
    }
    else if ([object isKindOfClass:[NSURL class]])
    {
        data = [[SSDKData alloc] initWithURL:object];
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSData *tmpData = [NSData dataWithContentsOfFile:object];
        data = [[SSDKData alloc] initWithData:tmpData];
    }
    else if ([object isKindOfClass:[SSDKData class]])
    {
        data = object;
    }
    else if ([object isKindOfClass:[SSDKImage class]])
    {
        data = [[SSDKData alloc] initWithURL:[object URL]];
    }
    
    return data;
}

@end
