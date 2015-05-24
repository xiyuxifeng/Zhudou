//
//  UIBarButtonItem+MJ.m
//  传智微博
//
//  Created by teacher on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem (MJ)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
