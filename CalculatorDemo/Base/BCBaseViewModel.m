//
//  BCBaseViewModel.m
//  CalculatorDemo
//
//  Created by iOS on 15/6/25.
//  Copyright (c) 2015年 BC. All rights reserved.
//

#import "BCBaseViewModel.h"

@implementation UIViewController(ViewModel)

- (void)callBackAction{
    [self callBackAction:0 info:nil];
}

- (void)callBackAction:(BCViewControllerAction)action{
    [self callBackAction:action info:nil];
}

- (void)callBackAction:(BCViewControllerAction)action info:(id)info{
}

@end

@implementation BCBaseViewModel

+ (instancetype)modelWithViewController:(UIViewController *)viewController{
    BCBaseViewModel *model = self.new;
    if (model) {
        model.viewController = viewController;
    }
    return model;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"View model:%@ viewController:%@",
            super.description,
            self.viewController.description
            ];
}

@end
