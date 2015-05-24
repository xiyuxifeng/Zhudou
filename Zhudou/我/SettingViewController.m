//
//  SettingViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "SettingViewController.h"
#import "FanKuiViewController.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *timeArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (weak, nonatomic) IBOutlet UIButton *OKBtn;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataArr = @[@"休息时间设置", @"缓存路径设置", @"反馈"];
    self.timeArr = @[@"15分钟", @"30分钟", @"45分钟"];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.timePicker.dataSource = self;
    self.timePicker.delegate = self;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingCellId"];
    }
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"30分钟";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.timePicker.hidden = NO;
        self.OKBtn.hidden = NO;
    }else if (indexPath.row == 2) {
        FanKuiViewController *fankuiVC = [[FanKuiViewController alloc] init];
        [self.navigationController pushViewController:fankuiVC animated:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.timeArr.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.timeArr objectAtIndex:row];
}
- (IBAction)okBtnClick:(UIButton *)sender {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger row =[self.timePicker selectedRowInComponent:0];
    cell.detailTextLabel.text = [self.timeArr objectAtIndex:row];
    
    self.timePicker.hidden = YES;
    self.OKBtn.hidden = YES;
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
