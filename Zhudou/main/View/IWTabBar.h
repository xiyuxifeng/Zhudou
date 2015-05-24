//
//  IWTabBar.h
//  传智微博
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>
@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickPlusButton:(IWTabBar *)tabBar;
@end

@interface IWTabBar : UIView
/**
 *  添加一个选项卡按钮
 *
 *  @param item 选项卡按钮对应的模型数据(标题\图标\选中的图标)
 */
- (void)addTabBarButton:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;
@end
