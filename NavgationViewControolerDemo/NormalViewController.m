//
//  NormalViewController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/18.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "NormalViewController.h"
#import "CustomNavigationController.h"

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.view.backgroundColor = [UIColor redColor];
    [self initNavigaionItem];
//    [(CustomNavigationController *)self.navigationController interactivePopGesture].delegate = self;
}
- (void)initNavigaionItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.title = @"normal";
}
- (void)pop {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
//- (void)handlePan:(UIPanGestureRecognizer *)pan {
//
//}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

@end
