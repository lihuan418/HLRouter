//
//  HLNavigationController.h
//  HLRouter
//
//  Created by Lucius on 17/5/4.
//  Copyright © 2017年 Lucius All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLRouterController.h"

@class HLRouterNavigationController;

@interface HLRouterNavigationController : UINavigationController<HLRouterControllerProtocol,HLRouterControllerProperty>

@property (nonatomic, strong) HLRouterController *router;
/**
 *  初始化方法
 *
 *  @param jumpURL 传递的内部页面链接地址，指定初始化跳转界面
 *
 *  示例 jumpURL = @"AppKey://goto?type=inner_app&pid=100001"
 */
-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL;

-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL otherParam:(NSDictionary*)otherParam;

-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL otherParam:(NSDictionary*)otherParam configureViewControllerBlock:(void(^)(UIViewController *viewController))configureViewControllerBlock;

@end
