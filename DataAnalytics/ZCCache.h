//
//  ZCCache.h
//  LeadbankFoundation
//
//  Created by 赵琛 on 16/5/14.
//  Copyright © 2016年 利得财富. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  缓存文件夹
 */
extern NSString *ZCC_CACHE_FOLDER_NAME;
/**
 *  过期时间
 */
extern NSString *ZCC_CACHE_TIMEOUT_KEY;

@interface ZCCache : NSObject

/**
 *  查看指定key是否存在值
 *
 *  @param key 指定存储key
 *
 *  @return YES/NO
 */
+ (BOOL)hasObjectForKey:(NSString *)key;

/**
 *  获取指定key的值
 *
 *  @param key 指定key
 *
 *  @return id
 */
+ (id)objectForKey:(NSString *)key;

/**
 *  存储
 *
 *  @param value 值
 *  @param key   key
 */
+ (void)setObject:(id)value forKey:(NSString *)key;

/**
 *  存储
 *
 *  @param value        值
 *  @param key          key
 *  @param secs 过期时间:秒
 */
+ (void)setObject:(id)value forKey:(NSString *)key timeoutInterval:(NSTimeInterval)secs;

/**
 *  移除指定key
 *
 *  @param key key
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 *  重置当前所有存储
 */
+ (void)removeAllObjects;

@end
