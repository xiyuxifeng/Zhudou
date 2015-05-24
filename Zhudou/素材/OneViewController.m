//
//  OneViewController.m
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    musicArr = [[NSMutableArray alloc] init];
    
    musicTableView = [[UITableView alloc]init];
    
    musicTableView.frame = CGRectMake(0, 35, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 179 - 75);
    
    musicTableView.tag = 1;
    
    [musicTableView setDelegate:self];
    
    [musicTableView setDataSource:self];
    
    [self.view addSubview:musicTableView];
    
    [self loadAnimationView];
    
    [self loadMusicView];
    
    NSString *urlStr = @"material/materiallist.do";
    
    [IKHttpTool postWithURL:urlStr params:nil success:^(id JSON)
     {
         NSLog(@"JSON = %@",JSON);
         
         [musicArr removeAllObjects];
         
         NSArray *arr = [JSON valueForKey:@"res_data"];
         
         for (NSDictionary *dc  in arr) {
             
             NSString *str = [dc objectForKey:@"catalog"];
             
             if (str.intValue == 1)
             {
                 [musicArr addObject:dc];
             }
         }
         
         [musicTableView reloadData];
         
     }
    failure:^(NSError *error)
     {
         NSLog(@"error%@",error);
     }];
    
    self.Segmented_AM.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - self.Segmented_AM.frame.size.width) / 2, 5, self.Segmented_AM.frame.size.width, 25);
    
    
}

//加载动画界面
- (void)loadAnimationView
{
    
}

