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
    [self addBackIcon:[UIImage imageNamed:@"topbar_back"]];

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

- (void)pressSecondView:(id)sender{

    HLRouterConfigureModel *configureModel = [[HLRouterConfigureModel alloc] init];
    configureModel.appKey = @"hl";
    configureModel.routerTableName = @"HLRouterTable.plist";
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
