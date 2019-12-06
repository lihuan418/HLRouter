//
//  HLWebViewController.m
//  HLRouter
//
//  Created by Lucius on 2017/7/31.
//  Copyright © 2017年 李欢. All rights reserved.
//

#import "HLWebViewController.h"
#import <WebKit/WebKit.h>

@interface HLWebViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) WKWebView *wkWebView;
@end

@implementation HLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

#pragma mark - Init View

-(void)initView{
    [self addBackIcon:[UIImage imageNamed:@"HLTopBarBack"]];
    [self.view addSubview:self.wkWebView];
    
    //返回按钮
    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 20)];
    [secondBtn setTitle:@"再来一个WEB" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor blackColor]];
    [secondBtn addTarget:self action:@selector(pressSecondView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
}

- (void)pressSecondView:(id)sender{

    UIViewController *webViewController = [self HL_viewControllerWithPageName:@"HLWebViewController" otherParam:@{@"url":@"https://www.baidu.com"}];
    
    [self HL_jumpToViewControllerWithViewController:webViewController animated:YES targetCallBack:nil jumpStyle:HLRouterJumpStyleOfPush];
}


#pragma mark - LazyLoad

-(NSString*)webUrl{
    if (!_webUrl) {
        _webUrl = [self.param objectForKey:@"url"];
    }
    return _webUrl;
}

-(WKWebView*)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.frame.size.height, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - self.customNavigationBar.frame.size.height)];
        _wkWebView.navigationDelegate = self;
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }
    return _wkWebView;
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
