//
//  ZDControllerTool.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDControllerTool.h"
#import "ZDNewfeatureViewController.h"
#import "ZDTabBarController.h"
@implementation ZDControllerTool
+ (void)chooseRootViewController {
    NSString *key = (__bridge NSString *)kCFBundleVersionKey;
    
    // 1.当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *window = application.keyWindow;
    
    // 2.沙盒中的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sandBoxVersion = [defaults stringForKey:key];
    
    // 3.比较  当前软件的版本号  和  沙盒中的版本号
    if ([currentVersion compare:sandBoxVersion] == NSOrderedDescending) {
        // 存储当前软件的版本号
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
        
        window.rootViewController = [[ZDNewfeatureViewController alloc] init];
    } else {
        // 显示状态栏
        application.statusBarHidden = NO;
        window.rootViewController = [[ZDTabBarController alloc] init];
    }

}
@end
