//
//  ZCCache.m
//  LeadbankFoundation
//
//  Created by 赵琛 on 16/5/14.
//  Copyright © 2016年 利得财富. All rights reserved.
//

#import "ZCCache.h"
#import "ZCSingleton.h"
#import <YYCache.h>

NSString *ZCC_CACHE_FOLDER_NAME = @"com.tswc.cache";
NSString *ZCC_CACHE_TIMEOUT_KEY = @"ZCC_CACHE_TIMEOUT_KEY";

@interface ZCCache()

@property (nonatomic,strong)NSMutableDictionary *timeoutDictionary;
@property (nonatomic,strong)YYCache *cache;

@end

@implementation ZCCache

ZC_IMPL_SINGLETON(ZCCache);

- (instancetype)init
{
    if(self = [super init])
    {
        self.cache = [YYCache cacheWithName:ZCC_CACHE_FOLDER_NAME];
        
        if([self.cache containsObjectForKey:ZCC_CACHE_TIMEOUT_KEY])
        {
            self.timeoutDictionary = (NSMutableDictionary *)[self.cache objectForKey:ZCC_CACHE_TIMEOUT_KEY];
        }
        else
        {
            self.timeoutDictionary = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

+ (void)validateTimeOut:(NSString *)key
{
    if([[ZCCache sharedInstance].timeoutDictionary.allKeys containsObject:key])
    {
        NSDate *invalidDate = [[ZCCache sharedInstance].timeoutDictionary objectForKey:key];
        if([[[NSDate date] earlierDate:invalidDate] isEqualToDate:invalidDate])
        {
            [self removeObjectForKey:key];
            [[ZCCache sharedInstance].cache setObject:[ZCCache sharedInstance].timeoutDictionary forKey:ZCC_CACHE_TIMEOUT_KEY];
        }
    }
}

+ (BOOL)hasObjectForKey:(NSString *)key
{
    [self validateTimeOut:key];
    return [[ZCCache sharedInstance].cache containsObjectForKey:key];
}

+ (id)objectForKey:(NSString *)key
{
    [self validateTimeOut:key];
    return [[ZCCache sharedInstance].cache objectForKey:key];
}

+ (void)setObject:(id)value forKey:(NSString *)key
{
    [[ZCCache sharedInstance].cache setObject:value forKey:key];
}

+ (void)setObject:(id)value forKey:(NSString *)key timeoutInterval:(NSTimeInterval)secs
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:secs];
    [[ZCCache sharedInstance].timeoutDictionary setObject:date forKey:key];
    [[ZCCache sharedInstance].cache setObject:[ZCCache sharedInstance].timeoutDictionary forKey:ZCC_CACHE_TIMEOUT_KEY];
    [[ZCCache sharedInstance].cache setObject:value forKey:key];
}

+ (void)removeObjectForKey:(NSString *)key
{
    [[ZCCache sharedInstance].timeoutDictionary removeObjectForKey:key];
    [[ZCCache sharedInstance].cache removeObjectForKey:key];
}

+ (void)removeAllObjects
{
    [[ZCCache sharedInstance].cache removeAllObjects];
    [[ZCCache sharedInstance].timeoutDictionary removeAllObjects];
}

@end
