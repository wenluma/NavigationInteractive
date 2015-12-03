//
//  PopWithNavigationBarTransition.h
//  MojiWeather
//
//  Created by miaogaoliang on 15/12/3.
//  Copyright © 2015年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionMacroHeader.h"

@interface PopWithNavigationBarTransition : NSObject <TransitionProtocol>
@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic) UIView *fromNavigationBar;
@property (weak, nonatomic) UIView *toNavigaionBar;
@property (assign, nonatomic) BOOL interactive;
@property (assign, nonatomic) NavigationBarState navigationBarState;
@end
