//
//  F_AnimationView.h
//  DLSlideViewDemo
//
//  Created by 洪涛杨 on 15/5/23.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface F_AnimationView : UIView
{
    MPMoviePlayerController *player;
}
- (void)loadView;
@end
