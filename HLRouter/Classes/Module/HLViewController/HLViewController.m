//
//  HLViewController.m
//  HLRouter
//
//  Created by Lucius on 17/5/4.
//  Copyright © 2017年 Lucius All rights reserved.
//

#import "HLViewController.h"
#import "HLRouterNavigationController.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "HLViewController requires ARC support."
#endif

@interface HLViewController ()


@end

@implementation HLViewController

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    [self HL_jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil jumpStype:HLRouterJumpStyleOfPush];
}

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))tmpTargetCallBack jumpStype:(HLRouterJumpStyle)jumpStype {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:tmpTargetCallBack jumpStyle:jumpStype];
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
    
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:targetCallBack jumpStyle:jumpStype];
    }
}

- (void)HL_jumpToViewControllerWithViewController:(UIViewController *)viewController
                                         animated:(BOOL)animated
                                   targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                        jumpStyle:(HLRouterJumpStyle)jumpStyle  {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        [navigationController.router jumpToViewControllerWithViewController:viewController animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
    }
}

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
       return [navigationController.router viewControllerWithPageName:pageName];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName
                                        otherParam:(NSDictionary*)otherParam{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageName:pageName otherParam:otherParam];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageId:pageId otherParam:nil];
    }
    return nil;
}

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId
                                      otherParam:(NSDictionary*)otherParam{
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        return [navigationController.router viewControllerWithPageId:pageId otherParam:otherParam];
    }
    return nil;
}

- (void)HL_popoverPresentationControllerAnimated:(BOOL)animated {
    HLRouterNavigationController *navigationController = (HLRouterNavigationController *)self.customNavigationController;
    if ([navigationController isKindOfClass:[HLRouterNavigationController class]]) {
        if ([self respondsToSelector:@selector(jumpStyle)]) {
            if((HLRouterJumpStyle)[self performSelector:@selector(jumpStyle) withObject:nil] == HLRouterJumpStyleOfPresent ){
                [self dismissViewControllerAnimated:animated completion:nil];
            }else{
                [navigationController.router popoverPresentationControllerAnimated:animated];
            }
        }
    }else{
        if ([self respondsToSelector:@selector(jumpStyle)]) {
            if((HLRouterJumpStyle)[self performSelector:@selector(jumpStyle) withObject:nil] == HLRouterJumpStyleOfPresent ){
                [self dismissViewControllerAnimated:animated completion:nil];
            }
        }
    }
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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - 外部可实现的方法

@end
