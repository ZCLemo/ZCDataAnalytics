//
//  ZCAnalyticsApplicationStart.m
//  Wealth
//
//  Created by 赵琛 on 2017/7/10.
//  Copyright © 2017年 利得财富. All rights reserved.
//

#import "ZCAnalyticsApplicationStart.h"

@implementation ZCAnalyticsApplicationStartData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.terminal = @"app";
        self.terminalType = @"ios";
//        self.clientVersion = [LFSystemInfo appVersion];
//        self.platform = [LFSystemInfo platform];
//        self.ratio = [LFSystemInfo resolutionRatio];
//        self.carrier = [LFSystemInfo carrierInfo];
//        self.equipId = [LFSystemInfo deviceUUID];
//        self.vendorId = [LFSystemInfo identifierForVendor];
//        self.custId = [WAccountCenter sharedInstance].enMemberId;
//        self.idfa = [LFSystemInfo idfa];
        self.type = @"start";
        long long time = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
        self.custTime = [NSString stringWithFormat:@"%lld",time];
    }
    return self;
}

@end

@implementation ZCAnalyticsApplicationStartReq


@end

@implementation ZCAnalyticsApplicationStart

@end
