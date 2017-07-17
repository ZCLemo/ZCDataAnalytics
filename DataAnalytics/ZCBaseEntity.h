//
//  ZCBaseEntity.h
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ZCBaseEntity : MTLModel<MTLJSONSerializing>

+ (instancetype)objectWithJsonDictionary:(NSDictionary *)dict;

- (NSDictionary *)jsonDictionary;

- (NSString *)jsonString;

@end
