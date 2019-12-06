//
//  HLFirstViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/8/1.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLFirstViewController.h"

@interface HLFirstViewController ()

@end

@implementation HLFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addBackIcon:[UIImage imageNamed:@"HLTopBarBack"]];

    //返回按钮
    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    [secondBtn setTitle:@"第二页" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor redColor]];
    [secondBtn addTarget:self action:@selector(pressSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    // Do any additional setup after loading the view.
}

- (void)addCustomNavMethod{

}

- (void)pressSecondView:(id)sender{
    [self HL_jumpToViewControllerWithPageId:@"600002" otherParam:nil animated:YES];
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
