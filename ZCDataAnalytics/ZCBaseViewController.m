//
//  ZCBaseViewController.m
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import "ZCBaseViewController.h"
#import "ZCAnalyticsConfigItem.h"

@interface ZCBaseViewController ()

@end

@implementation ZCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *itemDict =[ZCAnalyticsConfigItem sharedInstance].configItemDictionary;
    NSString *className = NSStringFromClass(self.class);
    self.pageAnalyticsName = [itemDict objectForKey:className];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.pageAnalyticsName.length > 0) {
        [[ZCAnalyticsManager sharedInstance] enterPageName:self.pageAnalyticsName];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.pageAnalyticsName.length > 0) {
        [[ZCAnalyticsManager sharedInstance] leavePageName:self.pageAnalyticsName];
    }
}

@end
