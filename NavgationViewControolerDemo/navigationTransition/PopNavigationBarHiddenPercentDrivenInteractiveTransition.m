//
//  PopNavigationBarHiddenPercentDrivenInteractiveTransition.m
//  MojiWeather
//
//  Created by miaogaoliang on 15/12/3.
//  Copyright © 2015年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import "PopNavigationBarHiddenPercentDrivenInteractiveTransition.h"
#import "TransitionMacroHeader.h"

@interface PopNavigationBarHiddenPercentDrivenInteractiveTransition ()
@property (weak, nonatomic) id<UIViewControllerContextTransitioning> contextData;
@property (assign, nonatomic) CGRect fromInitFrame, toInitFrame;
@property (assign, nonatomic) CGRect fromFinalFrame, toFinalFrame;
@property (weak, nonatomic) UIViewController *fromViewController, *toViewController;
@property (weak, nonatomic) UIView *fromView, *toView;
@property (assign, nonatomic) CGFloat fromOffsetX, toOffsetX;
@property (assign, nonatomic) CGRect fromNavigationFrame, toNavigationFrame;
@end

@implementation PopNavigationBarHiddenPercentDrivenInteractiveTransition
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // Always call super first.
    [super startInteractiveTransition:transitionContext];
    // Save the transition context for future reference.
    self.contextData = transitionContext;
    
    [self setupForFromSource:transitionContext];
    [self setupForToSource:transitionContext];
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [self updateToViewController:percentComplete];
    [self updateFromViewController:percentComplete];
}

- (void)updateToViewController:(CGFloat)percentComplete {
    _toView.frame = CGRectOffset(_toInitFrame, _toOffsetX * percentComplete, 0);
    _toNavigationBar.frame = CGRectOffset(_toNavigationFrame, _toOffsetX * percentComplete, 0);
}

- (void)updateFromViewController:(CGFloat)percentComplete {
    _fromView.frame = CGRectOffset(_fromInitFrame, _fromOffsetX * percentComplete, 0);
    _fromNavigationBar.frame = CGRectOffset(_fromNavigationFrame, _fromOffsetX * percentComplete, 0);
}

- (void)setupForToSource:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _toViewController = toViewController;
    _toView = _toViewController.view;
    _toInitFrame = _toView.frame;
    _toFinalFrame = _toInitFrame;
    _toFinalFrame.origin.x = 0;
    
    _toOffsetX = ABS(CGRectGetMinX(_toInitFrame));
    
    _toNavigationBar = [_toViewController.navigationController.view viewWithTag:toTagKey];
    CGRect navFrame = _toNavigationBar.frame;
    navFrame.origin.x = -_toOffsetX;
    _toNavigationFrame = navFrame;
    _toNavigationBar.frame = _toNavigationFrame;
}

- (void)setupForFromSource:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _fromViewController = fromViewController;
    _fromView = _fromViewController.view;
    _fromInitFrame = _fromView.frame;
    _fromFinalFrame = CGRectOffset(_fromInitFrame, CGRectGetWidth(_fromInitFrame), 0);
    
    _fromOffsetX = CGRectGetMinX(_fromFinalFrame) - CGRectGetMinX(_fromInitFrame);
    
    _fromNavigationBar = [_fromViewController.navigationController.view viewWithTag:fromTagKey];
    CGRect navFrame = _fromNavigationBar.frame;
    navFrame.origin.x = 0;
    _fromNavigationFrame = navFrame;
    _fromNavigationBar.frame = _fromNavigationFrame;
}
@end
