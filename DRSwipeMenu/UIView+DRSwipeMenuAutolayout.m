//
// Created by Dariusz Rybicki on 24/04/15.
// Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "UIView+DRSwipeMenuAutolayout.h"

@implementation UIView (DRSwipeMenuAutolayout)

- (void)autolayoutFillSuperview
{
    [self autolayoutFillSuperviewHorizontally];
    [self autolayoutFillSuperviewVertically];
}

- (void)autolayoutFillSuperviewHorizontally
{
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|"
                                                                           options:(NSLayoutFormatOptions) 0
                                                                           metrics:nil
                                                                             views:@{ @"self": self }]];
}

- (void)autolayoutFillSuperviewVertically
{
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|"
                                                                           options:(NSLayoutFormatOptions) 0
                                                                           metrics:nil
                                                                             views:@{ @"self": self }]];
}

- (void)autolayoutPinLeftEdgeToSuperview
{
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]"
                                                                           options:(NSLayoutFormatOptions) 0
                                                                           metrics:nil
                                                                             views:@{ @"self": self }]];
}

- (void)autolayoutPinRightEdgeToSuperview
{
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]|"
                                                                           options:(NSLayoutFormatOptions) 0
                                                                           metrics:nil
                                                                             views:@{ @"self": self }]];
}

- (void)autolayoutPinRightEdgeToView:(UIView *)view
{
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self][view]"
                                                                           options:(NSLayoutFormatOptions) 0
                                                                           metrics:nil
                                                                             views:@{
                                                                                 @"self": self,
                                                                                 @"view": view
                                                                             }]];
}

- (void)autolayoutFillHorizontallyWithSubviews:(NSArray *)subviews
{
    NSMutableDictionary *views = [NSMutableDictionary new];
    NSMutableString *format = [NSMutableString new];
    [format appendString:@"H:|"];
    [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSString *viewName = [NSString stringWithFormat:@"view%lu", (unsigned long)idx];
        views[viewName] = view;
        [format appendFormat:@"[%@]", viewName];
    }];
    [format appendString:@"|"];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[format copy]
                                                                 options:(NSLayoutFormatOptions) 0
                                                                 metrics:nil
                                                                   views:[views copy]]];
}

- (void)autolayoutSetWidth:(CGFloat)width priority:(UILayoutPriority)priority
{
    NSLayoutConstraint *constant = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:width];
    constant.priority = priority;
    [self addConstraint:constant];
}

- (void)autolayoutSubview:(UIView *)subview setSameWidthAsView:(UIView *)view
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[subview(==view)]"
                                                                 options:(NSLayoutFormatOptions) 0
                                                                 metrics:nil
                                                                   views:@{
                                                                       @"subview": subview,
                                                                       @"view": view
                                                                   }]];
}

- (void)autolayoutSubview:(UIView *)subview setSameHeightAsView:(UIView *)view
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview(==view)]"
                                                                 options:(NSLayoutFormatOptions) 0
                                                                 metrics:nil
                                                                   views:@{
                                                                       @"subview": subview,
                                                                       @"view": view
                                                                   }]];
}

@end
