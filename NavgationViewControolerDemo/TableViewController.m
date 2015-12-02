//
//  TableViewController.m
//  NavgationViewControolerDemo
//
//  Created by miaogaoliang on 15/11/18.
//  Copyright © 2015年 miaogaoliang. All rights reserved.
//

#import "TableViewController.h"
#import "FirstViewController.h"
#import "ScrollViewController.h"
#import "NormalViewController.h"

@implementation TableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    NSMutableArray *mutAry = [[NSMutableArray alloc] initWithCapacity:10];
    self.dataSource = mutAry;
    [_dataSource addObject:@"WebViewController"];
    [_dataSource addObject:@"ScrollViewController"];
    [_dataSource addObject:@"NormalViewController"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDcell"];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)gotoNextViewControllerFromStoryID:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self gotoNextViewControllerFromStoryID:_dataSource[indexPath.row]];
}

@end
