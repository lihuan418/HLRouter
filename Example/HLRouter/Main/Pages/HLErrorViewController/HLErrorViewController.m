//
//  HLErrorViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/8/1.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLErrorViewController.h"

@interface HLErrorViewController ()
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, copy) UILabel *errorLabel;
@end

@implementation HLErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackIcon:[UIImage imageNamed:@"HLTopBarBack"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.errorMessage = @"非常抱歉，页面出错。";
    self.errorLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        [self.view addSubview:label];
        label.text = self.errorMessage;
        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });

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
