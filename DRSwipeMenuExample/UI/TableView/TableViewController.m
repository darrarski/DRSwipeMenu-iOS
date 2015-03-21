//
//  TableViewController.m
//  DRSwipeMenuExample
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "DRSwipeMenuView.h"
#import "TableViewCellMainView.h"

@interface TableViewController ()

@end

@implementation TableViewController

static NSString *const CellReuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.mainView.textLabel.text = @"Cell with swipe menu that contains one button";
            [cell.swipeMenuView setMenuItemViews:@[
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon1"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }()
            ]];
        }
        else if (indexPath.row == 1) {
            cell.mainView.textLabel.text = @"Cell with swipe menu that contains several buttons";
            [cell.swipeMenuView setMenuItemViews:@[
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon2"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon3"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon4"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }()
            ]];
        }
        else if (indexPath.row == 2) {
            cell.mainView.textLabel.text = @"Cell with swipe menu that contains many buttons that does not fit on one screen";
            [cell.swipeMenuView setMenuItemViews:@[
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon5"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 20)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon6"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 20)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon7"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 20)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon8"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon9"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }(),
                ^UIView *() {
                    UIButton *button = [[UIButton alloc] init];
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon10"]] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                    return button;
                }()
            ]];
        }
        if (indexPath.row == 3) {
            cell.mainView.textLabel.text = @"Cell with swipe menu that contains custom view with text label";
            [cell.swipeMenuView setMenuItemViews:@[
                ^UIView *() {
                    UIView *view = [[UIView alloc] init];
                    UILabel *label = [[UILabel alloc] init];
                    label.translatesAutoresizingMaskIntoConstraints = NO;
                    label.numberOfLines = 0;
                    [view addSubview:label];
                    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[label]-(margin)-|"
                                                                                 options:(NSLayoutFormatOptions) 0
                                                                                 metrics:@{
                                                                                     @"margin": @16
                                                                                 }
                                                                                   views:@{
                                                                                       @"label": label
                                                                                   }]];
                    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                                 options:(NSLayoutFormatOptions) 0
                                                                                 metrics:nil
                                                                                   views:@{
                                                                                       @"label": label
                                                                                   }]];
                    label.text = @"Here is the UILabel";

                    return view;
                }()
            ]];
        }

        return cell;
    }

    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80.f;
    }

    return 0.f;
}

@end
