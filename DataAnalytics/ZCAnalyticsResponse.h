//
//  ZCAnalyticsResponse.h
//  Wealth
//
//  Created by 赵琛 on 2017/7/7.
//  Copyright © 2017年 利得财富. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCBaseEntity.h"

@interface ZCAnalyticsResponseInfo : ZCBaseEntity

@property (nonatomic,strong)NSString *errorCode;
@property (nonatomic,strong)NSString *errorMsg;

@end

@interface ZCAnalyticsResponse : ZCBaseEntity

@property (nonatomic,strong)ZCAnalyticsResponseInfo *response;

@end
