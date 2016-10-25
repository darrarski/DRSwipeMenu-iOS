//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRSwipeMenuView : UIView

@property (nonatomic, strong) UIColor *menuBackgroundColor;
@property (nonatomic, assign) BOOL shouldCloseByTapingOnMainView;
@property (nonatomic, assign) BOOL shouldDisableScrollingWhileDecelerating;

- (void)setMainView:(UIView *)view;
- (void)setLeftMenuItemViews:(NSArray *)views;
- (void)setRightMenuItemViews:(NSArray *)views;
- (void)setLeftOpenHandleView:(UIView *)view;
- (void)setRightOpenHandleView:(UIView *)view;
- (void)setLeftCloseHandleView:(UIView *)view;
- (void)setRightCloseHandleView:(UIView *)view;
- (void)revealLeftMenuAnimated:(BOOL)animated;
- (void)revealRightMenuAnimated:(BOOL)animated;
- (void)closeMenuAnimated:(BOOL)animated;
- (BOOL)isLeftMenuRevealed;
- (BOOL)isRightMenuRevealed;
- (BOOL)isMenuClosed;

@end
