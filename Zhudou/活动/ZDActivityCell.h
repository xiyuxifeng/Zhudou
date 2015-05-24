//
//  ZDActivityCell.h
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDAcitivityModel.h"

@interface ZDActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn;

@property(nonatomic,strong) ZDAcitivityModel *data;
+ (ZDActivityCell*)cellWithTableView:(UITableView*)tableView;
@end
