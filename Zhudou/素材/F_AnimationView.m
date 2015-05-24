//
//  F_AnimationView.m
//  DLSlideViewDemo
//
//  Created by 洪涛杨 on 15/5/23.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import "F_AnimationView.h"

@implementation F_AnimationView

- (void)loadView {
    NSString *url = [[NSBundle mainBundle] pathForResource:@"4056" ofType:@"mp4"];
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];
    
    //player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://devimages.apple.com/samplecode/adDemo/ad.m3u8"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    player.view.frame = CGRectMake(10, 10, 300, 200);
    
    player.movieSourceType = MPMovieSourceTypeFile;//improve the load times for the movie content
    
    player.useApplicationAudioSession = NO;//must set this property's value to NO, donot use a system-supplied audio session
    
    player.shouldAutoplay = NO;
    
    [player prepareToPlay];
    
    
    //player.view.frame = [self.view bounds];
    
    [self addSubview:player.view];
}

-(void)moviePlayerPreloadDidFinish:(NSNotification*)notification{
    [player prepareToPlay];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender

{
    
    NSLog(@">>>>>>>>>>>>>>>> Ready to Play Video <<<<<<<<<<<<<<<<<<<<<");
    
    
    [player play];
    
    NSLog(@">>>>>>>>>>>>>>natural size :%@",NSStringFromCGSize(player.naturalSize));
    
}

@end
