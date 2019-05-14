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

// 扩展主要参考文章 : https://blog.csdn.net/u014600626/article/details/90167969
// https://www.cnblogs.com/fengmin/p/6118592.html
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

/// 改下APP的logo , 比较费劲的是在info.plist中的设置Icon files (iOS 5) , 还有logo的图片的是png的,并且放在工程目录下,不能放到Assets中
// 参考文章 : https://www.cnblogs.com/fengmin/p/6841818.html  https://www.jianshu.com/p/a4d7c6f8e9a1
- (IBAction)changeLogo:(UIButton *)button {
    
    button.selected = !button.isSelected;
    if (button.isSelected) {
        
        // 传入nil代表使用主图标. 请确保在主队列中执行.
        [[UIApplication sharedApplication] setAlternateIconName:@"newLogo" completionHandler:^(NSError * _Nullable error) {
            
        }];
        
    } else {
        [[UIApplication sharedApplication] setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
            
        }];
    }
    
    
    

    

    
}





@end
