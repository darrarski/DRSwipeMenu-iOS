//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRSwipeMenuView;
@class TableViewCellMainView;

@interface TableViewCell : UITableViewCell

- (void)setCellText:(NSString *)text;
- (void)setLeftSwipeMenuViews:(NSArray *)views;
- (void)setRightSwipeMenuViews:(NSArray *)views;

@end
