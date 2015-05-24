//
//  OneViewController.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IKHttpTool.h"

@interface OneViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{ 
//    UITableView *animationTableView;
    UITableView *musicTableView;
    UIView *musicPlayView;
    AVAudioPlayer *musicPlayer;
    UIProgressView *progressV;      //播放进度
    NSTimer *timer;                 //监控音频播放进度
    UILabel *AVPlayerTime;          //播放进度显示时间
    UIButton *musicSwitch;          //播放/暂停
    
    UIImageView *music_ImageView;
    UILabel *musicTitle;
    
    NSMutableArray *musicArr;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmented_AM;
- (IBAction)Animation_Music:(id)sender;
@end
