//
//  FirstViewController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/18.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"custom" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    NSURL *url = [NSURL URLWithString:@"http://stackoverflow.com/questions/18946302/uinavigationcontroller-interactive-pop-gesture-not-working"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webV loadRequest:request];
    self.title = @"web";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
