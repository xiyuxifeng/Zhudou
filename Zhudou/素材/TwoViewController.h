//
//  TwoViewController.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"

@interface TwoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    UITableView *animationTableView;
    UIAlertView *customAlertView;
}

@end
