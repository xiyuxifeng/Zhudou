//
//  ThreeViewController.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKHttpTool.h"

@interface ThreeViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>
{
    UIAlertView *customAlertView;
    NSMutableArray *musicArr;
} 

@end
