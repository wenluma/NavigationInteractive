//
//  PopTransition.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/27.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic) UIView *fromNavigationBar;
@property (weak, nonatomic) UIView *toNavigaionBar;

@property (assign, nonatomic) BOOL interactive;

- (void)finishOrCancelledTransition;

@end
