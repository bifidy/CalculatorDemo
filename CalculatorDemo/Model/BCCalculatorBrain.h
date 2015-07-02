//
//  BCCalculatorBrain.h
//  CalculatorDemo
//
//  Created by iOS on 15/6/26.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - BCCalculatorDisplayDelegate

@class BCCalculatorBrain;

@protocol BCCalculatorDisplayDelegate <NSObject>

@optional

- (void)calculator:(BCCalculatorBrain *)brain didChangeCurrentNumber:(NSNumber *)number;

- (void)calculator:(BCCalculatorBrain *)brain didAddOperate:(NSString *)operate;

@end

#pragma mark - BCCalculatorBrain

/**
 *  业务层 Model
 */
@interface BCCalculatorBrain : NSObject

/**
 *  存放所有计算过程;
 */
@property (nonatomic,strong,readonly) NSMutableArray *operations;

/**
 *  用于显示数据的代理
 */
@property (nonatomic,weak) id<BCCalculatorDisplayDelegate> displayDelegate;

/**
 *  利用单例访问
 *
 */
+ (BCCalculatorBrain *)brain;

/**
 *  新增一个数字
 *
 */
- (void)addSuffixNumber:(NSNumber *)number;

/**
 *  新增一个操作符，同时意味着上一个数字结束
 *
 */
- (void)addOperate:(NSString *)operate;

/**
 *  删除最后一个运算步骤
 */
- (void)removeLastOperation;

/**
 *  清空运算步骤
 */
- (void)clearOperations;

/**
 *  当前步骤下的运算结果，如果当前没有任何步骤，则返回 Nil
 *
 */
- (NSNumber *)result;

- (NSString *)displayString;
@end

#pragma mark - BCCalculatorOperation

/**
 *  将每组一个操作数 + 一个运算符是为一次运算过程
 */
@interface BCCalculatorOperation : NSObject

/**
 *  运算符，字符表示，暂时支持 + - * /
 */
@property (nonatomic,copy) NSString *operate;

/**
 *  操作数，记得用 float 转哦~
 */
@property (nonatomic,strong) NSNumber *number;

/**
 *  工厂方法，用于生产一个包含操作数与运算符的运算过程
 *
 *  @param number  操作数
 *  @param operate 运算符
 *
 */
+ (BCCalculatorOperation *)operationNumber:(NSNumber *)number operate:(NSString *)operate;

/**
 *  成功计算会返回运算后的值，运算如有问题则会返回 number 本身
 *
 */
- (NSNumber *)resultWithNumber:(NSNumber *)number;

@end