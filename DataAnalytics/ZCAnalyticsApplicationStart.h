//
//  ZCAnalyticsApplicationStart.h
//  Wealth
//
//  Created by 赵琛 on 2017/7/10.
//  Copyright © 2017年 利得财富. All rights reserved.
//  程序启动统计

#import "ZCBaseEntity.h"
#import <Foundation/Foundation.h>

@interface ZCAnalyticsApplicationStartData : ZCBaseEntity

@property (nonatomic,strong)NSString *terminal;//数据来源 app/h5

@property (nonatomic,strong)NSString *terminalType;//ios/android 终端类型

@property (nonatomic,strong)NSString *equipId;//app UUID 可作为设备唯一号使用（ios不是非常准确，手机重置后会变）

@property (nonatomic,strong)NSString *vendorId;//安装UUID 每次卸载重新安装会生成一个新的Id

@property (nonatomic,strong)NSString *clientVersion;//客户端应用版本 3.5.0

@property (nonatomic,strong)NSString *platform;//iphone6/iphone7

@property (nonatomic,strong)NSString *ratio;//屏幕分辨率

@property (nonatomic,strong)NSString *carrier;//运营商名称

@property (nonatomic,strong)NSString *custTime;//时间

@property (nonatomic,strong)NSString *custId;//登录后的用户 memberId

@property (nonatomic,strong)NSString *type;//"start"

@property (nonatomic,strong)NSString *idfa;//ios广告标识符(ios新增，此字段除了本次推广以外后期使用的可能性比较大 作为长期保留字段)

@end

@interface ZCAnalyticsApplicationStartReq : ZCBaseEntity

@property (nonatomic,strong)NSString *datas;

@end

@interface ZCAnalyticsApplicationStart : ZCBaseEntity

@end
