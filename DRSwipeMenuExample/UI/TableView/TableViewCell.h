//
//  TableViewCell.h
//  DRSwipeMenuExample
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRSwipeMenuView;
@class TableViewCellMainView;

@interface TableViewCell : UITableViewCell

@property (nonatomic, readonly) DRSwipeMenuView *swipeMenuView;
@property (nonatomic, readonly) TableViewCellMainView *mainView;

@end
