//
//  HLPickerController.m
//  HLRouter
//
//  Created by Lucius on 2017/7/31.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLPickerController.h"
#import <HLRouter/HLRouter.h>

@interface HLPickerController ()

@end

@implementation HLPickerController

- (instancetype)initDefaultController{
    
    HLRouterConfigureModel *configureModel = [[HLRouterConfigureModel alloc] init];
    configureModel.appKey = @"hl";
    configureModel.routerTableName = @"HLRouterTable.plist";
    
    if (self = [super initWithConfigureModel:configureModel jumpURL:@"hl://goto?type=inner_app&pid=600001"]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
