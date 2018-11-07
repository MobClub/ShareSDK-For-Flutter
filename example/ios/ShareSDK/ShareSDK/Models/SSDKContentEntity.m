//
//  SSDKContentEntity.m
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/9.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import "SSDKContentEntity.h"
@implementation SSDKContentEntity

@dynamic cid;
@dynamic text;
@dynamic images;
@dynamic urls;
@dynamic rawData;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.images = [NSMutableArray array];
        self.urls = [NSMutableArray array];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.dictionaryValue];
}


@end
