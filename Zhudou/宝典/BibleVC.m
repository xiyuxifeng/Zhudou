//
//  BibleVC.m
//  test
//
//  Created by 洪涛杨 on 15/5/23.
//  Copyright (c) 2015年 洪涛杨. All rights reserved.
//

#import "BibleVC.h"

@interface BibleVC ()

@end

@implementation BibleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableViewDataArr = [[NSMutableArray alloc] init];
    
    imageView = [[UIImageView alloc]init];
    scrollView = [[UIScrollView alloc]init];
    tableView = [[UITableView alloc]init];
    
    imageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 165);
    
    imageView.image = [UIImage imageNamed:@"宝典图片.png"];
    
    scrollView.frame = CGRectMake(0, 165, [[UIScreen mainScreen] bounds].size.width, 71);
    
    scrollView.scrollEnabled = YES;
    
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width / 4 * 5, scrollView.frame.size.height); 
    
    tableView.frame = CGRectMake(0, 236, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 302);
    
    [tableView setDelegate:self];
    
    [tableView setDataSource:self];

    
    //加载ScrollView数据。
    [self loadScrollViewInfo];
    
    //加载TabBarController数据。
    [self loadTabBarController];
    
    [self.view addSubview:imageView];
    
    [self.view addSubview:scrollView];
    
    [self.view addSubview:tableView];
    
    NSString *urlStr = @"link";
    
    [IKHttpTool postWithURL:urlStr params: @{@"colid":@"4"} success:^(id JSON) {
                                           NSLog(@"JSON = %@",JSON);
                                           [tableViewDataArr removeAllObjects];
                                           tableViewDataArr = [JSON valueForKey:@"res_data"];
                                           
                                       } failure:^(NSError *error) {
                                           NSLog(@"error%@",error);
                                       }];
}

- (void)loadScrollViewInfo{
    
    
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button1.tag = i;
        
        button1.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        
        button1.frame = CGRectMake(15 + ([[UIScreen mainScreen] bounds].size.width / 4 * i), 15, [[UIScreen mainScreen] bounds].size.width / 4 - 30, 35);
        
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        button1.contentEdgeInsets = UIEdgeInsetsMake(65, 5, 0, 0);
        
        [button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        
        //button背景色
        button1.backgroundColor = [UIColor clearColor];
        
        // 给button添加事件
        [button1 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //显示控件
        [scrollView addSubview:button1];

        switch (i) {
            case 0:
                //设置button填充图片
                [button1 setBackgroundImage:[UIImage imageNamed:@"age1.png"] forState:UIControlStateNormal]; 
                
                //设置button标题
                [button1 setTitle:@"7-12个月" forState:UIControlStateNormal];
                
                break;
            case 1:
                //设置button填充图片
                [button1 setBackgroundImage:[UIImage imageNamed:@"age2.png"] forState:UIControlStateNormal];
                
                //设置button标题
                [button1 setTitle:@"1-1.5岁" forState:UIControlStateNormal];
                
                break;
            case 2:
                //设置button填充图片
                [button1 setBackgroundImage:[UIImage imageNamed:@"age3.png"] forState:UIControlStateNormal];
                
                //设置button标题
                [button1 setTitle:@"1.5-2岁" forState:UIControlStateNormal];
                
                break;
            case 3:
                //设置button填充图片
                [button1 setBackgroundImage:[UIImage imageNamed:@"age4.png"] forState:UIControlStateNormal];
                
                //设置button标题
                [button1 setTitle:@"2-2.5岁" forState:UIControlStateNormal];
                
                break;
            case 4:
                //设置button填充图片
                [button1 setBackgroundImage:[UIImage imageNamed:@"age5.png"] forState:UIControlStateNormal];
                
                //设置button标题
                [button1 setTitle:@"2.5-3岁" forState:UIControlStateNormal];
                
                break;
                
            default:
                break;
        }
    }
}

- (void)loadTabBarController{
    
}

//点击不同年龄段的数据。
- (void)butClick:(UIButton *)btn{
    
//    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    
    // add image.
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 90, 60)];
    
    cellImageView.image = [UIImage imageNamed:@"宝典图片.png"];
    
    // add title.
    UILabel *cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(125, 15, [[UIScreen mainScreen] bounds].size.width - 110 - 30, 15)];
    
    cellTitle.font = [UIFont systemFontOfSize: 14.0];
    
    cellTitle.text = @"一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品";
    
    // add details.
    UILabel *cellDetails = [[UILabel alloc]initWithFrame:CGRectMake(125, 30, [[UIScreen mainScreen] bounds].size.width - 110 - 30, 48)];
    
    //上面两行设置多行显示
    cellDetails.numberOfLines = 0;
    
    //设置textview里面的字体颜色
    cellDetails.textColor = [UIColor grayColor];
    
    //设置字体名字和字体大小
    cellDetails.font = [UIFont fontWithName:@"Arial" size:12.0];
    
    cellDetails.text = [NSString stringWithFormat:@"      %@",@"一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品一个不错的在家家教产品"];
    
    [cell addSubview:cellImageView];
    [cell addSubview:cellTitle];
    [cell addSubview:cellDetails];
    
    return cell;
    
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
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
