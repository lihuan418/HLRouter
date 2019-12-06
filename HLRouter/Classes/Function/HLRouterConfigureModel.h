//
//  HLRouterConfigureModel.h
//  Pods
//
//  Created by Lucius on 2017/7/31.
//
//

#import <Foundation/Foundation.h>

@interface HLRouterConfigureModel : NSObject
@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *routerTableName;
@property (nonatomic, assign) Class webViewControllerClass;
@property (nonatomic, assign) Class errerErrorViewControllerClass;
@end
