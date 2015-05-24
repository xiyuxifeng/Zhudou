//
//  ZDactivityViewController.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDactivityViewController.h"
#import "ZDActivityCell.h"
#import "ZDAcitivityModel.h"
#import "ZDShakeViewController.h"

@interface ZDactivityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic)  UITableView *cityListTableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

//城市列表的数据
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (weak, nonatomic) UIView *bgView;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;


@end

@implementation ZDactivityViewController
- (UITableView *)cityListTableView
{
    if (!_cityListTableView) {
        _cityListTableView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 50, 0) style:UITableViewStylePlain];
        _cityListTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _cityListTableView.backgroundColor = [UIColor whiteColor];
        _cityListTableView.delegate = self;
        _cityListTableView.dataSource = self;
        [self.view addSubview:_cityListTableView];
    }
    return _cityListTableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            ZDAcitivityModel *m = [[ZDAcitivityModel alloc]init];
            m.title = [NSString stringWithFormat:@"%d",i];
            m.detail = [NSString stringWithFormat:@"%d%d",i,i];
            [_dataArray addObject:m];
        }
    }
    return _dataArray;
}

#pragma mark - 按钮点击方法
//摇一摇
- (IBAction)ShakeBtnClick:(id)sender {
    ZDShakeViewController *v = [[ZDShakeViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}

//砸金蛋
- (IBAction)SmashGoldEggsAction:(id)sender {
}

#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.rowHeight = 110;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *leftBtn = [[UIButton alloc]init];
//    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setTitle:@"请选择城市" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [leftBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [leftBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    self.arrayHotCity = [NSMutableArray arrayWithObjects:@"北京市",@"广州市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
    self.keys = [NSMutableArray array];
    self.arrayCitys = [NSMutableArray array];
    [self getCityData];

}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}

- (void)selectCity:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    if (btn.selected) {
        
    [UIView animateWithDuration:0.5 animations:^{
        _cityListTableView.alpha = 0;
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        _cityListTableView  = nil ;
        [_cityListTableView removeFromSuperview];
        [_bgView removeFromSuperview];
    }];
        
    }else{
        UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
        bgView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:bgView];
        _bgView = bgView;
        [self.cityListTableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView == _cityListTableView ? 40.0 : 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _mainTableView) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    bgView.backgroundColor = IWColor(95, 182, 9);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"选择城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return tableView == _cityListTableView? _keys : nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return tableView == _cityListTableView ?[_keys count] : 1;
}

#pragma mark - tableView数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainTableView) {
        return self.dataArray.count;
    }else{
        NSString *key = [_keys objectAtIndex:section];
        NSArray *citySection = [_cities objectForKey:key];
        return [citySection count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTableView) {
        
        ZDActivityCell *cell = [ZDActivityCell cellWithTableView:tableView];
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"Cell";
        
        NSString *key = [_keys objectAtIndex:indexPath.section];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.textLabel setTextColor:[UIColor blackColor]];
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTableView) {
        NSLog(@"选中了%ld",indexPath.row);
    }else
    {
        NSString *key = [_keys objectAtIndex:indexPath.section];
        NSString *cityName = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
        NSLog(@"%@",cityName);
        [UIView animateWithDuration:0.5 animations:^{
            _cityListTableView.alpha = 0;
            _bgView.alpha = 0;
        } completion:^(BOOL finished) {
            _cityListTableView = nil;
            [_cityListTableView removeFromSuperview];
            [_bgView removeFromSuperview];
        }];
    }
    
}

#pragma mark - CityListView

@end
