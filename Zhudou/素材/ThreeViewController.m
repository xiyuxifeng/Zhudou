//
//  ThreeViewController.m
//  DLSlideController
//
//  Created by Dongle Su on 14-12-6.
//  Copyright (c) 2014年 dongle. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    musicArr = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(([[UIScreen mainScreen] bounds].size.width - 45)/3, [[UIScreen mainScreen] bounds].size.height > 640 ? 140 :120);
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直滚动
    
    UICollectionView *studyBook = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 144) collectionViewLayout:layout];
    
    studyBook.backgroundColor = [UIColor whiteColor];
    
   
    studyBook.contentSize = CGSizeMake(0,MAXFLOAT);
    
    studyBook.dataSource = self;
    
    studyBook.delegate = self;
    
    [self.view addSubview:studyBook];
    
    [studyBook registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    
    NSString *urlStr = @"material/materiallist.do";
    
    [IKHttpTool postWithURL:urlStr params:nil success:^(id JSON)
     {
         NSLog(@"JSON = %@",JSON);
         
         [musicArr removeAllObjects];
         
         NSArray *arr = [JSON valueForKey:@"res_data"];
         
         for (NSDictionary *dc  in arr) {
             
             NSString *str = [dc objectForKey:@"catalog"];
             
             if (str.intValue == 3)
             {
                 [musicArr addObject:dc];
             }
         }
         
         [studyBook reloadData];
         
     }
                    failure:^(NSError *error)
     {
         NSLog(@"error%@",error);
     }];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return musicArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"myCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f]; 
    
    UIImageView *releaseTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 77, 77)];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.92.96.117:8080/zhudou/%@",[[musicArr objectAtIndex:[indexPath row]] valueForKey:@"titlePic"]]];
    
    releaseTimeImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    [cell addSubview:releaseTimeImageView];
    
//    //动画预览图
//    UIButton *playImageView = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    
//    playImageView.frame = CGRectMake(10, 10, 77, 77);
//    
//    [playImageView setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//    
//    // 给button添加事件
//    //    [playImageView addTarget:self action:@selector(cellMvPlayButClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //设置button填充图片
//    [playImageView setBackgroundImage:[UIImage imageNamed:@"宝典图片.png"] forState:UIControlStateNormal];
    
    UIButton *tui = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tui.tag = 3;
    
    tui.frame = CGRectMake((cell.frame.size.width - 18) / 2, cell.frame.size.height - 20, 18, 18);
    
    [tui setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    
    // 给button添加事件
    [tui addTarget:self action:@selector(SwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置button填充图片
    [tui setBackgroundImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
    
    //显示控件
    [cell addSubview:tui];
    
    UILabel *releaseTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 87, 97, 20)];
    
    releaseTimeTitle.textColor = [UIColor grayColor];
    
    releaseTimeTitle.textAlignment = 1;
    
    releaseTimeTitle.font = [UIFont systemFontOfSize: 11.0];
    
    releaseTimeTitle.text = @"豆点点";
    
    [cell addSubview:releaseTimeTitle];

    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 125);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)SwitchClick:(UIButton *)btn
{
    if (customAlertView == nil) {
        customAlertView = [[UIAlertView alloc] initWithTitle:@"亲，请您输入购买竹兜教套里的激活码，后获取父母用书。" message:nil delegate:self cancelButtonTitle:@"获取" otherButtonTitles:@"取消", nil ];
    }
    
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
            
        }
        else
        {
            [MBProgressHUD showError:@"激活码不能为空！" toView:self.view];
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"three didReceiveMemoryWarning");
}
- (void)dealloc{
    NSLog(@"three dealloc");
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
