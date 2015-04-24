//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

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
        return 7;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];

        if (indexPath.row == 0) {
            [cell setCellText:@"Cell with swipe menu that contains one button"];
            [cell setRightSwipeMenuViews:[self createButtonViewsWithStartIndex:0 count:1]];
        }
        else if (indexPath.row == 1) {
            [cell setCellText:@"Cell with swipe menu that contains several buttons"];
            [cell setRightSwipeMenuViews:[self createButtonViewsWithStartIndex:1 count:3]];
        }
        else if (indexPath.row == 2) {
            [cell setCellText:@"Cell with swipe menu that contains many buttons"];
            [cell setRightSwipeMenuViews:[self createButtonViewsWithStartIndex:4 count:6]];
        }
        if (indexPath.row == 3) {
            [cell setCellText:@"Cell with swipe menu that contains custom view with text label"];
            [cell setRightSwipeMenuViews:@[
                ^UIView *() {
                    UIView *view = [[UIView alloc] init];
                    UILabel *label = [[UILabel alloc] init];
                    label.translatesAutoresizingMaskIntoConstraints = NO;
                    label.numberOfLines = 0;
                    [view addSubview:label];
                    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[label]-(margin)-|"
                                                                                 options:(NSLayoutFormatOptions) 0
                                                                                 metrics:@{
                                                                                     @"margin" : @16
                                                                                 }
                                                                                   views:@{
                                                                                       @"label" : label
                                                                                   }]];
                    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                                 options:(NSLayoutFormatOptions) 0
                                                                                 metrics:nil
                                                                                   views:@{
                                                                                       @"label" : label
                                                                                   }]];
                    label.text = @"Here is the UILabel";

                    return view;
                }()
            ]];
        }
        else if (indexPath.row == 4) {
            [cell setCellText:@"Cell with left swipe menu"];
            [cell setLeftSwipeMenuViews:[self createButtonViewsWithStartIndex:0 count:2]];
        }
        else if (indexPath.row == 5) {
            [cell setCellText:@"Cell with left and right swipe menu (several items)"];
            [cell setLeftSwipeMenuViews:[self createButtonViewsWithStartIndex:0 count:1]];
            [cell setRightSwipeMenuViews:[self createButtonViewsWithStartIndex:1 count:2]];
        }
        else if (indexPath.row == 6) {
            [cell setCellText:@"Cell with left and right swipe menu (many items)"];
            [cell setLeftSwipeMenuViews:[self createButtonViewsWithStartIndex:0 count:10]];
            [cell setRightSwipeMenuViews:[self createButtonViewsWithStartIndex:0 count:10]];
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

#pragma mark - Helpers

- (NSArray *)createButtonViewsWithStartIndex:(NSUInteger)startIdx count:(NSUInteger)count
{
    NSMutableArray *views = [NSMutableArray new];

    for (NSUInteger idx = 0; idx < count; idx++) {
        NSUInteger iconIdx = (startIdx + idx) % 10;
        [views addObject:^UIView *() {
            UIButton *button = [[UIButton alloc] init];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%lu", (long unsigned)iconIdx]];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [button setImage:image forState:UIControlStateNormal];
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
            return button;
        }()];
    }

    return [views copy];
}

@end
