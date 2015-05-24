//
//  IWNavigationController.m
//
//  Created by teacher on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ZDNavigationController.h"
#import "UIBarButtonItem+MJ.h"

@interface ZDNavigationController ()

@end

@implementation ZDNavigationController

+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavTheme];
    
    // 1.设置导航栏按钮主题
    [self setupItemTheme];
}

/**
 * 设置导航栏主题
 */
+ (void)setupNavTheme
{
//     1.获得appearance对象, 就能修改主题
    UINavigationBar *navBar = [UINavigationBar appearance];

    // 2.设置背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    
    // 1.3.设置状态栏背景
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 1.4.设置导航栏的文字
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        // 设置文字颜色
        textAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
        // 去掉阴影
        textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
        // 设置文字字体
        textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:20];
        [navBar setTitleTextAttributes:textAttrs];

}

/**
 * 设置导航栏按钮主题
 */
+ (void)setupItemTheme
{
    // 1.获得appearance对象, 就能修改主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 2.设置背景
    // 按钮文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    // 设置文字颜色
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    // 去掉阴影
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    // 设置文字字体
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionary];
    highTextAttrs.dictionary = textAttrs;
    // 设置文字颜色
    highTextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs.dictionary = textAttrs;
    // 设置文字颜色
    disableTextAttrs[UITextAttributeTextColor] = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    

//        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // 清空手势识别器的代理, 就能恢复以前滑动移除控制器的功能
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果push的不是根控制器(不是栈底控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 左上角的返回
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


@end
