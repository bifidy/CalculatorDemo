//
//  BCBottomViewController.m
//  CalculatorDemo
//
//  Created by iOS on 15/6/26.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCBottomViewController.h"
#import "BCBottomViewModel.h"

@interface BCBottomViewController ()
@property (nonatomic,strong) BCBottomViewModel *model;
@end

@implementation BCBottomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [BCBottomViewModel modelWithViewController:self];
}

- (IBAction)number:(UIButton *)sender{
    NSNumber *number = @(sender.titleLabel.text.integerValue);
    [self.model setNumber:number];
}

- (IBAction)operator:(UIButton *)sender{
    NSString *operator = sender.titleLabel.text;
    [self.model setOperate:operator];
}

@end
