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
    
    self.view.backgroundColor = [UIColor redColor];
    [self initNavigaionItem];
}
- (void)initNavigaionItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.title = @"normal";
}
- (void)pop {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
