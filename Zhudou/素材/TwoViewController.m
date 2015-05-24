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
    
    musicArr = [[NSMutableArray alloc] init];
    
    animationTableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 144);
    
    [animationTableView setDelegate:self];
    
    [animationTableView setDataSource:self];
    
    [self.view addSubview:animationTableView];
    
    NSString *urlStr = @"material/materiallist.do";
    
    [IKHttpTool postWithURL:urlStr params:nil success:^(id JSON)
     {
         NSLog(@"JSON = %@",JSON);
         
         [musicArr removeAllObjects];
         
         NSArray *arr = [JSON valueForKey:@"res_data"];
         
         for (NSDictionary *dc  in arr) {
             
             NSString *str = [dc objectForKey:@"catalog"];
             
             if (str.intValue == 2)
             {
                 [musicArr addObject:dc];
             }
         }
         
         [animationTableView reloadData];
         
     }
                    failure:^(NSError *error)
     {
         NSLog(@"error%@",error);
     }];

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
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
     
    NSUInteger row = [indexPath row];
    
    //动画预览图
    UIButton *playImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    playImageView.tag = row;
    
    playImageView.frame = CGRectMake(15, 10, 60, 40);
    
    [playImageView setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
//    [playImageView addTarget:self action:@selector(cellMvPlayButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.92.96.117:8080/zhudou/%@",[[musicArr objectAtIndex:row] valueForKey:@"titlePic"]]];

    [playImageView setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]] forState:UIControlStateNormal];
    
    [cell addSubview:playImageView];
    
    //动画的名字
    UILabel *animationTitle = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, 120, 20)];
    
    animationTitle.font = [UIFont systemFontOfSize: 13.0];
    
    animationTitle.text = [[musicArr objectAtIndex:row] valueForKey:@"title"];
    
    [cell addSubview:animationTitle];
    
    //动画时间
    UILabel *animationTime = [[UILabel alloc]initWithFrame:CGRectMake(85, 32, 120, 20)];
    
    animationTime.font = [UIFont systemFontOfSize: 11.0];
    
    animationTime.textColor = [UIColor grayColor];
    
    animationTime.text = [NSString stringWithFormat:@"时长:%@",[[musicArr objectAtIndex:row] valueForKey:@"mLength"]];
    
    [cell addSubview:animationTime];
    
    //发布时间
    UIImageView *releaseTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 115, 10, 20, 20)];
    
    releaseTimeImageView.image = [UIImage imageNamed:@"发布时间.png"];
    
    [cell addSubview:releaseTimeImageView];
    
    UILabel *releaseTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 90, 10, 100, 20)];
    
    releaseTimeTitle.textColor = [UIColor grayColor];
    
    releaseTimeTitle.font = [UIFont systemFontOfSize: 11.0];
    
    releaseTimeTitle.text = [[musicArr objectAtIndex:row] valueForKey:@"createDate"];
    releaseTimeTitle.text = [releaseTimeTitle.text substringWithRange:NSMakeRange(releaseTimeTitle.text.length - 5,5)];
    
    [cell addSubview:releaseTimeTitle];
    
    //收藏次数
    UIButton *saveTimesImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    saveTimesImage.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 115, 35, 18, 18);
    
    saveTimesImage.tag = row;
    
    [saveTimesImage setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [saveTimesImage addTarget:self action:@selector(cellMvShouCangButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [saveTimesImage setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    
    [cell addSubview:saveTimesImage];
    
    UILabel *saveTimesTitle = [[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 90, 35, 40, 20)];
    
    saveTimesTitle.textColor = [UIColor grayColor];
    
    saveTimesTitle.font = [UIFont systemFontOfSize: 11.0];
    
    saveTimesTitle.text = [NSString stringWithFormat:@"%@",[[musicArr objectAtIndex:row] valueForKey:@"favCount"]];
    
    [cell addSubview:saveTimesTitle];
    
    //下载次数
    UIButton *upDataImage = [UIButton buttonWithType:UIButtonTypeCustom];
    
    upDataImage.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 50, 35, 18, 18);
    
    upDataImage.tag = row;
    
    [upDataImage setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [upDataImage addTarget:self action:@selector(cellMvUpDataButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    if ([MBProgressHUD findDocumentsFile:[[musicArr objectAtIndex:row] valueForKey:@"filePath"]])
    {
        [upDataImage setBackgroundImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal];
    }
    else
    {
        [upDataImage setBackgroundImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
    }
    
    [cell addSubview:upDataImage];
    
    UILabel *upDataTitle = [[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 25, 35, 40, 20)];
    
    upDataTitle.textColor = [UIColor grayColor];
    
    upDataTitle.font = [UIFont systemFontOfSize: 11.0];
    
    upDataTitle.text = [NSString stringWithFormat:@"%@",[[musicArr objectAtIndex:row] valueForKey:@"downloadCount"]];
    
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
    NSString *urlStr = @"user/addfavorite.do";
    
    [IKHttpTool postWithURL:urlStr params:@{@"resid":[[musicArr objectAtIndex:btn.tag] valueForKey:@"materialId"],@"restitle":[[musicArr objectAtIndex:btn.tag] valueForKey:@"title"],@"restype":[[musicArr objectAtIndex:btn.tag] valueForKey:@"materialType"]} success:^(id JSON)
     {
         NSLog(@"JSON = %@",JSON);
         
     }
     failure:^(NSError *error)
     {
         NSLog(@"error%@",error);
     }];
}

//动画下载
- (void)cellMvUpDataButClick:(UIButton *)btn
{
    if ([MBProgressHUD findDocumentsFile:[[musicArr objectAtIndex:btn.tag] valueForKey:@"filePath"]])
    {
        //文件存在，直接播放。
        //此处添加播放的代码。
        return;
    }

    if (customAlertView == nil) {
        customAlertView = [[UIAlertView alloc] initWithTitle:@"亲，请您输入购买竹兜教套里的激活码，后获取父母用书。" message:nil delegate:self cancelButtonTitle:@"获取" otherButtonTitles:@"取消", nil ];
    }
    customAlertView.tag = btn.tag;
    
    [customAlertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    
    UITextField *nameField = [customAlertView textFieldAtIndex:0];
    
    nameField.placeholder = @"请输入激活码";
    
    [customAlertView show];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *nameField = textField.text;
        
        if (nameField.length > 0)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                NSURL *surl = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.92.96.117:8080/zhudou/material/playfreematerial.do?materialid=%@",[[musicArr objectAtIndex:customAlertView.tag] valueForKey:@"materialId"]]];
                
                NSData * audioData = [NSData dataWithContentsOfURL:surl];
                
                //将数据保存到本地指定位置
                NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", docDirPath ,[[musicArr objectAtIndex:customAlertView.tag] valueForKey:@"filePath"]];
                [audioData writeToFile:filePath atomically:YES];
                
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //刷新TableView 下载记录。
                    [animationTableView reloadData];
                });
                
            });
        }
        else
        {
            [MBProgressHUD showError:@"激活码不能为空！" toView:self.view];
        }
    }
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
