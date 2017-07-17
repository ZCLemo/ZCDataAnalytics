//
//  WAnalyticsListInfo.h
//  Wealth
//
//  Created by 赵琛 on 2017/7/7.
//  Copyright © 2017年 利得财富. All rights reserved.
//

#import "ZCBaseEntity.h"

@interface ZCAnalyticsBrowse : ZCBaseEntity

@property (nonatomic,strong)NSString *pageName;

/**
 begin end
 */
@property (nonatomic,strong)NSString *type;


@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *targetPage;

@end


@interface ZCAnalyticsEvent : ZCBaseEntity

@property (nonatomic,strong)NSString *eventId;

@property (nonatomic,strong)NSString *eventAct;

@property (nonatomic,strong)NSString *eventName;

@end

@interface ZCAnalyticsListInfo : ZCBaseEntity

@property (nonatomic,strong)NSString *networkType;
@property (nonatomic,strong)NSString *custTime;

/**
 browse(浏览)|event(事件)
 */
@property (nonatomic,strong)NSString *opeAct;
@property (nonatomic,strong)NSDictionary *attributes;

@property (nonatomic,strong)ZCAnalyticsBrowse *browse;
@property (nonatomic,strong)ZCAnalyticsEvent *event;

@end

@interface ZCAnalyticsListData : ZCBaseEntity

//@property (nonatomic,strong)NSString *equipId;
//@property (nonatomic,strong)NSString *vendorId;
//@property (nonatomic,strong)NSString *idfa;
//@property (nonatomic,strong)NSString *custId;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *terminal;
@property (nonatomic,strong)NSMutableArray *list;


@end
