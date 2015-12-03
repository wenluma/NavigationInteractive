//
//  TransitionMacroHeader.h
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/27.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#ifndef TransitionMacroHeader_h
#define TransitionMacroHeader_h

#import <UIKit/UIKit.h>

static CGFloat transitionScale = 0.25;
static NSInteger fromTagKey = -1000;
static NSInteger toTagKey = -1001;

typedef NS_ENUM(NSUInteger, NavigationBarState) {
    NavigationBarStateMoving,
    NavigationBarStateWaiting,
};


static NSString *const TransitionNotifactionControlAnimationKey = @"TransitionNotifactionControlAnimationKey";
@protocol TransitionProtocol <NSObject,UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) BOOL interactive;
@property (assign, nonatomic) NavigationBarState navigationBarState;
- (void)finishOrCancelledTransition;
@end

#endif /* TransitionMacroHeader_h */
