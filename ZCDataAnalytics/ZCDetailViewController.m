//
//  ZCDetailViewController.m
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import "ZCDetailViewController.h"

@interface ZCDetailViewController ()

@end

@implementation ZCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)detailClick:(id)sender {
    [[ZCAnalyticsManager sharedInstance] analyticsEvent:ZCDetailClickEventId];
}
@end
