//
//  OneViewController.h
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F_AnimationView.h"
#import "F_MusicView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface OneViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    MPMoviePlayerController *player;
    UITableView *animationTableView;
    UITableView *musicTableView;
    UIView *musicPlayView;
    AVAudioPlayer *musicPlayer;
    UIProgressView *progressV;      //播放进度
    NSTimer *timer;                 //监控音频播放进度
    UILabel *AVPlayerTime;
    UIButton *musicSwitch;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *Segmented_AM;
- (IBAction)Animation_Music:(id)sender;
@end
