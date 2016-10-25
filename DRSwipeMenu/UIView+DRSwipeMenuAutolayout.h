//
// Created by Dariusz Rybicki on 24/04/15.
// Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Autolayout helpers
 */
@interface UIView (DRSwipeMenuAutolayout)

/**
 Add constraints to fill superview.
 */
- (void)autolayoutFillSuperview;

/**
 Add constraints to fill superview horizontally.
 */
- (void)autolayoutFillSuperviewHorizontally;

/**
 Add constraints to fill superview vertically.
 */
- (void)autolayoutFillSuperviewVertically;

/**
 Add constraints to pin left edge to superview.
 */
- (void)autolayoutPinLeftEdgeToSuperview;

/**
 Add constraints to pin right edge to superview.
 */
- (void)autolayoutPinRightEdgeToSuperview;

/**
 Add constraints to pin right edge to given view.
 
 @param view
 */
- (void)autolayoutPinRightEdgeToView:(UIView *)view;

/**
 Add constraints to fill horizontally with given subviews.
 
 @param subviews
 */
- (void)autolayoutFillHorizontallyWithSubviews:(NSArray *)subviews;

/**
 Add constraints to set width with given priority.
 
 @param width
 @param priority
 */
- (void)autolayoutSetWidth:(CGFloat)width priority:(UILayoutPriority)priority;

/**
 Add constraints to set subview's width to be equal to width of given view.
 
 @param subview
 @param view
 */
- (void)autolayoutSubview:(UIView *)subview setSameWidthAsView:(UIView *)view;

/**
 Add constraints to set subview's height to be equal to height of given view.

 @param subview
 @param view
 */
- (void)autolayoutSubview:(UIView *)subview setSameHeightAsView:(UIView *)view;

/**
 Add constraints to set subview's position and size to equal size and position
 of given view.
 
 @param subview
 @param view
 */
- (void)autolayoutSubview:(UIView *)subview setSamePositionAndSizeAsView:(UIView *)view;

@end
