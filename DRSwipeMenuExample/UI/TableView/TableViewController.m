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

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:CellReuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];

        cell.mainView.textLabel.text = [NSString stringWithFormat:@"Example cell %lu", (long)indexPath.row+1];

        cell.swipeMenu.menuBackgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];

        NSMutableArray *menuItemViews = [NSMutableArray new];

        for (int i = 1; i <= indexPath.row + 1; i++) {
            [menuItemViews addObject:^UIView *() {
                UIButton *button = [[UIButton alloc] init];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%d", i]] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

                return button;
            }()];
        }

        [cell.swipeMenu setMenuItemViews:[menuItemViews copy]];

        return cell;
    }

    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70.f;
    }

    return 0.f;
}

@end
