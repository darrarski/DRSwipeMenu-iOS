//
//  DRSwipeMenuView.h
//  DRSwipeMenu
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRSwipeMenuView : UIView

@property (nonatomic, strong) UIColor *menuBackgroundColor;

- (void)setMainView:(UIView *)view;
- (void)setMenuItemViews:(NSArray *)views;
- (void)setOpenHandleView:(UIView *)view;
- (void)setCloseHandleView:(UIView *)view;
- (void)revealMenuAnimated:(BOOL)animated;
- (void)closeMenuAnimated:(BOOL)animated;

@end
