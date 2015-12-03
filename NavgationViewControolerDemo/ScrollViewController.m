//
//  ScrollViewController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/18.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "ScrollViewController.h"


@implementation ScrollViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    _scroll.contentSize = CGSizeMake(CGRectGetWidth(frame)*2, CGRectGetHeight(frame));
    
    UIView *redView = [[UIView alloc] initWithFrame:frame];
    redView.backgroundColor = [UIColor redColor];
    [_scroll addSubview:redView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectOffset(frame, CGRectGetWidth(frame), 0)];
    greenView.backgroundColor = [UIColor greenColor];
    [_scroll addSubview:greenView];
    self.title = @"scrollview";

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
