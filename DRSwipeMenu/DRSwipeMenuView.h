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
- (void)setRightMenuItemViews:(NSArray *)views;
- (void)setRightOpenHandleView:(UIView *)view;
- (void)setRightCloseHandleView:(UIView *)view;
- (void)revealRightMenuAnimated:(BOOL)animated;
- (void)closeMenuAnimated:(BOOL)animated;

@end
