//
//  BCTopViewModel.m
//  CalculatorDemo
//
//  Created by iOS on 15/6/25.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCBottomViewModel.h"
#import "BCCalculatorBrain.h"

@implementation BCBottomViewModel

- (void)setNumber:(NSNumber *)number{
    [[BCCalculatorBrain brain] addSuffixNumber:number];
}

- (void)setOperate:(NSString *)operate{
    [[BCCalculatorBrain brain] addOperate:operate];
}

@end
