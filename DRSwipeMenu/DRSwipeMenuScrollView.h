//
// Created by Dariusz Rybicki on 24/04/15.
// Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIkit.h>

/**
 `UIScrollView` subclass that implements swipe menu.
 */
@interface DRSwipeMenuScrollView : UIScrollView

/**
 Container for closed views (visible in initial, closed state).
 */
@property (nonatomic, weak, readonly) UIView *closedViewsContainer;

/**
 Container for main view (center view, visible in closed state).
 */
@property (nonatomic, weak, readonly) UIView *mainViewContainer;

/**
 Container for left open handle view (visible in closed state).
 */
@property (nonatomic, weak, readonly) UIView *leftOpenHandleViewContainer;

/**
 Container for right open handle view (visible in closed state).
 */
@property (nonatomic, weak, readonly) UIView *rightOpenHandleViewContainer;

/**
 Container for left close handle view (visible in revealed state).
 */
@property (nonatomic, weak, readonly) UIView *leftCloseHandleViewContainer;

/**
 Container for right close handle view (visible in revealed state).
 */
@property (nonatomic, weak, readonly) UIView *rightCloseHandleViewContainer;

/**
 Container for left menu item views.
 */
@property (nonatomic, weak, readonly) UIView *leftMenuItemViewsContainer;

/**
 Container for right menu ites views.
 */
@property (nonatomic, weak, readonly) UIView *rightMenuItemViewsContainer;

/**
 Reveal left menu.
 
 @param animated Perform with animation
 */
- (void)scrollToLeftMenuAnimated:(BOOL)animated;

/**
 Reveal right menu.

 @param animated Perform with animation
 */
- (void)scrollToRightMenuAnimated:(BOOL)animated;

/**
 Bring menu back to closed state.

 @param animated Perform with animation
 */
- (void)scrollToMainViewAnimated:(BOOL)animated;

/**
 Check if closed view is visible in given rect.
 
 @param rect
 */
- (BOOL)isClosedViewVisibleInRect:(CGRect)rect;

/**
 Check if left menu view is visible in given rect.

 @param rect
 */
- (BOOL)isLeftMenuVisibleInRect:(CGRect)rect;

/**
 Check if right menu view is visible in given rect.

 @param rect
 */
- (BOOL)isRightMenuVisibleInRect:(CGRect)rect;

/**
 Get current visible rect.

 @param rect
 */
- (CGRect)visibleRect;

/**
 Set if menu should close when taping on main view (works only when
 menu is revealed)
 
 @param enabled
 */
- (void)setCloseByTappingMainViewEnabled:(BOOL)enabled;

@end
