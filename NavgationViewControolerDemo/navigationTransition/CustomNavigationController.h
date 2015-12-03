//
//  CustomNavigationController.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopPercentDrivenInteractiveTransition.h"

@class PopTransition;
@class PopNavigationBarHiddenTransition;
@class PopWithNavigationBarTransition;
@interface CustomNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) PopPercentDrivenInteractiveTransition *interactivePopTransition;
@property (strong, nonatomic) PopTransition *popTransition;
@property (strong, nonatomic) PopNavigationBarHiddenTransition *popNavigationBarHiddenTransition;
@property (strong, nonatomic) PopWithNavigationBarTransition *popWithNavigationBarTransition;
@property (strong, nonatomic) NSMutableArray *navigationBarArray;
@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *interactivePopGesture;
@end
