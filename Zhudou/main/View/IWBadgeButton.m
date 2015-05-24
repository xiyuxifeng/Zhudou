//
//  IWBadgeButton.m
//  传智微博
//
//  Created by teacher on 14-6-17.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWBadgeButton.h"

@implementation IWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.size = self.currentBackgroundImage.size;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    int value = badgeValue.intValue;
    if (value == 0) { // 没有值可以显示
        self.hidden = YES;
    } else {
        self.hidden = NO;
        if (value >= 100) {
            [self setTitle:@"N" forState:UIControlStateNormal];
        } else {
            [self setTitle:badgeValue forState:UIControlStateNormal];
        }
    }
}

@end
