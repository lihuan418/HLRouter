//
//  HLBaseViewController.h
//  HLRouter
//
//  Created by Lucius on 2017/7/31.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import <HLRouter/HLRouter.h>

@interface HLBaseViewController : HLViewController

@property (nonatomic, strong) UINavigationBar    *customNavigationBar;     //自定义的NavigationBar
@property (nonatomic, strong) UINavigationItem   *customNaviagtionItem;    //NavigationItem
@property (nonatomic, strong) UILabel            *navTitleLabel;           // 导航栏标题栏

- (void)addCustomNavMethod;                //添加导航栏
- (UIButton *)addBackIcon:(UIImage *)icon; //添加返回按钮

@end
