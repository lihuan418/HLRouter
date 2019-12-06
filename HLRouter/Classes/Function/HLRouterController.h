//
//  HLRouterController.h
//  Pods
//
//  Created by Lucius on 2017/7/31.
//
//

#import <UIKit/UIKit.h>
#import "HLRouterConstant.h"
#import "HLRouterConfigureModel.h"
#import "HLRouterControllerProtocol.h"

/* 使用连接跳转时候的拼接示例
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=inner_web&pid=100009999&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"]; 跳转内部web
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=inner_app&pid=100003&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"];跳转内部页面
 NSString *urlString = [NSString stringWithFormat:@"sns://goto?type=outside_app&pkgname=&durl=https%3a%2f%2fcuxiao.m.suning.com%2fscms%2fcw03.html%3futm_source%3ddsp-ay%26utm_medium%3das-cw1-30ll2-in5%26adtypecode%3d1002%26adid%3dhttps%253a%252f%252fcuxiao.m.suning.com%252fscms%252fcw03.html%253futm_source%253ddsp-ay%2526utm_medium%253das-cw1-30ll2-in5%26utm_campaign%3d%252c3%252ca691f49313b24ea197107a1406aa9cf7%26utm_term%3dfzjq4kzfggsu3k5d6ipl0psfgahe58%26adtype%3d7&ourl=openapp.jdmobile%3a%2f%2fvirtual%3fparams%3d%257B%2522category%2522%253A%2522jump%2522%252C%2522des%2522%253A%2522m%2522%252C%2522url%2522%253A%2522http%253A%252F%252Fccc-x.jd.com%252Fdsp%252Fcl%253Fposid%253D1999%2526v%253D707%2526union_id%253D1000023384%2526pid%253D66672%2526tagid%253D111068%2526didmd5%253D__IMEI__%2526idfamd5%253D__IDFA__%2526did%253D__IMEIIMEI__%2526idfa%253D__IDFAIDFA__%2526to%253Dhttp%253A%252F%252Fwww.jd.com%2522%252C%2522m_param%2522%253A%257B%2522jdv%2522%253A%2522122270672%257Ckong%257Ct_1000023384_111068%257Czssc%257Cd36d13b9-61c4-4fdf-b7f2-11dbc28d14dd-p_1999-pr_66672-at_111068%2522%257D%252C%2522keplerFrom%2522%253A%25221%2522%252C%2522kepler_param%2522%253A%257B%2522source%2522%253A%2522kepler-open%2522%252C%2522otherData%2522%253A%257B%2522channel%2522%253A%2522b4dc3278288f4a25982ccdec07ebdc41%2522%257D%257D%257D"];跳转外部app
 NSString *urlString = [NSString stringWithFormat:@"jane://goto?type=outside_web&pid=100009999&webTitle%@&request=%@",@"hahah",@"http://wwww.baidu.com"];跳转外部web
 */


@interface HLRouterController : NSObject

@property (nonatomic, weak,readonly) UINavigationController *navigator;

- (instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel;

- (void)registWithNavigator:(UINavigationController *)navigator;

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated;

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName
                              otherParam:(NSDictionary*)otherParam
                                animated:(BOOL)animated;

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName
                              otherParam:(NSDictionary*)otherParam
                                animated:(BOOL)animated
                          targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                               jumpStyle:(HLRouterJumpStyle)jumpStyle;

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam
                              animated:(BOOL)animated ;

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam
                              animated:(BOOL)animated
                        targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                             jumpStyle:(HLRouterJumpStyle)jumpStyle ;

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString
                               otherParam:(NSDictionary*)otherParam
                                 animated:(BOOL)animated
                           targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                jumpStyle:(HLRouterJumpStyle)jumpStyle;

- (BOOL)jumpToViewControllerWithViewController:(UIViewController *)viewController
                                      animated:(BOOL)animated
                                targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack
                                     jumpStyle:(HLRouterJumpStyle)jumpStyle ;

- (BOOL)popoverPresentationControllerAnimated:(BOOL)animated ;

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString;

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam;

- (UIViewController*)viewControllerWithParams:(NSMutableDictionary *)params;

- (UIViewController*)viewControllerWithPageName:(NSString *)pageName;

- (UIViewController*)viewControllerWithPageName:(NSString *)pageName otherParam:(NSDictionary*)otherParam;

- (UIViewController*)viewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam;

@end
