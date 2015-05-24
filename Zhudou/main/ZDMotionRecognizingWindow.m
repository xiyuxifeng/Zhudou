//
//  ZDMotionRecognizingWindow.m
//  Zhudou
//
//  Created by li on 15/5/23.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "ZDMotionRecognizingWindow.h"

@implementation ZDMotionRecognizingWindow
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CPDeviceShaken" object:self];
    }
}
@end
