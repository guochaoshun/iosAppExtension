//
//  NetWork.m
//  AppExtension
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork


- (void)startLoad {
    
    NSLog(@"开始请求数据");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSLog(@"结束请求数据");
    });
    
}

@end
