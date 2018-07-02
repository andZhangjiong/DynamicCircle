//
//  HXDynamicController.m
//  DynamicCircle
//
//  Created by 张炯 on 2018/7/2.
//  Copyright © 2018年 张炯. All rights reserved.
//

#import "HXDynamicController.h"

#import "HXDynamicTableView.h"

#import "HXDynamic.h"

@interface HXDynamicController ()

@property (nonatomic, strong) HXDynamicTableView *tableView;

@end

@implementation HXDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
    [self setupData];
}

- (void)setupView
{
    self.tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

- (void)setupData
{
    [self.tableView setupDatas:[HXDynamic getLocalData]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter

- (HXDynamicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[HXDynamicTableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
