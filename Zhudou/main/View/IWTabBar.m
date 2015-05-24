//
//  IWTabBar.m
//  传智微博
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"

@interface IWTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) IWTabBarButton *selectedTabBarButton;
@end

@implementation IWTabBar
/**
 *  数组的懒加载
 */
- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        self.tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景
        [self setupBg];
    }
    return self;
}

/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item
{
    // 创建按钮
    IWTabBarButton *button = [[IWTabBarButton alloc] init];
    button.item = item;
    [button addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    button.tag = self.tabBarButtons.count;
    [self addSubview:button];
    
    // 加到数组中
    [self.tabBarButtons addObject:button];
    
    // 默认让最前面的按钮选中
    if (self.tabBarButtons.count == 1) {
        [self tabBarButtonClick:button];
    }
}

/**
 *  点击选项卡按钮
 */
- (void)tabBarButtonClick:(IWTabBarButton *)button
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        int from = self.selectedTabBarButton.tag;
        int to = button.tag;
        [self.delegate tabBar:self didSelectButtonFrom:from to:to];
    }
    
    // 更改按钮状态
    self.selectedTabBarButton.selected = NO;
    button.selected = YES;
    self.selectedTabBarButton = button;
}

/**
 *  设置背景
 */
- (void)setupBg
{
    self.backgroundColor = [UIColor whiteColor];

}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置选项卡按钮的位置和尺寸
    [self setupTabBarButtonFrame];
}

/**
 *  设置选项卡按钮的位置和尺寸
 */
- (void)setupTabBarButtonFrame
{
    int count = self.tabBarButtons.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i < count; i++) {
        IWTabBarButton *button = self.tabBarButtons[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = buttonW * i;
        button.y = 0;
    }
}

@end
