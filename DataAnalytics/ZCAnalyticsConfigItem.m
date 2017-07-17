//
//  ZCAnalyticsConfigItem.m
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import "ZCAnalyticsConfigItem.h"

@implementation ZCAnalyticsConfigItem

ZC_IMPL_SINGLETON(ZCAnalyticsConfigItem);

- (NSDictionary *)configItemDictionary
{
    if (!_configItemDictionary) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Analytics" ofType:@"plist"];
        _configItemDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return _configItemDictionary;
}

@end
