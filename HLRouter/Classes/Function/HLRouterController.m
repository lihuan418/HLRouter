//
//  HLRouterController.m
//  Pods
//
//  Created by Lucius on 2017/7/31.
//
//

#import "HLRouterController.h"
#import "HLRouterTable.h"
#import "HLViewController.h"
#import <CommonCrypto/CommonCrypto.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "HLRouterController requires ARC support."
#endif

static inline bool HLRouterIsUsableNSString(id aString, NSString *inequalString) {
    if (inequalString == nil) {
        if (aString && [aString isKindOfClass:[NSString class]]) {
            return YES;
        }
    }
    else {
        if (aString && [aString isKindOfClass:[NSString class]] && ![(NSString *)aString isEqualToString:inequalString]) {
            return YES;
        }
    }
    return NO;
}

@interface HLRouterController()
@property (nonatomic, weak)   UINavigationController *navigator;
@property (nonatomic, retain) NSString *kHLRouterAPPKey;
@property (nonatomic, retain) HLRouterConfigureModel *configureModel;
@property (nonatomic, strong) HLRouterTable *routerTable;
@end

@implementation HLRouterController
- (instancetype)initWithConfigureModel:(HLRouterConfigureModel*)configureModel{
    self = [super init];
    if (self && configureModel.appKey && configureModel.routerTableName) {
        self.kHLRouterAPPKey = configureModel.appKey;
        self.routerTable = [[HLRouterTable alloc] initWithTableName:configureModel.routerTableName];
        self.configureModel = configureModel;
    }
    return self;
}

#pragma mark - Public Methods

- (void)registWithNavigator:(UINavigationController *)navigator {
    self.navigator = navigator;
}

- (UIViewController*)viewControllerWithPageName:(NSString *)pageName {
    return [self viewControllerWithPageName:pageName otherParam:nil];
}

- (UIViewController*)viewControllerWithPageName:(NSString *)pageName otherParam:(NSDictionary*)otherParam {
    NSString *pageId = [self.routerTable pageIdByPageName:pageName];
    if (pageId) {
        return [self viewControllerWithPageId:pageId otherParam:otherParam];
    }
    return nil;
}

- (UIViewController*)viewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam{
    if (!pageId) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pageId forKey:kHLRouterPageIdKey];
    [params setObject:kHLRouterActionInnerPage forKey:kHLRouterActionTypeKey];
    
    if (otherParam) {
        [params addEntriesFromDictionary:otherParam];
    }
    
    UIViewController *controller =  [self viewControllerWithParams:params];
    return controller;
}

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString {
    return [self viewControllerWithUrlString:urlString otherParam:nil];
}

- (UIViewController*)viewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam{
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url.scheme isEqualToString:_kHLRouterAPPKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = [self paramWithURL:urlString];
    NSString *pid = param[kHLRouterPageIdKey];
    if (HLRouterIsUsableNSString(pid, @"")) {
        param[HLRouterTablePageId] = pid;
    }
    if (otherParam) {
        [param addEntriesFromDictionary:otherParam];
    }
    return [self viewControllerWithParams:param];
}

