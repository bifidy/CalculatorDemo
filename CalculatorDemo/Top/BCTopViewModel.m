//
//  BCTopViewModel.m
//  CalculatorDemo
//
//  Created by iOS on 15/7/2.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCTopViewModel.h"
#import "BCCalculatorBrain.h"

@interface BCTopViewModel()<BCCalculatorDisplayDelegate>

- (BCCalculatorBrain *)calculatorBrain;

@end

@implementation BCTopViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.calculatorBrain.displayDelegate = self;
    }
    return self;
}

- (NSString *)LEDString{
    return self.calculatorBrain.displayString;
}

- (NSUInteger)operationCount{
    return self.calculatorBrain.operations.count;
}

- (NSString *)operationTextAtIndex:(NSUInteger)index{
    return [self.calculatorBrain.operations[index] description];
}

- (void)undo{
    [self.calculatorBrain removeLastOperation];
    [self.viewController callBackAction:BCTopViewCallBackActionReloadResult | BCTopViewCallBackActionReloadTable];
}

- (void)clear{
    [self.calculatorBrain clearOperations];
    [self.viewController callBackAction:BCTopViewCallBackActionReloadResult | BCTopViewCallBackActionReloadTable];
}

#pragma mark - BCCalculatorDisplayDelegate

- (void)calculator:(BCCalculatorBrain *)brain didAddOperate:(NSString *)operate{
    [self.viewController callBackAction:BCTopViewCallBackActionReloadResult | BCTopViewCallBackActionReloadTable];
}

- (void)calculator:(BCCalculatorBrain *)brain didChangeCurrentNumber:(NSNumber *)number{
    [self.viewController callBackAction:BCTopViewCallBackActionReloadResult];
}

#pragma mark - getter

- (BCCalculatorBrain *)calculatorBrain{
    return [BCCalculatorBrain brain];
}

@end
