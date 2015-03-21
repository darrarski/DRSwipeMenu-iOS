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

@property (weak, nonatomic) IBOutlet DRSwipeMenuView *swipeMenu;
@property (weak, nonatomic) TableViewCellMainView *mainView;

@end
