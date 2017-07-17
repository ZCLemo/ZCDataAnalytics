//
//  ZCAnalyticsResponse.m
//  Wealth
//
//  Created by 赵琛 on 2017/7/7.
//  Copyright © 2017年 利得财富. All rights reserved.
//

#import "ZCAnalyticsResponse.h"

@implementation ZCAnalyticsResponseInfo

@end


@implementation ZCAnalyticsResponse


+ (NSValueTransformer *)responseJSONTransformer{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ZCAnalyticsResponseInfo.class];
}

@end
