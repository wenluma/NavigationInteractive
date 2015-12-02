//
//  PopTransition.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//  http://dativestudios.com/blog/2013/09/29/interactive-transitions/

#import "PushTransition.h"

@implementation PushTransition
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [self setupToView:transitionContext];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    CGRect toFinalRect = toView.frame;
    CGRect toInitRect = CGRectMake(CGRectGetMidX(toFinalRect), CGRectGetMidY(toFinalRect), 0, 0);
    toView.frame = toInitRect;
    
    UIView * __weak weakToView = toView;
    id <UIViewControllerContextTransitioning> __weak weakContext = transitionContext;
    [UIView animateWithDuration:duration animations:^{
//        weakFromView.frame = fromFinalRect;
        weakToView.frame = toFinalRect;
    } completion:^(BOOL finished) {
        // Clean up
        // Declare that we've finished
        [weakContext completeTransition:!weakContext.transitionWasCancelled];
    }];
}
- (UIView *)setupToView:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
//    CGRect finalRect = [transitionContext finalFrameForViewController:toViewController];
    return toViewController.view;
}

- (UIView *)setupFromView:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromViewController.view];
//    UIView * __weak weakFromView = fromViewController.view;
//    CGRect fromFinalRect = CGRectOffset( fromViewController.view.frame, CGRectGetWidth( fromViewController.view.frame), 0);
    return fromViewController.view;
}
@end
