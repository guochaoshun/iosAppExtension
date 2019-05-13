//
//  ShareViewController.m
//  ShareWidget
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ShareViewController.h"
#import "DetailViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

// 1.选择分享Widget的target,把一个Deployment Target改成一个低版本的,
// 由于我用的真机不是最新的系统,所以在分享的时候一直看不到,折腾了好久才发现,😂😂😂
// 2.需要改MainInterface2的名字,info.plist中的NSExtensionMainStoryboard也需要改成一致的
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults * d = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zksw.AppExtension.group"];
    NSString * token = [d objectForKey:@"token"];
    NSLog(@"%@",token);


    
    
}

// post按钮是否可用
- (BOOL)isContentValid {
    return YES;
}

// 用户选择了确定
- (void)didSelectPost {

    NSLog(@"用户选择了确定,在这里写请求之类的");

    
    
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:^(BOOL expired) {
        NSLog(@"expired = %d",expired);
    }];
}

- (NSArray *)configurationItems {

    
    NSArray * titleArray = @[@"分享给朋友",@"分享到朋友圈",@"收藏"];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSString * title in titleArray) {

        SLComposeSheetConfigurationItem * item = [[SLComposeSheetConfigurationItem alloc]init];
        item.title =title ;
        item.value = @"value是什么";
        // 好像是右边的转圈进度条
        item.valuePending = YES ;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.valuePending = NO ;
            item.value = @"";
        });
        
        // 点击事件
        [item setTapHandler:^{
            NSLog(@"%@ 点击了",title);
            
            DetailViewController * detail = [[UIStoryboard storyboardWithName:@"MainInterface2" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewControllerNav"];
            [self presentViewController:detail animated:YES completion:^{
                
            }];
            
        }];
        [array addObject:item];
    }
    
    return array;
    
}

@end
