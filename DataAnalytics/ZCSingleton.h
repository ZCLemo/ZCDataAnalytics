//
//  ZCSingleton.h
//  LeadbankFoundation
//
//  Created by 赵琛 on 16/4/12.
//  Copyright © 2016年 利得财富. All rights reserved.
//


/*
 如若需要定义单例
 1：在所需类的头文件中使用ZC_DEF_SINGLETON(类名)
 2：在所需类的.m文件中使用ZC_IMPL_SINGLETON(类名)
 */


// 定义单例
#undef ZC_DEF_SINGLETON
#define ZC_DEF_SINGLETON(__class)\
+ (__class *)sharedInstance;

// 实现单例
#undef ZC_IMPL_SINGLETON
#define ZC_IMPL_SINGLETON(__class)\
static __class *_instance = nil;\
+ (__class *)sharedInstance\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
\
+ (__class *)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
}); \
return _instance;\
}\
\
- (__class *)copyWithZone:(NSZone *)zone\
{ \
return _instance;\
}\
