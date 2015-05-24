//
//  IWTabBarButton.m
//  传智微博
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#define IWTabBarButtonImageRatio 0.6

#import "IWTabBarButton.h"
#import "IWBadgeButton.h"

@interface IWTabBarButton()
@property (nonatomic, weak) IWBadgeButton *badgeButton;
@end

@implementation IWTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        // 文字颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:IWColor(86, 173, 45) forState:UIControlStateSelected];
        
//        // 添加提醒数字
//        IWBadgeButton *badgeButton = [[IWBadgeButton alloc] init];
//        badgeButton.hidden = YES;
//        [self addSubview:badgeButton];
//        self.badgeButton = badgeButton;
    }
    return self;
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * IWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = self.height * IWTabBarButtonImageRatio;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // 文字
    [self setTitle:item.title forState:UIControlStateNormal];
    // 图标
    [self setImage:item.image forState:UIControlStateNormal];
    // 选中的图标
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
//    // self监听item的4个属性值的改变
//    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
//    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

#warning 一定要移除监听器
//- (void)dealloc
//{
//    [self.item removeObserver:self forKeyPath:@"badgeValue"];
//    [self.item removeObserver:self forKeyPath:@"title"];
//    [self.item removeObserver:self forKeyPath:@"image"];
//    [self.item removeObserver:self forKeyPath:@"selectedImage"];
//}

/**
 *  当利用KVO监听到某个对象的属性改变了, 就会调用这个方法
 *
 *  @param keyPath 被改变的属性的名称
 *  @param object  被监听的那个对象
 *  @param change  存放者被改变属性的值
 */
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    // 1.设置数字
//    self.badgeButton.badgeValue = self.item.badgeValue;
//    
//    // 2.设置按钮的文字
//    [self setTitle:self.item.title forState:UIControlStateNormal];
//    [self setTitle:self.item.title forState:UIControlStateSelected];
//    
//    // 3.设置图片
//    [self setImage:self.item.image forState:UIControlStateNormal];
//    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
//}

- (void)setHighlighted:(BOOL)highlighted { }

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 设置提醒数字的位置和尺寸
//    self.badgeButton.x = self.width - self.badgeButton.width - 10;
//    self.badgeButton.y = 0;
//}
@end