- (void)loadMusicView
{
    musicTableView.hidden = YES;
    
    musicPlayView = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 175 - 44, [[UIScreen mainScreen] bounds].size.width, 75)];
    
    musicPlayView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:0.5];
    
    [self.view addSubview:musicPlayView];
    
    //是否收藏过？
    UIImageView *music_ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 50, 50)];
    
    music_ImageView.image = [UIImage imageNamed:@"QQ图片20150419133143.png"];
    
    [musicPlayView addSubview:music_ImageView];
    
    //音乐的名字
    UILabel *musicTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 12, 150, 20)];
    
    musicTitle.font = [UIFont systemFontOfSize: 13.0];
    
    musicTitle.text = @"我是一个小小的石头";
    
    [musicPlayView addSubview:musicTitle];
    
    AVPlayerTime = [[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 100, 33, 100, 20)];
    
    AVPlayerTime.text = @"0.00 / 0.00";
    
    AVPlayerTime.font = [UIFont systemFontOfSize: 15.0];
    
    [musicPlayView addSubview:AVPlayerTime];
    
    NSError* err;
     
    musicPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:[NSURL fileURLWithPath:
                                          [[NSBundle mainBundle]pathForResource:
                                           @"蔡依林 - 日不落" ofType:@"m4a"
                                                                    inDirectory:@"/"]]
                   error:&err ];//使用本地URL创建
    
    [musicPlayer prepareToPlay];//分配播放所需的资源，并将其加入内部播放队列
    

    //初始化一个播放进度条
    progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(82, 63, 160, 20)];
    
    [musicPlayView addSubview:progressV];
    
    
    //播放事件
    musicSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
    
    musicSwitch.tag = 0;
    
    musicSwitch.frame = CGRectMake(150, 34, 25, 25);
    
    [musicSwitch setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [musicSwitch addTarget:self action:@selector(SwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [musicSwitch setBackgroundImage:[UIImage imageNamed:@"暂停1.png"] forState:UIControlStateNormal];
    
    //显示控件
    [musicPlayView addSubview:musicSwitch];
    
    
    UIButton *tui = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tui.tag = 3;
    
    tui.frame = CGRectMake(100, 34, 25, 25);
    
    [tui setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [tui addTarget:self action:@selector(SwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [tui setBackgroundImage:[UIImage imageNamed:@"按钮3.png"] forState:UIControlStateNormal];
    
    //显示控件
    [musicPlayView addSubview:tui];
    
    UIButton *jin = [UIButton buttonWithType:UIButtonTypeCustom];
    
    jin.tag = 4;
    
    jin.frame = CGRectMake(200, 34, 25, 25);
    
    [jin setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [jin addTarget:self action:@selector(SwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [jin setBackgroundImage:[UIImage imageNamed:@"按钮.png"] forState:UIControlStateNormal];
    
    //显示控件
    [musicPlayView addSubview:jin];
    
    musicPlayView.hidden = YES;
    
    //用NSTimer来监控音频播放进度
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgress) userInfo:nil repeats:YES];
    
}

//音乐播放和暂停。
- (void)SwitchClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
            btn.tag = 1;
            [btn setBackgroundImage:[UIImage imageNamed:@"按钮2.png"] forState:UIControlStateNormal];
            [self play];
            
            break;
            
        case 1:
            btn.tag = 0;
            [btn setBackgroundImage:[UIImage imageNamed:@"暂停1.png"] forState:UIControlStateNormal];
            [self pause];
            
            break;
            
        case 3:
            if ((musicPlayer.currentTime - 10) < 0)
            {
                musicPlayer.currentTime = 0;
            }
            else
            {
                musicPlayer.currentTime -= 10;
            }
            
            break;
            
        case 4:
            if ((musicPlayer.currentTime + 10) > musicPlayer.duration)
            {
                musicPlayer.currentTime = musicPlayer.duration - 1;
            }
            else
            {
                musicPlayer.currentTime += 10;
            }
            
            break;
    }
}

//播放
- (void)play
{
    [musicPlayer play];
}

//暂停
- (void)pause
{
    [musicPlayer pause];
}
//停止
- (void)stop
{
    musicPlayer.currentTime = 0;  //当前播放时间设置为0
    [musicPlayer stop];
}

//播放进度条
- (void)playProgress
{
    //通过音频播放时长的百分比,给progressview进行赋值;
    progressV.progress = musicPlayer.currentTime / musicPlayer.duration;
    
    int i = (int)musicPlayer.currentTime % 60;
    NSString *currentTime_60 = i < 10 ? [NSString stringWithFormat:@"0%d",i] : [NSString stringWithFormat:@"%d",i];
    
    int j = (int)musicPlayer.duration % 60;
    NSString *duration_60 = j < 10 ? [NSString stringWithFormat:@"0%d",j] : [NSString stringWithFormat:@"%d",j];
    
    AVPlayerTime.text = [NSString stringWithFormat:@"%0.0f:%@ / %0.0f:%@",musicPlayer.currentTime / 60,currentTime_60 , musicPlayer.duration / 60,duration_60];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"one didReceiveMemoryWarning");
}

- (IBAction)Animation_Music:(id)sender
{
    UISegmentedControl *sc = sender;
    switch (sc.selectedSegmentIndex)
    {
        case 0:
            musicTableView.hidden = YES;
            musicPlayView.hidden = YES;
            
            [musicPlayer stop];
            
            break;
            
        case 1:
            [musicPlayer prepareToPlay];
            
            musicPlayView.hidden = NO;
            musicTableView.hidden = NO;
            
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return musicArr.count;
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    
    if (tableView.tag == 1)
    {
        //是否收藏过？
        UIButton *cell_shouCang_ImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cell_shouCang_ImageView.frame = CGRectMake(15, 25, 20, 20);
        
        cell_shouCang_ImageView.tag = row;
        
        [cell_shouCang_ImageView setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        // 给button添加事件
        [cell_shouCang_ImageView addTarget:self action:@selector(cellMusicShouCangButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button填充图片
        [cell_shouCang_ImageView setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
        
        [cell addSubview:cell_shouCang_ImageView];
        
        
        //音乐的名字
        UILabel *musicTitle = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 150, 20)];
        
        musicTitle.font = [UIFont systemFontOfSize: 13.0];
        
        musicTitle.text = [[musicArr objectAtIndex:row] valueForKey:@"title"];
        
        [cell addSubview:musicTitle];
        
        //发布时间
        UIImageView *releaseTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(45, 35, 18, 18)];
        
        releaseTimeImageView.image = [UIImage imageNamed:@"发布时间.png"];
        
        [cell addSubview:releaseTimeImageView];
        
        UILabel *releaseTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(65, 35, 100, 20)];
        
        releaseTimeTitle.textColor = [UIColor grayColor];
        
        releaseTimeTitle.font = [UIFont systemFontOfSize: 11.0];
        
        releaseTimeTitle.text = [[musicArr objectAtIndex:row] valueForKey:@"createDate"];
        releaseTimeTitle.text = [releaseTimeTitle.text substringWithRange:NSMakeRange(releaseTimeTitle.text.length - 5,5)];
        
        [cell addSubview:releaseTimeTitle];
        
        //下载次数
        UIButton *upDataImage = [UIButton buttonWithType:UIButtonTypeCustom];
        
        upDataImage.frame = CGRectMake(151, 35, 18, 18);
        
        upDataImage.tag = row;
        
        [upDataImage setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        // 给button添加事件
        [upDataImage addTarget:self action:@selector(cellMusicUpDataButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button填充图片
        [upDataImage setBackgroundImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
        
        [cell addSubview:upDataImage];
        
        UILabel *upDataTitle = [[UILabel alloc]initWithFrame:CGRectMake(171, 35, 40, 20)];
        
        upDataTitle.textColor = [UIColor grayColor];
        
        upDataTitle.font = [UIFont systemFontOfSize: 11.0];
        
        upDataTitle.text = [NSString stringWithFormat:@"%@",[[musicArr objectAtIndex:row] valueForKey:@"downloadCount"]];
        
        [cell addSubview:upDataTitle];
        
        //播放事件
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        playBtn.tag = row;
        
        playBtn.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 60, 15, 30, 30);
        
        [playBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        // 给button添加事件
        [playBtn addTarget:self action:@selector(cellMusicPlayButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button填充图片
        [playBtn setBackgroundImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal];
        
        //显示控件
        [cell addSubview:playBtn];
        
    }
    
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
}

//动画播放
- (void)cellMvPlayButClick:(UIButton *)btn
{
    NSLog(@"btn.tag Play = %d",(int)btn.tag);
}

//动画收藏
- (void)cellMvShouCangButClick:(UIButton *)btn
{
    NSLog(@"btn.tag 收藏 = %d",(int)btn.tag);
}

//动画下载
- (void)cellMvUpDataButClick:(UIButton *)btn
{
    NSLog(@"btn.tag UpData = %d",(int)btn.tag);
}

//音乐收藏
- (void)cellMusicShouCangButClick:(UIButton *)btn
{
    NSLog(@"btn.tag 收藏 = %d",(int)btn.tag);
}

//音乐播放
- (void)cellMusicPlayButClick:(UIButton *)btn
{
    NSLog(@"btn.tag Play = %d",(int)btn.tag);
}

//音乐下载
- (void)cellMusicUpDataButClick:(UIButton *)btn
{
    NSLog(@"btn.tag UpData = %d",(int)btn.tag);
}

- (void)dealloc{
    NSLog(@"one dealloc");
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end