- (UIViewController*)viewControllerWithParams:(NSMutableDictionary *)params {
    if (!params) {
        return nil;
    }
    
    if (![[params allKeys] containsObject:kHLRouterActionTypeKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = params;
    NSString *type = param[kHLRouterActionTypeKey];
    NSString *pid = param[kHLRouterPageIdKey];
    
    if (HLRouterIsUsableNSString(pid, @"")) {
        param[HLRouterTablePageId] = pid;
    }else {
        if ([[params allKeys] containsObject:kHLRouterPageNameKey]) {
            pid  = [self.routerTable pageIdByPageName:[params objectForKey:kHLRouterPageNameKey]];
        }
        if (pid) {
            param[HLRouterTablePageId] = pid;
        }
    }
    
    if (param[HLRouterTablePageId]) {
        NSDictionary *routerTableParam = [self.routerTable pageDetailInfoByPageId:param[HLRouterTablePageId]];
        for (NSString *key in [routerTableParam allKeys]) {
            if ([key isEqualToString:HLRouterTablePageId] ||
                [key isEqualToString:HLRouterTablePageName] ||
                [key isEqualToString:HLRouterTableDescrption] ||
                [key isEqualToString:HLRouterTableReportId] ||
                [[params allKeys] containsObject:key]) {
            }else{
                [param setObject:[routerTableParam objectForKey:key] forKey:key];
            }
        }
    }
    
    [self.routerTable pageIdByPageName:[params objectForKey:kHLRouterPageNameKey]];
    
    if (type) {
        if ([type isEqualToString:kHLRouterActionInnerPage]) {          // 内部页面
            if (HLRouterIsUsableNSString(pid, @"")) {
                UIViewController *vc = [self.routerTable viewControllerByPageId:pid];
                if (vc) {
                    if ([vc isKindOfClass:[UIViewController class]]) {
                        
                        if ([vc respondsToSelector:@selector(setPageId:)]) {
                            [vc performSelector:@selector(setPageId:) withObject:pid];
                        }
                        if ([vc respondsToSelector:@selector(setPageName:)]) {
                            [vc performSelector:@selector(setPageName:) withObject:[self.routerTable pageNameByPageId:pid]];
                        }
                        if ([vc respondsToSelector:@selector(setPageDescription:)]) {
                            [vc performSelector:@selector(setPageDescription:) withObject:[self.routerTable pageDescriptionByPageId:pid]];
                        }
                        if ([vc respondsToSelector:@selector(setReportId:)]) {
                            [vc performSelector:@selector(setReportId:) withObject:[self.routerTable reportIdByPageID:pid]];
                        }
                        if ([vc respondsToSelector:@selector(setParam:)]) {
                            [vc performSelector:@selector(setParam:) withObject:param];
                        }
                        if ([vc respondsToSelector:@selector(setCustomNavigationController:)]) {
                            [vc performSelector:@selector(setCustomNavigationController:) withObject:self.navigator];
                        }
                        
                        return vc;
                    }
                }
            }
        }
    }
    return nil;
}

- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    return [self jumpToViewControllerWithUrlString:urlString otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    if (!pageName) {
        return NO;
    }
    return [self jumpToViewControllerWithPageName:pageName otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageName:(NSString *)pageName otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(HLRouterJumpStyle)jumpStyle{
    if (!pageName) {
        return NO;
    }
    UIViewController *controller = [self viewControllerWithPageName:pageName otherParam:otherParam];
    return [self jumpToViewControllerWithViewController:controller animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
}

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam animated:(BOOL)animated {
    if (!pageId) {
        return NO;
    }
    return [self jumpToViewControllerWithPageId:pageId otherParam:otherParam animated:animated targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}

- (BOOL)jumpToViewControllerWithPageId:(NSString *)pageId otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(HLRouterJumpStyle)jumpStyle {
    
    UIViewController *controller = [self viewControllerWithPageId:pageId otherParam:otherParam];
    return [self jumpToViewControllerWithViewController:controller animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
}

- (BOOL)jumpToViewControllerWithViewController:(UIViewController *)viewController animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(HLRouterJumpStyle)jumpStyle {
    
    HLViewController *vc = (HLViewController*)viewController;
    
    if ([vc respondsToSelector:@selector(setTargetCallBack:)]) {
        vc.targetCallBack = targetCallBack;
    }
    
    if ([vc respondsToSelector:@selector(setJumpStyle:)]) {
        vc.jumpStyle = jumpStyle;
    }
    
    if (viewController) {
        if (jumpStyle == HLRouterJumpStyleOfPush) {
            if ([vc isKindOfClass:[HLViewController class]]) {
                if (vc.param[HLRouterTableTransition] &&
                    [vc.param[HLRouterTableTransition] boolValue]) {
                    self.navigator.delegate = vc;
                }else {
                    self.navigator.delegate = nil;
                }
            }else {
                self.navigator.delegate = nil;
            }
            [self.navigator pushViewController:viewController animated:animated];
        }else if (jumpStyle == HLRouterJumpStyleOfPresent){
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
                viewController.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [[[self.navigator viewControllers] lastObject] presentViewController:viewController animated:YES completion:nil];
        }
        return YES;
    }
    return NO;
}


- (BOOL)jumpToViewControllerWithUrlString:(NSString *)urlString otherParam:(NSDictionary*)otherParam animated:(BOOL)animated targetCallBack:(void(^)(NSError * error,id responseObject))targetCallBack jumpStyle:(HLRouterJumpStyle)jumpStyle{
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url.scheme isEqualToString:_kHLRouterAPPKey]) {
        return NO;
    }
    
    NSMutableDictionary *param = [self paramWithURL:urlString];
    NSString *type = param[kHLRouterActionTypeKey];
    NSString *pid = param[kHLRouterPageIdKey];
    if (HLRouterIsUsableNSString(pid, @"")) {
        param[HLRouterTablePageId] = pid;
    }
    
    if (otherParam) {
        [param addEntriesFromDictionary:otherParam];
    }
    
    if (type) {
        if ([type isEqualToString:kHLRouterActionInnerPage]) {          // 内部页面
            if (HLRouterIsUsableNSString(pid, @"")) {
                UIViewController *controller =  [self viewControllerWithParams:param];
                return [self jumpToViewControllerWithViewController:controller animated:animated targetCallBack:targetCallBack jumpStyle:jumpStyle];
            }
        }else if ([type isEqualToString:kHLRouterActionOutsideWebPage]) { // 外部网页
            __block BOOL canOpenUrl = NO ;
            NSString *openUrlString= param[@"request"];
            NSURL *openUrl = [NSURL URLWithString:openUrlString];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                    canOpenUrl = success;
                }];
            }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
#pragma clang diagnostic pop
            }
            return canOpenUrl;
        } else if ([type isEqualToString:kHLRouterActionOutsideApp]) { // 外部app
            __block BOOL canOpenUrl = NO ;
            NSString *outUrlString = param[@"ourl"];
            NSString *dUrlString = param[@"durl"];
            NSString *pkgNameString = param[@"pkgname"];
            NSString *isHandelAlterString = param[@"isHandelAlter"];
            BOOL isHandelAlter = NO;
            
            if (isHandelAlterString && [isHandelAlterString isKindOfClass:[NSString class]] && [isHandelAlterString isEqualToString:@"yes"]) {
                isHandelAlter = YES;
            }
            
            if (outUrlString && [self canjumpToOtherAppWithUrl:outUrlString]) {
                [self jumpToOtherAppWithUrl:outUrlString completionHandler:^(BOOL success) {
                    if (!success && isHandelAlter) {
                        if (dUrlString) {
                            NSURL *openUrl = [NSURL URLWithString:dUrlString];
                            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                                [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                                                                                canOpenUrl = success;
                                                                            }];
                            }else{
                                #pragma clang diagnostic push
                                #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
                                #pragma clang diagnostic pop
                            }
                        }else{
                                                                        
                        }
                    }
                }];
                return YES;
            }else{
                if (pkgNameString && [self canjumpToOtherAppWithUrl:pkgNameString]) {
                    [self jumpToOtherAppWithUrl:pkgNameString completionHandler:^(BOOL success) {
                        if (!success && isHandelAlter) {
                            if (dUrlString) {
                                NSURL *openUrl = [NSURL URLWithString:dUrlString];
                                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                                    [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                                                                                    canOpenUrl = success;
                                                                                }];
                                }else{
                                    #pragma clang diagnostic push
                                    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                                    canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
                                    #pragma clang diagnostic pop
                                }
                            }else{
                                                                            
                            }
                        }
                    }];
                    return YES;
                }else{
                    if (dUrlString) {
                        NSURL *openUrl = [NSURL URLWithString:dUrlString];
                        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
                            [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:^(BOOL success) {
                                canOpenUrl = success;
                            }];
                        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                            canOpenUrl = [[UIApplication sharedApplication] openURL:openUrl];
#pragma clang diagnostic pop
                        }
                    }else{
                        
                    }
                }
            }
            
        
            return canOpenUrl;
        } else {
            
        }
    }
    return NO;
}

- (BOOL)canjumpToOtherAppWithUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
    if (![[UIApplication sharedApplication]canOpenURL:url]) {
        // 不能跳转就不要往下执行了
        return NO;
    }else{
        return YES;
    }
    return YES;
}

- (void)jumpToOtherAppWithUrl:(NSString *)urlString completionHandler:(void (^ __nullable)(BOOL success))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    // 注意: 跳转之前, 可以使用 canOpenURL: 判断是否可以跳转
    if (![[UIApplication sharedApplication]canOpenURL:url]) {
        return;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
            if (completion) {
                completion(success);
            }
        }];
    }else{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        BOOL success = [[UIApplication sharedApplication] openURL:url];
        if (completion) {
            completion(success);
        }
        #pragma clang diagnostic pop
    }
}

- (BOOL)popoverPresentationControllerAnimated:(BOOL)animated {
    if(self.navigator.viewControllers.count == 1){
        [self.navigator dismissViewControllerAnimated:animated completion:nil];
        self.navigator = nil;
    }else if(self.navigator.viewControllers.count > 1){
        [self.navigator popViewControllerAnimated:animated];
        return YES;
    }
    return YES;
}

#pragma mark - Private Methods


- (NSString*)urlEncodeWithString:(NSString*)string{
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)urlDecodeWithString:(NSString*)string{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)string,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
#pragma clang diagnostic pop
    return result;
}

- (NSString *)urlDecodeForPlusConvertToBlankWithString:(NSString*)string {
    NSString *result = [self urlDecodeWithString:string];
    result = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return result;
}

- (NSMutableDictionary*)paramWithURL:(NSString*)URL {
    NSURL *url = [NSURL URLWithString:URL];
    if (![url.scheme isEqualToString:_kHLRouterAPPKey]) {
        return nil;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    NSString *queryStr = [url query];
    for (NSString *paramStr in [queryStr componentsSeparatedByString:@"&"]) {
        NSArray *elts = [paramStr componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            continue;
        }
        
        NSString *valueStr = [elts lastObject];
        valueStr = [self urlDecodeForPlusConvertToBlankWithString:valueStr];
        
        NSString *keyStr = [elts firstObject];
        keyStr = [self urlDecodeForPlusConvertToBlankWithString:keyStr];
        
        [param setObject:valueStr forKey:keyStr];
    }
    NSString *pid = param[kHLRouterPageIdKey];
    if (HLRouterIsUsableNSString(pid, @"")) {
        param[HLRouterTablePageId] = pid;
    }
    return param;
}


@end
