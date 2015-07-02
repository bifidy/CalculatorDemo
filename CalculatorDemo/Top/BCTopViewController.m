//
//  BCTopViewController.m
//  CalculatorDemo
//
//  Created by iOS on 15/6/25.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCTopViewController.h"
#import "BCTopViewModel.h"



@interface BCTopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) BCTopViewModel *model;
@property (nonatomic,weak) IBOutlet UITableView *operationTable;
@property (nonatomic,weak) IBOutlet UILabel *result;
@end


@implementation BCTopViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.model = [BCTopViewModel modelWithViewController:self];
    self.operationTable.tableFooterView = UIView.new;
    
}

#pragma mark - action

- (IBAction)undo:(UIButton *)sender{
    [self.model undo];
}

- (IBAction)clear:(UIButton *)sender{
    [self.model clear];
}

#pragma mark - call back

- (void)callBackAction:(BCViewControllerAction)action{
    if (action & BCTopViewCallBackActionReloadTable) {
        [self.operationTable reloadData];
    }
    if (action & BCTopViewCallBackActionReloadResult) {
        self.result.text = self.model.LEDString;
    }
}

#pragma mark - tableView datasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.operationCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.model operationTextAtIndex:indexPath.row];
    return cell;
}

@end
