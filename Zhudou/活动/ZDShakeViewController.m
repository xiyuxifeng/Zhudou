//
//  ZDShakeViewController.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDShakeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZDShakeViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *flowerOne;
@property (weak, nonatomic) IBOutlet UIImageView *flowerTwo;
@property (weak, nonatomic) IBOutlet UIImageView *flowerThree;
//机会
@property (weak, nonatomic) IBOutlet UIButton *chanceBtn;
//积分
@property (weak, nonatomic) IBOutlet UIButton *integralBtn;

@property(nonatomic,strong)AVAudioPlayer *player;


@end

@implementation ZDShakeViewController{
    int _ShakenCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ShakenCount = 0;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Shaken) name:@"CPDeviceShaken" object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self Shaken];
}
//摇动调用的方法
- (void)Shaken {
    if(_ShakenCount == 3){
        UIButton *alt = [[UIButton alloc]init];
        alt.backgroundColor = [UIColor blackColor];
        alt.frame = CGRectMake((self.view.width - 240)/2 , self.view.height - 200, 240, 30);
        [self.view addSubview:alt];
        [alt setTitle:@"今天的3次机会已经用完了" forState:UIControlStateNormal];
        alt.alpha = 0;
        [UIView animateWithDuration:1.0 animations:^{
        alt.alpha = 1;
        }];
        [self performSelector:@selector(hiddenBtn:) withObject:alt afterDelay:1.0];
        return;
    }
    ++_ShakenCount;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake_sound_male.mp3" ofType:nil];
    //播放音乐
    NSError *error;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    if(error) {
        //        [MBProgressHUD showError:@"暂时没有音频!"];
        NSLog(@"wordTestViewController play music error %@",error);
        return;
    }
    //缓冲
    [self.player prepareToPlay];
    
    //播放
    [self.player play];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"shake_sound.mp3" ofType:nil];
    [self performSelector:@selector(playMusic:) withObject:path1 afterDelay:2.0];

}
- (void)playMusic:(NSString *)path {
    //播放音乐
    NSError *error;
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    if(error) {
        //        [MBProgressHUD showError:@"暂时没有音频!"];
        NSLog(@"wordTestViewController play music error %@",error);
        return;
    }
    self.player.delegate = self;
    //缓冲
    [self.player prepareToPlay];
    
    //播放
    [self.player play];

}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [UIView animateWithDuration:1.0 animations:^{
        //1.花
        if(_ShakenCount == 1){
            _flowerThree.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
        }else if (_ShakenCount == 2) {
            _flowerTwo.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
            _flowerThree.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
        }else{
            _flowerThree.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
            _flowerTwo.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
            _flowerOne.image = [UIImage imageNamed:@"activity_yaoyiyao_ghua"];
        }
        
        //2.机会
        [_chanceBtn setTitle:[NSString stringWithFormat:@"今天还有%d次机会哦",3-_ShakenCount] forState:UIControlStateNormal];
    }];
    
    //3.积分
    _integralBtn.hidden = NO;
    _integralBtn.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        _integralBtn.alpha = 1;
    }];
    [self performSelector:@selector(hiddenBtn:) withObject:_integralBtn afterDelay:1.0];
}

- (void)hiddenBtn:(UIButton *)b {
    b.hidden = YES;
}
- (void) viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidDisappear:animated];
}

@end
