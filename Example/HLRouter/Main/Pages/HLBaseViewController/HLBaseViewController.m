//
//  HLBaseViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/7/31.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLBaseViewController.h"

#define HL_SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define HL_SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)

//按分辨率手动适配
//iphone4
#define HL_isIphone320_480     (HL_SCREEN_WIDTH > 319 && HL_SCREEN_WIDTH < 321 && HL_SCREEN_HEIGHT > 479 && HL_SCREEN_HEIGHT < 481)
//iphone5, iphone6放大版
#define HL_isIphone320_568     (HL_SCREEN_WIDTH > 319 && HL_SCREEN_WIDTH < 321 && HL_SCREEN_HEIGHT > 567 && HL_SCREEN_HEIGHT < 569)
//iphone6, iphone6+放大版
#define HL_isIphone375_667     (HL_SCREEN_WIDTH > 374 && HL_SCREEN_WIDTH < 376 && HL_SCREEN_HEIGHT > 666 && HL_SCREEN_HEIGHT < 668)
//iphone6+
#define HL_isIphone414_736     (HL_SCREEN_WIDTH > 413 && HL_SCREEN_WIDTH < 415 && HL_SCREEN_HEIGHT > 735 && HL_SCREEN_HEIGHT < 737)
//iPhoneX
#define HL_isIphone375_812     (HL_SCREEN_WIDTH > 374 && HL_SCREEN_WIDTH < 376 && HL_SCREEN_HEIGHT > 811 && HL_SCREEN_HEIGHT < 813)
//iPhoneXR/iPhoneXS Max
#define HL_isIphone414_896     (HL_SCREEN_WIDTH > 413 && HL_SCREEN_WIDTH < 415 && HL_SCREEN_HEIGHT > 895 && HL_SCREEN_HEIGHT < 897)
//iPhoneX/iPhoneXR/iPhoneXS MAX
#define HL_isIphoneX_orXR_orXSMax  (HL_isIphone375_812 || HL_isIphone414_896)

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
    if (HL_isIphoneX_orXR_orXSMax) {
        self.customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44+44)];
    }else{
        self.customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20+44)];
    }
    //标题栏
    // 导航栏
    if (HL_isIphoneX_orXR_orXSMax) {
        self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44+10, [[UIScreen mainScreen] bounds].size.width, 24)];
    }else{
        self.navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20+10, [[UIScreen mainScreen] bounds].size.width, 24)];
    }
    
    [self.customNavigationBar addSubview:self.navTitleLabel];
    self.navTitleLabel.text = self.title;
    self.navTitleLabel.textColor = [UIColor blackColor];
    self.navTitleLabel.font = [UIFont systemFontOfSize:17];
    self.navTitleLabel.backgroundColor = [UIColor clearColor];
    self.navTitleLabel.textAlignment = NSTextAlignmentCenter;
        

    self.customNavigationBar.clipsToBounds = YES;
    [self.customNavigationBar setBackgroundColor:[UIColor clearColor]];
    self.customNavigationBar.barTintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = false;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.customNavigationBar) {
        [self.view addSubview:self.customNavigationBar];
        [self.view bringSubviewToFront:self.customNavigationBar];
        CGRect frame =  self.navTitleLabel.frame;
        frame.origin.x = 44;
        frame.size.width = [[UIScreen mainScreen] bounds].size.width - 44 * 2;
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
    if (HL_isIphoneX_orXR_orXSMax) {
        button.frame = CGRectMake(0, 44 , imageSizeW , imageSizeH);
    }else{
        button.frame = CGRectMake(0, 20 , imageSizeW , imageSizeH);
    }
    
    button.contentMode = UIViewContentModeScaleAspectFill;
    
    
    [button addTarget:self action:@selector(HL_pressBackAlphaButtonUp:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(HL_pressAlphaButtonDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(HL_pressAlphaButtonCancel:) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpOutside];
    
    [self.customNavigationBar addSubview:button];
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
