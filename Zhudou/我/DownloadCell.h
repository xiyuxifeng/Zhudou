//
//  DownloadCell.h
//  ZhuDou
//
//  Created by wang hui on 15/5/24.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *cellProgress;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
