//
//  HLNavigationController.m
//  HLRouter
//
//  Created by Lucius on 17/5/4.
//  Copyright © 2017年 Lucius All rights reserved.
//

#import "HLRouterNavigationController.h"
#import <objc/runtime.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "HLRouterNavigationController requires ARC support."
#endif

@interface HLRouterNavigationController ()

@end

@implementation HLRouterNavigationController

@synthesize pageId = _pageId;                                          // 页面id
@synthesize pageName = _pageName;                                      // 实现类的类名
@synthesize pageDescription = _pageDescription;                        // 页面描述
@synthesize reportId = _reportId;                                      // 页面统计id
@synthesize param = _param;                                            // 页面其他参数
@synthesize targetCallBack = _targetCallBack;                          // 返回targetCallBack
@synthesize jumpStyle = _jumpStyle;                                    // 页面当前跳转类型
@synthesize customNavigationController = _customNavigationController;  // 页面导航控制器

- (void)dealloc{

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Init methods （初始化方法）

-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL{
    return [self initWithConfigureModel:configureModel jumpURL:jumpURL otherParam:nil];
}

-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL otherParam:(NSDictionary*)otherParam{
    return [self initWithConfigureModel:configureModel jumpURL:jumpURL otherParam:otherParam configureViewControllerBlock:nil];
}

-(instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel jumpURL:(NSString*)jumpURL otherParam:(NSDictionary*)otherParam configureViewControllerBlock:(void(^)(UIViewController *viewController))configureViewControllerBlock{
    
    self.router = [[HLRouterController alloc] initWithConfigureModel:configureModel];
    UIViewController *rootViewController = [self.router viewControllerWithUrlString:jumpURL otherParam:otherParam];
    if ([rootViewController respondsToSelector:@selector(setCustomNavigationController:)]) {
        [rootViewController performSelector:@selector(setCustomNavigationController:) withObject:self];
    }
    if (configureViewControllerBlock) {
        configureViewControllerBlock(rootViewController);
    }
    return [self initWithJumpController:rootViewController];
}

-(instancetype)initWithJumpController:(UIViewController*)rootController {
    if (self=[super initWithRootViewController:rootController]) {
        [self.view sendSubviewToBack:self.navigationBar];
        [self.router registWithNavigator:self];
    }
    return self;
}

- (UIViewController*)rootViewControllerWithParams:(NSMutableDictionary*)params {
    UIViewController *rootViewController = [self.router viewControllerWithParams:params];
    return rootViewController;
}

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    [self HL_jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil jumpStype:HLRouterJumpStyleOfPush];
}

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStype:(HLRouterJumpStyle)jumpStype {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStype];
    }
}

- (void)HL_jumpToViewControllerWithPageName:(NSString*)tmpPageName
                                 otherParam:(NSDictionary*)otherParam
                                   animated:(BOOL)animated{
    [self HL_jumpToViewControllerWithPageName:tmpPageName otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}

- (void)HL_jumpToViewControllerWithPageName:(NSString *)pageName
                                 otherParam:(NSDictionary*)otherParam
                                   animated:(BOOL)animated
                             targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                  jumpStyle:(HLRouterJumpStyle)jumpStyle{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithPageName:pageName otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
    }
}

- (void)HL_jumpToViewControllerWithPageId:(NSString*)pageId
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated {
    [self HL_jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:nil jumpStype:HLRouterJumpStyleOfPush];
}

- (void)HL_jumpToViewControllerWithPageId:(NSString*)pageId
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated
                           targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                jumpStype:(HLRouterJumpStyle)jumpStype {
    
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStype];
    }
}

- (void)HL_popoverPresentationControllerAnimated:(BOOL)animated {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router popoverPresentationControllerAnimated:animated];
    }else{
        if (self.jumpStyle == HLRouterJumpStyleOfPresent) {
            [self dismissViewControllerAnimated:animated completion:nil];
        }
    }
}

- (void)HL_jumpToViewControllerWithViewController:(UIViewController *)viewController
                                         animated:(BOOL)animated
                                   targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                        jumpStyle:(HLRouterJumpStyle)jumpStyle  {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithViewController:viewController animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
    }
}

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageName:pageName];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName
                                        otherParam:(NSDictionary*)otherParam{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageName:pageName otherParam:otherParam];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageId:pageId otherParam:nil];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId
                                      otherParam:(NSDictionary*)otherParam{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.navigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageId:pageId otherParam:otherParam];
    }
    return nil;
}

- (void)HL_popToViewControllerWithClassName:(NSString*)ClassName
                                   animated:(BOOL)animated {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        NSArray *vcArr = navigationController.viewControllers;
        UIViewController *popToViewController = nil ;
        for (NSInteger i = 0 ; i < vcArr.count; i++) {
            UIViewController *vc = [vcArr objectAtIndex:(vcArr.count - i - 1)];
            if ([vc isKindOfClass:NSClassFromString(ClassName)]) {
                popToViewController = vc ;
                break;
            }
        }
        if (popToViewController) {
            [navigationController popToViewController:popToViewController animated:animated];
        }
    }
}

@end
