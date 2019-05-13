//
//  ViewController.m
//  AppExtension
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "NetWork.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

// 主要参考文章 : https://www.cnblogs.com/fengmin/p/6118592.html
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 这个参数必须是group的id(group.com.zksw.AppExtension.group)
    // 如果不是groupID,会在主App的沙盒路径library下创建,就不能共享数据了
    NSUserDefaults * d = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zksw.AppExtension.group"];
    [d setObject:self.textField.text forKey:@"text"];
    
    [d setObject:@"用户的token" forKey:@"token"];

    [[[NetWork alloc ]init] startLoad];
    
}

- (IBAction)gotoWidget:(id)sender {
    
    NSUserDefaults * d = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zksw.AppExtension.group"];
    [d setObject:self.textField.text forKey:@"text"];

    
    
}


@end
