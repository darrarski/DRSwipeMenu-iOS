//
//  TableViewCell.m
//  DRSwipeMenuExample
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "TableViewCell.h"
#import "TableViewCellMainView.h"
#import "DRSwipeMenuView.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self cleanUp];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self cleanUp];
}

- (void)cleanUp
{
    self.mainView.textLabel.text = nil;
    [self.swipeMenu closeMenuAnimated:NO];
}

- (TableViewCellMainView *)mainView
{
    if (!_mainView) {
        TableViewCellMainView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCellMainView class]) owner:self options:nil].firstObject;
        [self.swipeMenu setMainView:view];
        _mainView = view;
    }

    return _mainView;
}

@end
