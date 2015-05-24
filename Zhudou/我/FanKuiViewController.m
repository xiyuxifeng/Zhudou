//
//  FanKuiViewController.m
//  ZhuDou
//
//  Created by wang hui on 15/5/23.
//  Copyright (c) 2015年 Aldelo. All rights reserved.
//

#import "FanKuiViewController.h"

@interface FanKuiViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cellPhoneNum;

@property (weak, nonatomic) IBOutlet UITextView *message;
@property (weak, nonatomic) IBOutlet UIView *MessageView;
@property (weak, nonatomic) IBOutlet UIView *cellPhoneView;
@property (weak, nonatomic) IBOutlet UIButton *sumbitBtn;

@end

@implementation FanKuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sumbitBtn.layer.cornerRadius = 5;
    self.sumbitBtn.layer.masksToBounds = YES;
    
    self.cellPhoneView.layer.borderWidth = 1;
    self.cellPhoneView.layer.borderColor = [UIColor grayColor].CGColor;
    self.cellPhoneView.layer.cornerRadius = 5;
    self.MessageView.layer.borderWidth = 1;
    self.MessageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.MessageView.layer.cornerRadius = 5;
    
    self.cellPhoneNum.delegate = self;
    self.message.delegate = self;
    
}
- (IBAction)submitClick:(UIButton *)sender {
    NSLog(@"submit");
    [self.message resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
