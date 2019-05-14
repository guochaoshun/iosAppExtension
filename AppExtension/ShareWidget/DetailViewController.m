//
//  DetailViewController.m
//  ShareWidget
//
//  Created by apple on 2019/5/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

}
- (IBAction)cancleAction:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    NSArray * array = @[@"好友1",@"好友2",@"好友3",];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * array = @[@"好友1",@"好友2",@"好友3",];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"postMessage" object:nil userInfo:@{@"name":array[indexPath.row]}];
}


@end
