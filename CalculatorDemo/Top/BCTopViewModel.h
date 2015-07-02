//
//  BCTopViewModel.h
//  CalculatorDemo
//
//  Created by iOS on 15/7/2.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCBaseViewModel.h"

typedef NS_ENUM(BCViewControllerAction,BCTopViewCallBackAction){
    BCTopViewCallBackActionReloadTable = 1 << 0,
    BCTopViewCallBackActionReloadResult = 1 << 1
};

@interface BCTopViewModel : BCBaseViewModel

- (NSString *)LEDString;

- (NSUInteger)operationCount;

- (NSString *)operationTextAtIndex:(NSUInteger)index;

- (void)undo;

- (void)clear;

@end
