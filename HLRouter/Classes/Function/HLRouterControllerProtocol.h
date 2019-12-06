//
//  HLRouterControllerProtocol.h
//  Pods
//
//  Created by Lucius on 2017/7/28.
//
//

#ifndef HLRouterControllerProtocol_h
#define HLRouterControllerProtocol_h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HLRouterJumpStyle) {
    HLRouterJumpStyleOfPush = 1,
    HLRouterJumpStyleOfPresent
};

@protocol HLRouterControllerProperty <NSObject>

@property (nonatomic, strong) NSString        *pageId;                              // 页面id
@property (nonatomic, strong) NSString        *pageName;                            // 实现类的类名
@property (nonatomic, strong) NSString        *pageDescription;                     // 页面描述
@property (nonatomic, strong) NSDictionary    *param;                               // 页面其他参数
@property (nonatomic, strong) NSString        *reportId;                            // 页面统计Id
@property (nonatomic, copy) void(^targetCallBack)(NSError *error,id responseObject);// 返回targetCallBack
@property (nonatomic, assign) HLRouterJumpStyle jumpStyle;                          // 页面当前跳转类型
@property (nonatomic, weak) UINavigationController* customNavigationController;     // 页面导航控制器

@end

@protocol HLRouterControllerProtocol <NSObject>

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString
                                  otherParam:(NSDictionary*)otherParam
                                    animated:(BOOL)animated;

- (void)HL_jumpToViewControllerWithUrlString:(NSString*)urlString
                                  otherParam:(NSDictionary*)otherParam
                                    animated:(BOOL)animated
                              targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                   jumpStype:(HLRouterJumpStyle)jumpStype;

- (void)HL_jumpToViewControllerWithPageName:(NSString*)pageName
                                 otherParam:(NSDictionary*)otherParam
                                   animated:(BOOL)animated;


- (void)HL_jumpToViewControllerWithPageName:(NSString *)pageName
                              otherParam:(NSDictionary*)otherParam
                                animated:(BOOL)animated
                          targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                               jumpStyle:(HLRouterJumpStyle)jumpStyle;

- (void)HL_jumpToViewControllerWithPageId:(NSString*)pageId
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated;

- (void)HL_jumpToViewControllerWithPageId:(NSString*)pageId
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated
                           targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                jumpStype:(HLRouterJumpStyle)jumpStype;

- (void)HL_jumpToViewControllerWithViewController:(UIViewController *)viewController
                                         animated:(BOOL)animated
                                   targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                        jumpStyle:(HLRouterJumpStyle)jumpStyle;

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName;

- (UIViewController*)HL_viewControllerWithPageName:(NSString *)pageName
                                        otherParam:(NSDictionary*)otherParam;

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId;

- (UIViewController*)HL_viewControllerWithPageId:(NSString *)pageId
                                      otherParam:(NSDictionary*)otherParam;

- (void)HL_popoverPresentationControllerAnimated:(BOOL)animated;

- (void)HL_popToViewControllerWithClassName:(NSString*)ClassName
                                   animated:(BOOL)animated;

@end


#endif /* HLRouterControllerProtocol_h */
