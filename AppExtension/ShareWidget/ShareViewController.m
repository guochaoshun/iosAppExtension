//
//  ShareViewController.m
//  ShareWidget
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ShareViewController.h"
#import "DetailViewController.h"
#import <objc/runtime.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

// 1.选择分享Widget的target,把一个Deployment Target改成一个低版本的,
// 由于我用的真机不是最新的系统,所以在分享的时候一直看不到,折腾了好久才发现,
// 2.需要改MainInterface2的名字,info.plist中的NSExtensionMainStoryboard也需要改成一致的

// 本来想模仿微信的分享 , 但是找了系统的方法没有找到 , 应该是用了私有的方法 , postButtonTapped:
// [self performSelector:@selector(postButtonTapped:) withObject:nil afterDelay:0];

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"微信分享";
    
    NSUserDefaults * d = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zksw.AppExtension.group"];
    NSString * token = [d objectForKey:@"token"];
    NSLog(@"%@",token);

    [self runTests];
    
    // 可以获取到分享的内容
    NSLog(@"%@",self.extensionContext.inputItems);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postAction:) name:@"postMessage" object:nil];;
    
}

- (void)postAction:(NSNotification *)noti {
    NSString *name = noti.userInfo[@"name"];
    NSLog(@"给%@发消息",name);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self performSelector:@selector(postButtonTapped:) withObject:nil afterDelay:0];
#pragma clang diagnostic pop

}

/// 处理分享的内容
- (void)dealInputItems {
    
    for (NSExtensionItem * item in self.extensionContext.inputItems) {
        
        NSLog(@"%@ %@",item.attributedTitle,item.attributedContentText);
        for (NSItemProvider * itemProvider in item.attachments) {
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
            }
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.image"])
            {
            }
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.movie"])
            {
            }
        }
        
    }
    
}

- (void)runTests
{
    unsigned int count;
    Method *methods = class_copyMethodList([SLComposeServiceViewController class], &count);
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
    
        NSLog(@" %@ ", name);
    }
    
    
}

// post按钮是否可用. 当你每次输入内容的时候，都会调用此方法
- (BOOL)isContentValid {
    NSLog(@"%@",self.textView.text);
    return YES;
}

// 用户选择了发送
- (void)didSelectPost {

    NSLog(@"用户选择了发送,在这里写请求之类的");
    
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
