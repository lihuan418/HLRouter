//
//  HLBaseViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/7/31.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLBaseViewController.h"

@interface HLBaseViewController ()

@end

@implementation HLBaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addCustomNavMethod];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)addCustomNavMethod{
    
    // 导航栏
    self.customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    [self.customNavigationBar setBackgroundImage:[UIImage imageNamed:@"HLTopBarBackGround"] forBarMetrics:UIBarMetricsDefault];
    //标题栏
    self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 24)];
    [self.customNavigationBar addSubview:self.navTitleLabel];
    self.navTitleLabel.text = self.title;
    self.navTitleLabel.textColor = [UIColor blackColor];
    self.navTitleLabel.font = [UIFont systemFontOfSize:17];
    self.navTitleLabel.backgroundColor = [UIColor clearColor];
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.customNaviagtionItem = [[UINavigationItem alloc] init];
    [self.customNavigationBar pushNavigationItem:self.customNaviagtionItem animated:NO];
    
    self.customNavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                 NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.customNavigationBar.clipsToBounds = YES;
    
    self.automaticallyAdjustsScrollViewInsets = false;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.customNavigationBar) {
        [self.view addSubview:self.customNavigationBar];
        [self.view bringSubviewToFront:self.customNavigationBar];
        CGFloat margin = 0;
        
        if (self.customNaviagtionItem.leftBarButtonItem || self.customNaviagtionItem.rightBarButtonItem) {
            margin = 70;
        }
        
        CGRect frame =  self.navTitleLabel.frame;
        frame.origin.x = margin;
        frame.size.width = [[UIScreen mainScreen] bounds].size.width - margin * 2;
        self.navTitleLabel.frame = frame;
    }
}

#pragma mark - 设置导航栏按钮

/**
 * 添加返回按钮
 * @param icon 按钮图片
 */
- (UIButton *)addBackIcon:(UIImage *)icon {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:icon forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateHighlighted];
    
    // 设置Frame
    CGFloat imageSizeW = icon.size.width;  // 强制默认为44
    CGFloat imageSizeH = icon.size.height;
    button.frame = CGRectMake(0, 0 , imageSizeW , imageSizeH);
    button.contentMode = UIViewContentModeScaleAspectFit;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -13.5, 0, 20);
    
    
    [button addTarget:self action:@selector(HL_pressBackAlphaButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(HL_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(HL_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.customNaviagtionItem setLeftBarButtonItem:buttonItem animated:YES];
    
    return button;
}

#pragma mark - 事件

- (void)HL_pressBackAlphaButtonUp:(UIButton *)button {
    [self HL_popoverPresentationControllerAnimated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 1;
    } completion:^(BOOL finished) {
        button.alpha = 1;
    }];
}

- (void)HL_pressAlphaButtonDown:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 0.2f;
    } completion:^(BOOL finished) {
        button.alpha = 0.2f;
    }];
}

- (void)HL_pressAlphaButtonCancel:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 1;
    } completion:^(BOOL finished) {
        button.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
