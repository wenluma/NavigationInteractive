//
//  PopTransition.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/27.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionMacroHeader.h"

@interface PopTransition : NSObject <TransitionProtocol>
@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic) UIView *fromNavigationBar;
@property (weak, nonatomic) UIView *toNavigaionBar;

@property (assign, nonatomic) BOOL interactive;
@property (assign, nonatomic) NavigationBarState navigationBarState;

@end
