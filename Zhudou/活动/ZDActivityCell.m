//
//  ZDActivityCell.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDActivityCell.h"

@implementation ZDActivityCell

+ (ZDActivityCell *)cellWithTableView:(UITableView *)tableView
{
    ZDActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZDActivityCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZDActivityCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setData:(ZDAcitivityModel *)data
{
    _title.text = data.title;
    _detail.text = data.detail;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
