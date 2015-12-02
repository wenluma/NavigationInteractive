//
//  PopInteractiveTransition.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "PopInteractiveTransition.h"

@implementation PopInteractiveTransition
- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    _progress = percentComplete;
    
}
- (void)cancelInteractiveTransition {
    
}
- (void)finishInteractiveTransition {
    
}

- (CGFloat)completionSpeed {
    return 1;
}
- (UIViewAnimationCurve)completionCurve {
    return UIViewAnimationCurveEaseInOut;
}
@end
