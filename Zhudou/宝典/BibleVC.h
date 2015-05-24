//
//  BibleVC.h
//  test
//
//  Created by 洪涛杨 on 15/5/23.
//  Copyright (c) 2015年 洪涛杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKHttpTool.h"

@interface BibleVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *imageView;
    UIScrollView *scrollView;
    UITableView *tableView;
    NSMutableArray *tableViewDataArr;
}
 
@end
