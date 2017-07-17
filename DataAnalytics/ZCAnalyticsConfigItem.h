//
//  ZCAnalyticsConfigItem.h
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSingleton.h"

@interface ZCAnalyticsConfigItem : NSObject

ZC_DEF_SINGLETON(ZCAnalyticsConfigItem);

@property (nonatomic,strong)NSDictionary *configItemDictionary;

@end
