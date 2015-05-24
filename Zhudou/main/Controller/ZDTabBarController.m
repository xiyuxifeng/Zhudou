//
//  IWTabBarController.m
//  传智微博
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 插件安装路径:/Users/用户名/Library/Application Support/Developer/Shared/Xcode/Plug-ins

#import "ZDTabBarController.h"
#import "IWTabBar.h"
#import "ZDNavigationController.h"
#import "ZDactivityViewController.h"
#import "BibleVC.h"
#import "UserCenterViewController.h"
#import "Demo1ViewController.h"

@interface ZDTabBarController() <IWTabBarDelegate>
@property (nonatomic, weak) IWTabBar *customTabBar;
@end

@implementation ZDTabBarController
#pragma mark - 初始化方法
- (IWTabBar *)customTabBar
{
    if (!_customTabBar) {
        // 创建一个新的tabbar
        IWTabBar *customTabBar = [[IWTabBar alloc] init];
        customTabBar.frame = self.tabBar.bounds;
        customTabBar.delegate = self;
        [self.tabBar addSubview:customTabBar];
        self.customTabBar = customTabBar;
    
    }
    return _customTabBar;
}

#pragma mark init方法内部会调用这个
/**
 *  init方法内部会调用这个
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // 初始化自己的所有子控制器
        [self setupAllChildVCs];
    }
    return self;
}

#pragma mark view加载完毕
/**
 *  view加载完毕
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除系统自动产生的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        // 私有API  UITabBarButton
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark 初始化自己的所有子控制器
/**
 *  初始化自己的所有子控制器
 */
- (void)setupAllChildVCs
{
    // 1.宝典
    BibleVC *bjVC = [[BibleVC alloc] init];
    [self setupOneChildVC:bjVC title:@"宝典" imageName:@"tabbar_treasured_book" selectedImageName:@"tabbar_treasured_book_selected"];
    
    // 2.素材
    Demo1ViewController *sucaiVC = [[Demo1ViewController alloc] init];
    [self setupOneChildVC:sucaiVC title:@"素材" imageName:@"tabbar_activity" selectedImageName:@"tabbar_activity_selected"];
    
    // 3.活动
    ZDactivityViewController *discover = [[ZDactivityViewController alloc] init];
    [self setupOneChildVC:discover title:@"活动" imageName:@"tabbar_material" selectedImageName:@"tabbar_material_selected"];
    
    // 4.我
    UserCenterViewController *profile = [[UserCenterViewController alloc] init];
    [self setupOneChildVC:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

#pragma mark 初始化一个子控制器
/**
 *  初始化一个子控制器
 *
 *  @param child             需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupOneChildVC:(UIViewController *)child title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置tabBarItem
    // 设置标题
    child.title = title;
//    child.navigationItem.title = title;
//    child.tabBarItem.title = title;
    
    // 设置图片
    child.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 设置选中的图片
    child.tabBarItem.selectedImage = selectedImage;
    
    // 2.添加子控制器
    ZDNavigationController *nav = [[ZDNavigationController alloc] initWithRootViewController:child];
    [self addChildViewController:nav];
    
    // 3.往tabbar里面添加选项卡按钮
    [self.customTabBar addTabBarButton:child.tabBarItem];
}

#pragma mark -IWTabBarDelegate
- (void)tabBar:(IWTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}
@end
