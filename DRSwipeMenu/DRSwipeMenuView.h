//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `DRSwipeMenuView` contains customizable swipe menu.
 */
@interface DRSwipeMenuView : UIView

/**
 Background color of the menu.
 */
@property (nonatomic, strong) UIColor *menuBackgroundColor;

/**
 If set to `YES`, tapping on center view closes menu. This will block 
 user interactions with center view while menu is revealed.
 Default value is `NO`.
 */
@property (nonatomic, assign) BOOL shouldCloseByTapingOnMainView;

/**
 If set to `YES`, scrolling will be disabled during deceleration. This could 
 improve UX when embedding swipe menu in other scroll views (e.g. when adding 
 swipe menu to cells in table view). Default value is `NO`.
 */
@property (nonatomic, assign) BOOL shouldDisableScrollingWhileDecelerating;

/**
 Scroll deceleration rate. Use UIScrollViewDecelerationRateNormal or 
 UIScrollViewDecelerationRateFast.
 */
@property (nonatomic, assign) CGFloat scrollDeceleationRate;

/**
 Set the main view that should be displayed when menu is in its initial,
 closed state.

 @param view Main view
 */
- (void)setMainView:(UIView *)view;

/**
 Set left menu item views.
 
 @param views Array of UIView objects.
 */
- (void)setLeftMenuItemViews:(NSArray *)views;

/**
 Set right menu item views.

 @param views Array of UIView objects.
 */
- (void)setRightMenuItemViews:(NSArray *)views;

/**
 Set left open handle view. It will be added to the left side of main view and
 visible when swipe menu is not revealed.

 @param view Handle UIView
 */
- (void)setLeftOpenHandleView:(UIView *)view;

/**
 Set right open handle view. It will be added to the right side of main view and
 visible when swipe menu is not revealed.

 @param view Handle UIView
 */
- (void)setRightOpenHandleView:(UIView *)view;

/**
 Set left close handle view. It will be added to left menu view and visible when 
 left swipe menu is revealed. It will not be visible when menu is closed.

 @param view Handle UIView
 */
- (void)setLeftCloseHandleView:(UIView *)view;

/**
 Set right close handle view. It will be added to right menu view and 
 visible when right swipe menu is revealed. It will not be visible when 
 menu is closed.

 @param view Handle UIView
 */
- (void)setRightCloseHandleView:(UIView *)view;

/**
 Reveal left swipe menu.

 @param animated Perform with animation
 */
- (void)revealLeftMenuAnimated:(BOOL)animated;

/**
 Reveal right swipe menu.

 @param animated Perform with animation
 */
- (void)revealRightMenuAnimated:(BOOL)animated;

/**
 Bring menu back to initial, closed state. Left and right swipe menus will not
 be revealed.

 @param animated Perform with animation
 */
- (void)closeMenuAnimated:(BOOL)animated;

/**
 Check if left swipe menu is revealed.
 
 @return `YES` if left swipe menu is revealed
 */
- (BOOL)isLeftMenuRevealed;

/**
 Check if right swipe menu is revealed.

 @return `YES` if right swipe menu is revealed
 */
- (BOOL)isRightMenuRevealed;

/**
 Check if swipe menu is not revealed.

 @return `YES` if swipe menu is closed
 */
- (BOOL)isMenuClosed;

@end
