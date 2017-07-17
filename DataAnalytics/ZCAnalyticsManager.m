//
//  ZCAnalyticsManager.m
//  ZCDataAnalytics
//
//  Created by 赵琛 on 2017/7/17.
//  Copyright © 2017年 赵琛. All rights reserved.
//

#import "ZCAnalyticsManager.h"
#import "ZCCache.h"
#import "ZCAnalyticsListInfo.h"
#import <AFNetworking.h>
#import "ZCAnalyticsApplicationStart.h"
#import "ZCAnalyticsResponse.h"
#import "ZCAnalyticsListReq.h"

NSString *const ZCAnalyticsLocalDataSource = @"ZCAnalyticsLocalDataSource";

@interface ZCAnalyticsManager ()

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,assign)BOOL isUploading;

@end

@implementation ZCAnalyticsManager

ZC_IMPL_SINGLETON(ZCAnalyticsManager);

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *array = [ZCCache objectForKey:ZCAnalyticsLocalDataSource];
        self.dataSource = array ? array : [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}


- (void)enterPageName:(NSString *)pageName
{
    [self pageAnalytics:pageName type:@"begin"];
}

- (void)leavePageName:(NSString *)pageName;
{
    [self pageAnalytics:pageName type:@"end"];
}

- (void)analyticsEvent:(NSString *)eventId
{
    if (!self.enable) {
        return;
    }
    
    ZCAnalyticsListInfo *info = [ZCAnalyticsListInfo new];
    info.opeAct = @"event";
    
    ZCAnalyticsEvent *event = [ZCAnalyticsEvent new];
    event.eventId = eventId;
    info.event = event;
    info.attributes = nil;
    if (self.dataSource.count <= self.maxCount) {
        @synchronized (self) {
            [self.dataSource addObject:info];
        }
    }
    [self uploadAnalytics];
}

- (void)pageAnalytics:(NSString *)name type:(NSString *)type
{
    if (!self.enable) {
        return;
    }
    
    ZCAnalyticsListInfo *info = [ZCAnalyticsListInfo new];
    info.opeAct = @"browse";
    
    ZCAnalyticsBrowse *browse = [ZCAnalyticsBrowse new];
    browse.pageName = name;
    browse.type = type;
    info.browse = browse;
    
    if (self.dataSource.count <= self.maxCount) {
        @synchronized (self) {
            [self.dataSource addObject:info];
        }
    }
    
    [self uploadAnalytics];
}


- (void)uploadAnalytics
{
    // 正在上传中不处理
    if(self.isUploading)
    {
        return;
    }
    
    // 未达到上传条数
    if(self.dataSource.count < self.count)
    {
        return;
    }
    
    self.isUploading = YES;
    NSArray *loadArray = nil;
    
    @synchronized (self) {
        loadArray = [self.dataSource subarrayWithRange:NSMakeRange(0, self.count)];
    }
    
    
    //数据上传，根据自己统计后台所需要的格式上传
    __weak typeof(self) weakSelf = self;
    ZCAnalyticsListData *listData = [ZCAnalyticsListData new];
    listData.list = [NSMutableArray arrayWithArray:loadArray];
    NSString *json = [NSString stringWithFormat:@"[%@]",[listData jsonDictionary]];
    
    ZCAnalyticsListReq *req = [ZCAnalyticsListReq new];
    req.datas = json;
    NSDictionary *params = [req jsonDictionary];
    AFHTTPSessionManager *manager = [self manager];

    [manager POST:self.url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZCAnalyticsResponse *response = [ZCAnalyticsResponse objectWithJsonDictionary:responseObject];
        if([response.response.errorCode integerValue] != 0)
        {
            NSLog(@"上传数据失败 %@",response.response.errorMsg);
        }else{
            [weakSelf removeWithRange:NSMakeRange(0, weakSelf.count)];
        }

        weakSelf.isUploading = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.isUploading = NO;
        [weakSelf removeWithRange:NSMakeRange(0, weakSelf.count)];
    }];
}

- (void)removeWithRange:(NSRange)range
{
    @synchronized (self) {
        [self.dataSource removeObjectsInRange:range];
    }
}


- (void)analyticsLoginOrRegister:(NSString *)scene token:(NSString *)token
{
    
}


- (void)analyticsApplicationStart
{
    if (!self.enable) {
        return;
    }
    //数据上传，根据自己统计后台所需要的格式上传
    ZCAnalyticsApplicationStartData *data = [ZCAnalyticsApplicationStartData new];
    
    ZCAnalyticsApplicationStartReq *req = [ZCAnalyticsApplicationStartReq new];
    req.datas = [NSString stringWithFormat:@"[%@]",[data jsonString]];
    
    NSDictionary *params = [req jsonDictionary];
    
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:self.url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZCAnalyticsResponse *response = [ZCAnalyticsResponse objectWithJsonDictionary:responseObject];
        if([response.response.errorCode integerValue] != 0)
        {
            NSLog(@"上传数据失败 %@",response.response.errorMsg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传数据错误 %@",error);
    }];
}


- (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *_manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [_manager.requestSerializer setTimeoutInterval:60];
    // 数据编码格式
    [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"
                      forHTTPHeaderField:@"content-type"];
    // 设置响应参数 自定义设置
    [_manager.responseSerializer setAcceptableContentTypes:
     [NSSet setWithObjects:@"application/json",
      @"text/json",nil]];
    return _manager;
}

- (void)handleNotification:(NSNotification *)notification
{
    // 切换前台事件
    if([notification.name isEqualToString:UIApplicationWillEnterForegroundNotification])
    {
        // 从本地读取上次未完成数据
        NSMutableArray *array = [ZCCache objectForKey:ZCAnalyticsLocalDataSource];
        if(array)
        {
            self.dataSource = array;
        }
        [ZCCache removeObjectForKey:ZCAnalyticsLocalDataSource];
        
    }
    // 切换后台事件
    if([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification])
    {
        [ZCCache setObject:self.dataSource forKey:ZCAnalyticsLocalDataSource];
    }
}


@end
