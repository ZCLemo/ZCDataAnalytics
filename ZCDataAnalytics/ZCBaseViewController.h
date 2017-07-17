//
//  ZCBaseViewController.h
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCBaseViewController : UIViewController

//用于记录页面统计的名称，当做属性的话只要页面不销毁就一直存在，就不用每次都到plist里面取，提供性能
@property (nonatomic,strong)NSString *pageAnalyticsName;

@end
