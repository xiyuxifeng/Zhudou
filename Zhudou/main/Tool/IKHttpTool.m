//
//  IWHttpTool.m

//
//  Created by teacher on 14-6-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IKHttpTool.h"
#import "AFNetworking.h"
#import "Reachability.h"

@implementation IKHttpTool

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送一个GET请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功后会调用
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败后会调用
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 0.检测网络连接状况
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([r currentReachabilityStatus] == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有网络,请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", @"text/html", nil];
    mgr.requestSerializer.timeoutInterval = 10.0;
    
    // 1.1封装参数
    NSMutableDictionary *p = nil;
    if (params) {
        p = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    else {
        p = [NSMutableDictionary dictionary];
    }
    
    [p setObject:@"1.0"  forKey:@"appver"];
    [p setObject:@"2"  forKey:@"os"];

    NSString *URL = [@"http://182.92.96.117:8080/zhudou/" stringByAppendingString:url];
    // 2.发送一个POST请求
    [mgr POST:URL parameters:p success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功后会调用
        
        
#ifdef DEBUG
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@:%@",url,dataStr);
#endif
        NSError *error = nil;
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        
        if (error) {//判断是否解析成功
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"数据解析失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alt show];
            return ;
        }
        int status = [dictData[@"res_status"] intValue];
        
        // 2.1 判断状态 0表示正确 其他则表示有错误
        if (status == 1) {
            // 告诉外界(外面):我们请求成功了
            if (success) {
                success(dictData);
            }
        }else{
            
            [MBProgressHUD showError:dictData[@"err_desc"]];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败后会调用
        // 告诉外界(外面):我们请求失败了
        if (failure) {
            failure(error);
        }
    }];
}


@end
