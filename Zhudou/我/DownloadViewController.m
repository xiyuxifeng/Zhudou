//
//  DownloadViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownloadCell.h"

@interface DownloadViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITableView *downloadingTable;

@property (nonatomic, strong) UITableView *downloadTabel;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *downloadingArr;

@property (nonatomic, strong) NSMutableArray *downloadArr;

@property (nonatomic, strong) UIButton *downloadingBut;

@property (nonatomic, strong) UIButton *downloadBut;
@end


@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 数据初始化
    
    self.downloadingArr = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    self.downloadArr = [NSMutableArray arrayWithObjects:@"5", @"6", nil];

    
    [self layoutViews];
    
}

- (void)layoutViews
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat viewHeight = 44;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, width, viewHeight )];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    self.downloadingBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadingBut.frame = CGRectMake(30, 0, (width - 60) / 2, viewHeight);
    [self.downloadingBut setTitle:@"下载中" forState:UIControlStateNormal];
    self.downloadingBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.downloadingBut addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadingBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:self.downloadingBut];
    
    self.downloadBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadBut.frame = CGRectMake((width - 60) / 2 + 30, 0, (width - 60) / 2, viewHeight);
    [self.downloadBut setTitle:@"已下载" forState:UIControlStateNormal];
    self.downloadBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.downloadBut addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [view addSubview:self.downloadBut];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(30, viewHeight, (width - 60) / 2, 2)];
    self.lineView.backgroundColor = [UIColor greenColor];
    [view addSubview:self.lineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, view.frame.size.height + 2 + 64, width, height - view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(width * 2, height - view.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.downloadingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.downloadingTable.dataSource = self;
    self.downloadingTable.delegate = self;
    
    self.downloadTabel = [[UITableView alloc] initWithFrame:CGRectMake(width, 0, width, self.scrollView.frame.size.height) style:UITableViewStylePlain];
    self.downloadTabel.dataSource = self;
    self.downloadTabel.delegate = self;
    
    [self.scrollView addSubview:self.downloadTabel];
    [self.scrollView addSubview:self.downloadingTable];

    
}

#pragma mark - Button Click

- (void)downClick: (UIButton *)btn
{
    [self changeLineFram:btn];
    
    int index = 0;
    if (btn == self.downloadBut) {
        index = 1;
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * index, self.scrollView.contentOffset.y) animated:YES];
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.downloadingTable) {
        return self.downloadingArr.count;
    }else{
        return self.downloadArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *downloadCellId = @"downloadCellId";
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DownloadCell" owner:self options:nil] lastObject];
    }
    cell.cellLabel.text = [self.downloadingArr objectAtIndex:indexPath.row];
    
    if (tableView == self.downloadTabel) {
        cell.cellProgress.hidden = YES;
        cell.playButton.hidden = YES;
    }
    return cell;
    
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;

    if (index == 0) {
        [self changeLineFram:self.downloadingBut];
    }else{
        [self changeLineFram:self.downloadBut];
    }
}

-(void)changeLineFram:(UIButton *)button
{
    [UIView animateWithDuration:0.2f animations:^{
        self.lineView.center = CGPointMake(button.center.x, self.lineView.center.y);
    }];
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
