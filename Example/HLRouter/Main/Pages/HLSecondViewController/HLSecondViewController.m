//
//  HLSecondViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/8/1.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLSecondViewController.h"
#import "HLPickerController.h"

@interface HLSecondViewController ()

@end

@implementation HLSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackIcon:[UIImage imageNamed:@"HLTopBarBack"]];

    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    [secondBtn setTitle:@"网页" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor blackColor]];
    [secondBtn addTarget:self action:@selector(pressweb:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];

    UIButton *newBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, 100, 20)];
    [newBtn setTitle:@"新页面" forState:UIControlStateNormal];
    [newBtn setBackgroundColor:[UIColor blackColor]];
    [newBtn addTarget:self action:@selector(pressSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBtn];
    
    UIButton *new2Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 500, 100, 20)];
    [new2Btn setTitle:@"第三页" forState:UIControlStateNormal];
    [new2Btn setBackgroundColor:[UIColor blackColor]];
    [new2Btn addTarget:self action:@selector(pressThirdView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:new2Btn];
    
    // Do any additional setup after loading the view.
}

- (void)pressweb:(id)sender{
    UIViewController *webViewController = [self HL_viewControllerWithPageName:@"HLWebViewController" otherParam:@{@"url":@"https://www.baidu.com"}];
    [self HL_jumpToViewControllerWithViewController:webViewController animated:YES targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}

- (void)pressSecondView:(id)sender{

    HLRouterConfigureModel *configureModel = [[HLRouterConfigureModel alloc] init];
    configureModel.appKey = @"hl";
    configureModel.routerTableName = @"HLRouterTable.plist";
    configureModel.errerErrorViewControllerClass = NSClassFromString(@"HLErrorViewController");
    configureModel.webViewControllerClass = NSClassFromString(@"HLWebViewController");
    HLPickerController *picker = [[HLPickerController alloc] initWithConfigureModel:configureModel jumpURL:@"hl://goto?type=inner_app&pid=600002"];

    [self HL_jumpToViewControllerWithViewController:picker animated:YES targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPresent];

}

- (void)pressThirdView:(id)sender{
    [self HL_jumpToViewControllerWithPageName:@"HLThirdViewController" otherParam:nil animated:YES targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
    
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
