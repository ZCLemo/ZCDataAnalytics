//
//  ZCAnalyticsManager.h
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSingleton.h"

@interface ZCAnalyticsManager : NSObject

ZC_DEF_SINGLETON(ZCAnalyticsManager);

#pragma mark - 需要配置的项
/**
 上传开关
 */
@property (nonatomic,assign)BOOL enable;

/**
 达到多少条上传
 */
@property (nonatomic,assign)NSInteger count;


/**
 本地最多存储数
 */
@property (nonatomic,assign)NSInteger maxCount;

/**
 上传地址
 */
@property (nonatomic,strong)NSString *url;

#pragma mark - 统计

/**
 事件统计
 
 @param eventId 统计id
 */
- (void)analyticsEvent:(NSString *)eventId;

/**
 进入页面加统计
 
 @param pageName 页面编码
 */
- (void)enterPageName:(NSString *)pageName;


/**
 离开页面加统计
 
 @param pageName 页面编码
 */
- (void)leavePageName:(NSString *)pageName;


/**
 统计注册和登录，实时上传
 
 @param scene 场景区分注册还是登录
 @param token token
 */
- (void)analyticsLoginOrRegister:(NSString *)scene token:(NSString *)token;


/**
 统计程序启动，实时上传
 */
- (void)analyticsApplicationStart;

@end
