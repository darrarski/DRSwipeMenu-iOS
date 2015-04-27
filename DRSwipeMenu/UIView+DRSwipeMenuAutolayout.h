//
// Created by Dariusz Rybicki on 24/04/15.
// Copyright (c) 2015 Darrarski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DRSwipeMenuAutolayout)

- (void)autolayoutFillSuperview;
- (void)autolayoutFillSuperviewHorizontally;
- (void)autolayoutFillSuperviewVertically;
- (void)autolayoutPinLeftEdgeToSuperview;
- (void)autolayoutPinRightEdgeToSuperview;
- (void)autolayoutPinRightEdgeToView:(UIView *)view;
- (void)autolayoutFillHorizontallyWithSubviews:(NSArray *)subviews;
- (void)autolayoutSetWidth:(CGFloat)width priority:(UILayoutPriority)priority;
- (void)autolayoutSubview:(UIView *)subview setSameWidthAsView:(UIView *)view;
- (void)autolayoutSubview:(UIView *)subview setSameHeightAsView:(UIView *)view;
- (void)autolayoutSubview:(UIView *)subview setSamePositionAndSizeAsView:(UIView *)view;

@end
