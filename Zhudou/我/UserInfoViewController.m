//
//  UserInfoViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoPhotoCell.h"

@interface UserInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *quitButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"头像", @"宝宝昵称", @"宝宝性别", @"宝宝年龄", @"收货人姓名", @"手机号", @"所在地址"];
    
    
    // Do any additional setup after loading the view from its nib.
    self.quitButton.layer.cornerRadius = self.quitButton.frame.size.height / 3;
    self.quitButton.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}
- (IBAction)quitClick:(UIButton *)sender {
    
    NSLog(@"退出");
}


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70.0;
    }else{
        return 60.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *userPhotoCell = @"UserPhotoCell";
        UserInfoPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:userPhotoCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoPhotoCell" owner:self options:nil] lastObject];
        }
        
        cell.infoText.text = [self.dataArr objectAtIndex:indexPath.row];
        
        return cell;
    }else{
        
        static NSString *userInfoCell = @"userInfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userInfoCell];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"豆豆";
        return cell;
    }

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
