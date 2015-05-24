//
//  ZDNewfeatureViewController.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDNewfeatureViewController.h"
#import "ZDTabBarController.h"
#import "ZDsinginViewController.h"
#import "ZDNavigationController.h"
#define ZDNewfeatureImageCount 5
@interface ZDNewfeatureViewController()<UIScrollViewDelegate>
@property(nonatomic,weak) UIPageControl *pageControl;
@end
@implementation ZDNewfeatureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i<ZDNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        [scrollView addSubview:imageView];
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 处理最后一个ImageView
        if (i == ZDNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(ZDNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = IWColor(246, 246, 246);
}


/**
 *  处理最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView可以跟用户进行交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
}
/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
//    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor redColor];
    
    // 3.设置frame
    startButton.size = CGSizeMake(100, 50); //startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    // 4.设置文字
    [startButton setTitle:@"进入" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  开始
 */
- (void)start
{
    // 显示状态栏
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarHidden = NO;
    
    //    self.view.window
    UIWindow *window = app.keyWindow;
    // 切换window的rootViewController
    ZDNavigationController *Nav = [[ZDNavigationController alloc]initWithRootViewController:[[ZDsinginViewController alloc] init]];
    window.rootViewController = Nav;
}

/**
 *  添加pageControl
 
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZDNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = IWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = IWColor(189, 189, 189);
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double ratio = scrollView.contentOffset.x / scrollView.width;
    int pageNo = (int)(ratio + 0.5); // 四舍五入
    self.pageControl.currentPage = pageNo;
}
@end
