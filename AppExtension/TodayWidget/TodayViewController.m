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
