//
//  PopNavigationBarHiddenPercentDrivenInteractiveTransition.h
//  MojiWeather
//
//  Created by miaogaoliang on 15/12/3.
//  Copyright © 2015年 Moji Fengyun Software & Technology Development co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopNavigationBarHiddenPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (weak, nonatomic) UIView *fromNavigationBar, *toNavigationBar;
@property (assign, nonatomic, getter=isInteractive) BOOL interactive;

@end
