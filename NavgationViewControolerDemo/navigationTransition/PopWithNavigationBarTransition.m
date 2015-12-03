//
//  PopWithNavigationBarTransition.m
//  MojiWeather
//
//  Created by miaogaoliang on 15/12/3.
//  Copyright © 2015年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import "PopWithNavigationBarTransition.h"

@interface PopWithNavigationBarTransition ()

@property (weak, nonatomic) UIViewController *fromViewController, *toViewController;
@property (weak, nonatomic) UIView *fromView, *toView;
@property (assign, nonatomic) CGRect fromInitFrame, toInitFrame;
@property (assign, nonatomic) CGRect fromFinalFrame, toFinalFrame;
@property (assign, nonatomic) CGFloat fromOffsetX, toOffsetX;

@end
@implementation PopWithNavigationBarTransition

- (NavigationBarState)navigationBarState {
    return NavigationBarStateMoving;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    _interactive = [transitionContext isInteractive];
    [self setupToView:transitionContext];
    [self setupFromView:transitionContext];
    
    if ( _interactive ) {
        [_toView addSubview:_toNavigaionBar];
        _fromNavigationBar = _fromViewController.navigationController.navigationBar;

        _toNavigaionBar.tag = toTagKey;
        _fromNavigationBar.tag = fromTagKey;
        
    } else {
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        
        __typeof(self) __weak weakSelf = self;
        id <UIViewControllerContextTransitioning> __weak weakContext = transitionContext;
        [UIView animateWithDuration:duration animations:^{
            weakSelf.fromView.frame = weakSelf.fromFinalFrame;
            weakSelf.toView.frame = weakSelf.toFinalFrame;
        } completion:^(BOOL finished) {
            // Clean up
            [weakContext completeTransition:!weakContext.transitionWasCancelled];
        }];
        
    }
}

- (void)overTransition {
    BOOL transitionCompleted = !self.transitionContext.transitionWasCancelled;
    __typeof(self) __weak weakSelf = self;
    if ( transitionCompleted ) {
        UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIView * __weak weakToView = toViewController.view;
        UIView * __weak weakFromView = fromViewController.view;
        NSTimeInterval duration = [self transitionDuration:self.transitionContext];
        
        CGRect tofinalRect = [self.transitionContext finalFrameForViewController:toViewController];
        CGRect fromFinalRect = CGRectOffset(tofinalRect, CGRectGetWidth(tofinalRect), 0);
        
        CGRect navBarFrame = weakSelf.fromNavigationBar.frame;
        navBarFrame.origin.x = 0;
        weakSelf.fromNavigationBar.frame = navBarFrame;
        weakSelf.fromNavigationBar.hidden = YES;
        [UIView animateWithDuration:duration * transitionScale animations:^{
            weakFromView.frame = fromFinalRect;
            weakToView.frame = tofinalRect;
            
            weakSelf.toNavigaionBar.frame = navBarFrame;
        } completion:^(BOOL finished) {
            [weakSelf destory];
        }];
        
    } else {
        UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView * __weak weakToView = toViewController.view;
        UIView * __weak weakFromView = fromViewController.view;
        NSTimeInterval duration = [self transitionDuration:self.transitionContext];
        CGRect fromFinalRect = _fromFinalFrame;
        
        CGFloat offsetX = CGRectGetWidth(fromFinalRect) * transitionScale;
        CGRect toFinalRect = CGRectOffset(fromFinalRect, -offsetX, 0);
        CGRect navBarFrame = weakSelf.fromNavigationBar.frame;
        navBarFrame.origin.x = 0;
        
        [UIView animateWithDuration:duration * transitionScale animations:^{
            weakToView.frame = weakSelf.toFinalFrame;
            weakFromView.frame = weakSelf.fromInitFrame;
            weakSelf.fromNavigationBar.frame = navBarFrame;
            weakSelf.toNavigaionBar.frame = navBarFrame;
        } completion:^(BOOL finished) {
            [weakSelf destory];
        }];
    }
}
- (void)destory {
    _fromNavigationBar.tag = 0;
    
    if ( !self.transitionContext.transitionWasCancelled ) {
        [_toNavigaionBar performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.1];
    }else {
        [_toNavigaionBar removeFromSuperview];
    }
    self.fromNavigationBar.hidden = NO;
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    _interactive = NO;

    
}
- (void)finishOrCancelledTransition{
    [self overTransition];
}
- (void)setupToView:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _toViewController = toViewController;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toViewController.view];
    _toView = toViewController.view;
    CGRect frame = _toView.frame;
    frame.origin.x = 0;
    _toView.frame = frame;
    _toFinalFrame = _toView.frame;
    
    CGFloat offsetX = -CGRectGetWidth(_toView.frame) * transitionScale;
    CGRect toInitRect = CGRectOffset(_toView.frame, offsetX, 0);
    _toView.frame = toInitRect;
    _toInitFrame = toInitRect;
}

- (void)setupFromView:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromViewController = fromViewController;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromViewController.view];
    _fromView = fromViewController.view;
    _fromInitFrame = _fromView.frame;
    _fromFinalFrame = CGRectOffset(_fromView.frame, CGRectGetWidth(_fromView.frame), 0);
}

@end
