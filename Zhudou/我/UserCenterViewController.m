//
//  UserCenterViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterTableViewCell.h"
#import "UserInfoViewController.h"
#import "JiFenViewController.h"
#import "CollectionViewController.h"
#import "AboutUSViewController.h"
#import "DownloadViewController.h"
#import "SettingViewController.h"


static NSString *reuseId = @"resueCellId";

@interface UserCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *moreImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *playLsit;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *changeBackground;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib;
    
    // 数据源
    self.dataArr = [NSArray arrayWithObjects:@"签到",@"积分", @"收藏", @"下载", @"分享", @"关于", @"设置",nil];
    self.imageArr = [NSArray arrayWithObjects:@"签到",@"积分", @"收藏", @"下载", @"分享", @"关于", @"设置",nil];
    
    // tableView setting
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 改变背景图片
    self.changeBackground.layer.cornerRadius = self.changeBackground.frame.size.height / 3;
    self.changeBackground.layer.masksToBounds = YES;

    UITapGestureRecognizer *tapChangeImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage:)];
    [self.changeBackground addGestureRecognizer:tapChangeImage];
    self.changeBackground.userInteractionEnabled = YES;
    
    // 用户头像
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.layer.masksToBounds = YES;
    UITapGestureRecognizer *tapUserInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfo:)];
    [self.userImage addGestureRecognizer:tapUserInfo];
    self.userImage.userInteractionEnabled = YES;
    
    
}

#pragma mark - Method

// 背景
- (void)changeImage: (UITapGestureRecognizer *)tap
{
    NSLog(@"改变图片");
}

// 用户详情
- (void)userInfo: (UITapGestureRecognizer *)tap
{
    UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfo animated:YES];
}



#pragma mark - tabelView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserCenterTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.cellImage.image = [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.section * 2 + indexPath.row]];
    cell.cellLabel.text = [self.dataArr objectAtIndex:indexPath.section * 2 + indexPath.row];
    
    if (indexPath.row == 1 || indexPath.section == 3) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"签到");
        }else if(indexPath.row == 1) {
        
            JiFenViewController *jifenVC = [[JiFenViewController alloc] init];
            [self.navigationController pushViewController:jifenVC animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
            CollectionViewController *collectVC = [[CollectionViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
        }else if(indexPath.row == 1){
            DownloadViewController *downVC = [[DownloadViewController alloc] init];
            [self.navigationController pushViewController:downVC animated:YES];
        }
    }else if(indexPath.section == 2){
    
        if (indexPath.row == 0) {
            NSLog(@"分享");
        }else if(indexPath.row == 1){
            AboutUSViewController *aboutVC = [[AboutUSViewController alloc] init];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }else if(indexPath.section == 3) {
        if (indexPath.row == 0) {
            SettingViewController *settingVC = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
        }
    }
}

- (IBAction)playList:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
