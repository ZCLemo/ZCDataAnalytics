//
//  ZCBaseEntity.m
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import "ZCBaseEntity.h"

@implementation ZCBaseEntity

+ (instancetype)objectWithJsonDictionary:(NSDictionary *)dict
{
    NSError *error = nil;
    id selfObj = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dict error:&error];
    
    if(error)
    {
        NSLog(@"响应数据转换发生错误:%@",error);
    }
    return selfObj;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSArray *propertys = [[[self class] propertyKeys] allObjects];
    return [NSDictionary dictionaryWithObjects:propertys forKeys:propertys];
}

- (NSDictionary *)jsonDictionary
{
    NSError *error = nil;
    NSDictionary *propertys = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    if(error)
    {
        NSLog(@"Model转Dictionary错误:%@",[error localizedDescription]);
        return nil;
    }
    return propertys;
}

- (NSString *)jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self jsonDictionary] options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}


@end
