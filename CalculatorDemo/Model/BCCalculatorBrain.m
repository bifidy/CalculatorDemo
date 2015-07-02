//
//  BCCalculatorBrain.m
//  CalculatorDemo
//
//  Created by iOS on 15/6/26.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCCalculatorBrain.h"

@interface BCCalculatorBrain()
@property (nonatomic,strong,readwrite) NSMutableArray *operations;
@property (nonatomic,strong,readwrite) NSNumber *currentNumber;
@property (nonatomic,copy) NSString *lastOperate;
@property (nonatomic,assign) BOOL shouldCalculate;
@end

@implementation BCCalculatorBrain

+ (BCCalculatorBrain *)brain{
    static BCCalculatorBrain *brain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        brain = [BCCalculatorBrain new];
    });
    return brain;
}

- (void)addSuffixNumber:(NSNumber *)number{
    if (!number) {
        NSLog(@"number is nil");
        return;
    }
    
    //记录运算符后，当前操作数被清空，用于记录下一个数字
    if (self.shouldCalculate) {
        self.currentNumber = nil;
        self.shouldCalculate = NO;
    }
    
    self.currentNumber = @(self.currentNumber.integerValue * 10 + number.integerValue);
    
    if ([self.displayDelegate respondsToSelector:@selector(calculator:didChangeCurrentNumber:)]) {
        [self.displayDelegate calculator:self didChangeCurrentNumber:self.currentNumber];
    }
}

- (void)addOperate:(NSString *)operate{
    self.shouldCalculate = YES;
    //生产 operation 时做了默认值处理
    BCCalculatorOperation *operation = [BCCalculatorOperation operationNumber:self.currentNumber ?: @(0)
                                                                      operate:self.lastOperate ?: @""];
    [self addOperation:operation];
    
    //每次记录运算符，为记录上一次运算符，本次运算符等待新数字，与输入方式相反。
    //所以第一次记录运算符为空
    self.lastOperate = operate;
    
    if ([self.displayDelegate respondsToSelector:@selector(calculator:didAddOperate:)]) {
        [self.displayDelegate calculator:self didAddOperate:operate];
    }
}

- (void)clearOperations{
    self.operations = nil;
    self.currentNumber = @(0);
    self.lastOperate = nil;
    if ([self.displayDelegate respondsToSelector:@selector(calculator:didChangeCurrentNumber:)]) {
        [self.displayDelegate calculator:self didChangeCurrentNumber:self.currentNumber];
    }
}

- (void)removeLastOperation{
    if (self.operations.firstObject) {
        [self.operations removeObjectAtIndex:0];
    }
    self.shouldCalculate = YES;
}

- (NSNumber *)result{
    if (!self.operations.count) {
        return nil;
    }else{
        __block NSNumber *result = @(0);
        [self.operations enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(BCCalculatorOperation *operation, NSUInteger idx, BOOL *stop) {
            result = [operation resultWithNumber:result];
        }];
        return result;
    }
}

- (NSString *)displayString{
    if (self.shouldCalculate) {
        return self.result.stringValue ?: @"0";
    }else{
        return self.currentNumber.stringValue ?: @"0";
    }
}

#pragma mark - private method

- (void)addOperation:(BCCalculatorOperation *)operation{
    //确保每次赋值时 该属性都存在
    if (!self.operations) {
        self.operations = [NSMutableArray array];
    }
    [self.operations insertObject:operation atIndex:0];
}

@end

@implementation BCCalculatorOperation

+ (BCCalculatorOperation *)operationNumber:(NSNumber *)number operate :(NSString *)operate{
    BCCalculatorOperation *operation = self.new;
    if (operation) {
        operation.number = number;
        operation.operate = operate;
    }
    return operation;
}

- (NSNumber *)resultWithNumber:(NSNumber *)number{
    if ([self.operate isEqualToString:@"+"]) {
        return @(number.floatValue + self.number.floatValue);
    }else if([self.operate isEqualToString:@"-"]){
        return @(number.floatValue - self.number.floatValue);
    }else if([self.operate isEqualToString:@"*"]){
        return @(number.floatValue * self.number.floatValue);
    }else if([self.operate isEqualToString:@"/"]){
        if ([self.number isEqualToNumber:@(0)]) {
            NSLog(@"0 can not be divisor.");
            return number;
        }
        return @(number.floatValue / self.number.floatValue);
    }else{
        NSLog(@"unknown operator:%@",self.operate);
        return self.number;
    }
}

//这里这么做是个 trick ，其实会妨碍调试，因为不再显示内存地址
- (NSString *)description{
    return [NSString stringWithFormat:@"%@%@",self.operate,self.number];
}

@end
