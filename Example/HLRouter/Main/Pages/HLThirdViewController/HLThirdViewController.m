//
//  HLThirdViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/8/1.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLThirdViewController.h"

@interface HLThirdViewController ()

@end

@implementation HLThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackIcon:[UIImage imageNamed:@"HLTopBarBack"]];
    
    UIButton *newBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, 100, 20)];
    [newBtn setTitle:@"回到第一页" forState:UIControlStateNormal];
    [newBtn setBackgroundColor:[UIColor blackColor]];
    [newBtn addTarget:self action:@selector(pressSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressSecondView:(id)sender{
    
    [self HL_popToViewControllerWithClassName:@"HLFirstViewController" animated:YES];
    
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
