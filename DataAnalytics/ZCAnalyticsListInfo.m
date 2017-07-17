//
//  WAnalyticsListInfo.m
//  Wealth
//
//  Created by 赵琛 on 2017/7/7.
//  Copyright © 2017年 利得财富. All rights reserved.
//

#import "ZCAnalyticsListInfo.h"

@implementation ZCAnalyticsBrowse

@end

@implementation ZCAnalyticsEvent


@end

@implementation ZCAnalyticsListInfo

- (instancetype)init
{
    if (self = [super init]) {
        long long time = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
        self.custTime = [NSString stringWithFormat:@"%lld",time];
    }
    return self;
}

+ (NSValueTransformer *)browseJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ZCAnalyticsBrowse.class];
}

+ (NSValueTransformer *)eventJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ZCAnalyticsEvent.class];
}

@end

@implementation ZCAnalyticsListData

- (instancetype)init
{
    if(self = [super init])
    {
        self.terminal = @"app";
        self.type = @"common";
    }
    return self;
}

+ (NSValueTransformer *)listJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass: ZCAnalyticsListInfo.class];
}


@end
