//
//  JiFenViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#define MallURL @"http://182.92.96.117:8080/zhudou/commodity/commoditylist.do"

#import "JiFenViewController.h"

@interface JiFenViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 请求参数？？？
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:MallURL]];
    
    [self.webView loadRequest:request];
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
