//
//  HLRouterTable.h
//  SocialPlatform
//
//  Created by Lucius on 2017/5/24.
//  Copyright © 2017年 Beauty Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const HLRouterTablePageId;
extern NSString *const HLRouterTablePageName;
extern NSString *const HLRouterTableDescrption;
extern NSString *const HLRouterTableReportId;
extern NSString *const HLRouterTableTransition;

@interface HLRouterTable : NSObject

- (instancetype)initWithTableName:(NSString*)routerTableName;

// 通过pageName，转化成pageId
- (NSString *)pageIdByPageName:(NSString *)pageName;

// 通过pageId，转化成pageName
- (NSString *)pageNameByPageId:(NSString *)pageId;

// 通过pageID， 转化成ReportId
- (NSString *)reportIdByPageID:(NSString *)pageId;

// 通过pageId，获取页面描述
- (NSString *)pageDescriptionByPageId:(NSString *)pageId;

// 通过pageID， 转化成viewController
- (UIViewController *)viewControllerByPageId:(NSString *)pageId;

// 通过pageName，转化成viewController
- (UIViewController *)viewControllerByPageName:(NSString *)pageName;

// 获取详细信息
- (NSDictionary *)pageDetailInfoByPageId:(NSString *)pageId;

// 获取详细信息
- (NSDictionary *)pageDetailInfoByPageName:(NSString *)pageName;

@end
