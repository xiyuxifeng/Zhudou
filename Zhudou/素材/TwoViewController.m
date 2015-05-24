//
//  TwoViewController.m
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    animationTableView = [[UITableView alloc]init];
    
    animationTableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 144);
    
    [animationTableView setDelegate:self];
    
    [animationTableView setDataSource:self];
    
    [self.view addSubview:animationTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    
    //动画预览图
    UIButton *playImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    playImageView.tag = row;
    
    playImageView.frame = CGRectMake(15, 10, 60, 40);
    
    [playImageView setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
//    [playImageView addTarget:self action:@selector(cellMvPlayButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [playImageView setBackgroundImage:[UIImage imageNamed:@"宝典图片.png"] forState:UIControlStateNormal];
    
    [cell addSubview:playImageView];
    
    //动画的名字
    UILabel *animationTitle = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 120, 20)];
    
    animationTitle.font = [UIFont systemFontOfSize: 13.0];
    
    animationTitle.text = @"球球讲故事球球讲故事";
    
    [cell addSubview:animationTitle];
    
    //动画时间
    UILabel *animationTime = [[UILabel alloc]initWithFrame:CGRectMake(85, 32, 120, 20)];
    
    animationTime.font = [UIFont systemFontOfSize: 11.0];
    
    animationTime.textColor = [UIColor grayColor];
    
    animationTime.text = @"时长: 20m";
    
    [cell addSubview:animationTime];
    
    //发布时间
    UIImageView *releaseTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(210, 10, 20, 20)];
    
    releaseTimeImageView.image = [UIImage imageNamed:@"发布时间.png"];
    
    [cell addSubview:releaseTimeImageView];
    
    UILabel *releaseTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(235, 10, 100, 20)];
    
    releaseTimeTitle.textColor = [UIColor grayColor];
    
    releaseTimeTitle.font = [UIFont systemFontOfSize: 11.0];
    
    releaseTimeTitle.text = @"半个小时前";
    
    [cell addSubview:releaseTimeTitle];
    
    //收藏次数
    UIButton *saveTimesImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    saveTimesImage.frame = CGRectMake(211, 35, 18, 18);
    
    saveTimesImage.tag = row;
    
    [saveTimesImage setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [saveTimesImage addTarget:self action:@selector(cellMvShouCangButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [saveTimesImage setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    
    [cell addSubview:saveTimesImage];
    
    UILabel *saveTimesTitle = [[UILabel alloc]initWithFrame:CGRectMake(231, 35, 40, 20)];
    
    saveTimesTitle.textColor = [UIColor grayColor];
    
    saveTimesTitle.font = [UIFont systemFontOfSize: 11.0];
    
    saveTimesTitle.text = @"18";
    
    [cell addSubview:saveTimesTitle];
    
    //下载次数
    UIButton *upDataImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    upDataImage.frame = CGRectMake(271, 35, 18, 18);
    
    upDataImage.tag = row;
    
    [upDataImage setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [upDataImage addTarget:self action:@selector(cellMvUpDataButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [upDataImage setBackgroundImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
    
    [cell addSubview:upDataImage];
    
    UILabel *upDataTitle = [[UILabel alloc]initWithFrame:CGRectMake(291, 35, 40, 20)];
    
    upDataTitle.textColor = [UIColor grayColor];
    
    upDataTitle.font = [UIFont systemFontOfSize: 11.0];
    
    upDataTitle.text = @"6";
    
    [cell addSubview:upDataTitle];
    
    
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
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



//- (void)viewWillAppear:(BOOL)animated{
//    NSLog(@"two will appear");
//}
//- (void)viewDidAppear:(BOOL)animated{
//    NSLog(@"two appeared");
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    NSLog(@"two will disappear");
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    NSLog(@"two did disappear");
//}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"two didReceiveMemoryWarning");
}
- (void)dealloc{
    NSLog(@"two dealloc");
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
