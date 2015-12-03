//
//  PopPercentDrivenInteractiveTransition.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/27.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionMacroHeader.h"
@interface PopPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (weak, nonatomic) UIView *fromNavigationBar, *toNavigationBar;
@property (assign, nonatomic, getter=isInteractive) BOOL interactive;
@property (weak, nonatomic) id<TransitionProtocol> transtion;
@end