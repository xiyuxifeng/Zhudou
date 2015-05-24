//
//  ZDsinginViewController.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDsinginViewController.h"
#import "ZDRegisterAViewController.h"
#import "ZDNavigationController.h"

@interface ZDsinginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;

@end

@implementation ZDsinginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *rightBtn = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    if (iphone5) {
        //通知键盘即将出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)registerAction:(UIButton *)btn {
    ZDRegisterAViewController *registerVC = [[ZDRegisterAViewController alloc]init];
    registerVC.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillShow:(NSNotification*)n {
    self.view.transform = CGAffineTransformMakeTranslation(0, -100);
}
- (void)keyboardWillHide:(NSNotification*)n {
    self.view.transform = CGAffineTransformIdentity;
}

- (IBAction)siginBtnClick:(UIButton *)sender {
}
- (IBAction)ForgetForgetForgetforgetWordBtnClick:(UIButton *)sender {
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
