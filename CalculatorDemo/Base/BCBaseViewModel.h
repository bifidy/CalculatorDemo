//
//  BCBaseViewModel.h
//  CalculatorDemo
//
//  Created by iOS on 15/6/25.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSUInteger BCViewControllerAction;

@interface UIViewController(ViewModel)

- (void)callBackAction;

- (void)callBackAction:(BCViewControllerAction)action;

- (void)callBackAction:(BCViewControllerAction)action info:(id)info;

@end

@interface BCBaseViewModel : NSObject

@property (nonatomic,weak) UIViewController *viewController;

+ (instancetype)modelWithViewController:(UIViewController *)viewController;

@end
