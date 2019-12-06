//
//  HLViewController.h
//  HLRouter
//
//  Created by Lucius on 17/5/4.
//  Copyright © 2017年 Lucius All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLRouterControllerProtocol.h"

/**
 社区使用的Controller需要继承这个基类
 */
@interface HLViewController : UIViewController <HLRouterControllerProtocol>

@property (nonatomic, strong) NSString        *pageId;                              // 页面id
@property (nonatomic, strong) NSString        *pageName;                            // 实现类的类名
@property (nonatomic, strong) NSDictionary    *param;                               // 页面其他参数
@property (nonatomic, strong) NSString        *pageDescription;                     // 页面描述
@property (nonatomic, strong) NSString        *reportId;                            // 页面统计Id
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id responseObject);// 返回targetCallBack
@property (nonatomic, assign) HLRouterJumpStyle jumpStyle;                          // 页面当前跳转类型
@property (nonatomic, weak) UINavigationController* customNavigationController;     // 页面导航控制器


@end
