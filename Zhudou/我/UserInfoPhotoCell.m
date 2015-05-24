//
//  UserInfoPhotoCell.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "UserInfoPhotoCell.h"

@implementation UserInfoPhotoCell

- (void)awakeFromNib {
    // Initialization code
    
    // 圆角
    self.photoImage.layer.cornerRadius = self.photoImage.frame.size.height / 2;
    self.photoImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
