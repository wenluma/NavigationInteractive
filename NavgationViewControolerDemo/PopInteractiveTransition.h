//
//  PopInteractiveTransition.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/26.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopInteractiveTransition : NSObject <UIViewControllerInteractiveTransitioning>
@property (nonatomic) BOOL interactive;
@property (nonatomic) CGFloat progress;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end
