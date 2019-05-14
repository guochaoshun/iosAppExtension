//
//  TodayViewController.m
//  TodayWidget
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NetWork.h"
#import "ViewController.h"

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [[[NetWork alloc ]init] startLoad];

    // 必须设置成NCWidgetDisplayModeExpanded才有右上角的 "展开/折叠"
    // 系统会记住你的上一次设置,第二次进入的时候会自动调整到上一次的 "展开/折叠" 状态
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;

}



- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    
    NSLog(@"widgetActiveDisplayModeDidChange %ld (%lf,%lf)",(long)activeDisplayMode,maxSize.width,maxSize.height);
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        // 在NCWidgetDisplayModeCompact下改是不管用的,系统不管你设置的大小,只会使用默认大小
//        self.preferredContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 110);
    } else {
        self.preferredContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 350);
    }
    
}


- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    
    NSUserDefaults * d = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zksw.AppExtension.group"];
    self.label.text = [d objectForKey:@"text"];

    
    
    completionHandler(NCUpdateResultNewData);
}

/// 回到宿主app
- (IBAction)goBack:(id)sender {
    
    NSURL * url = [NSURL URLWithString:@"WidgetMain://path=123"];
    
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
    }];
}




@end
