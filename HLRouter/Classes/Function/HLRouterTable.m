//
//  HLRouterTable.m
//  SocialPlatform
//
//  Created by Lucius on 2017/5/24.
//  Copyright © 2017年 Beauty Information Technology Co.,Ltd. All rights reserved.
//

#import "HLRouterTable.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "HLRouterTable requires ARC support."
#endif

NSString *const HLRouterTablePageId = @"pageId";
NSString *const HLRouterTablePageName = @"page";
NSString *const HLRouterTableDescrption = @"description";
NSString *const HLRouterTableReportId = @"reportId";
NSString *const HLRouterTableTransition = @"transition";

@interface HLRouterTable ()
@property (nonatomic, strong) NSDictionary *routingTableDic;
@end

@implementation HLRouterTable

-(instancetype)initWithTableName:(NSString*)routerTableName {
    self = [super init];
    if (self && routerTableName) {
        NSString *file = [[NSBundle mainBundle] pathForResource:routerTableName ofType:nil];
        self.routingTableDic = [NSDictionary dictionaryWithContentsOfFile:file];
    }
    return self;
}

- (NSString *)pageIdByPageName:(NSString *)pageName {
    NSArray *allKeys = self.routingTableDic.allKeys;
    for (NSString *key in allKeys) {
        NSDictionary *detailDic = self.routingTableDic[key];
        NSString *tmpPageName = detailDic[HLRouterTablePageName];
        if (tmpPageName && [tmpPageName isKindOfClass:[NSString class]] && [tmpPageName isEqualToString:pageName]) {
            return key;
        }
    }
    return nil;
}

- (NSString *)pageNameByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSString *pageName = detailDic[HLRouterTablePageName];
    return pageName;
}

- (NSString *)pageDescriptionByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSString *pageDescription = detailDic[HLRouterTableDescrption];
    return pageDescription;
}

- (NSString *)reportIdByPageID:(NSString *)pageId{
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSString *pageReportId = detailDic[HLRouterTableReportId];
    return pageReportId;
}

- (UIViewController *)viewControllerByPageId:(NSString *)pageId {
    NSString *pageName = [self pageNameByPageId:pageId];
    Class aClass = NSClassFromString(pageName);
    id vc = [[aClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

- (UIViewController *)viewControllerByPageName:(NSString *)pageName {
    Class aClass = NSClassFromString(pageName);
    id vc = [[aClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}

- (NSDictionary *)pageDetailInfoByPageId:(NSString *)pageId {
    NSDictionary *detailDic = self.routingTableDic[pageId];
    NSMutableDictionary *detailMDic = [NSMutableDictionary dictionaryWithDictionary:detailDic];
    [detailMDic setObject:pageId forKey:HLRouterTablePageId];
    return detailMDic;
}

- (NSDictionary *)pageDetailInfoByPageName:(NSString *)pageName {
    NSArray *allKeys = self.routingTableDic.allKeys;
    for (NSString *key in allKeys) {
        NSDictionary *detailDic = self.routingTableDic[key];
        NSString *tmpPageName = detailDic[@"page"];
        if (tmpPageName && [tmpPageName isKindOfClass:[NSString class]] && [tmpPageName isEqualToString:pageName]) {
            NSMutableDictionary *detailMDic = [NSMutableDictionary dictionaryWithDictionary:detailDic];
            [detailMDic setObject:key forKey:HLRouterTablePageId];
            return detailMDic;
        }
    }
    return nil;
}


@end
