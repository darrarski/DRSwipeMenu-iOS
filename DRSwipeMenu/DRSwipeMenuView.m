//
//  DRSwipeMenuView.m
//  DRSwipeMenu
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRSwipeMenuView.h"
#import "DRSwipeMenuScrollView.h"
#import "UIView+DRSwipeMenuAutolayout.h"

@interface DRSwipeMenuView () <UIScrollViewDelegate>

@property (nonatomic, weak) DRSwipeMenuScrollView *scrollView;

@end

@implementation DRSwipeMenuView {
    UIColor *_menuBackgroundColor;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    [self.scrollView autolayoutFillSuperview];
}

#pragma mark - Subviews

- (DRSwipeMenuScrollView *)scrollView
{
    if (!_scrollView) {
        DRSwipeMenuScrollView *scrollView = [[DRSwipeMenuScrollView alloc] init];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - Public methods

- (UIColor *)menuBackgroundColor
{
    if (!_menuBackgroundColor) {
        _menuBackgroundColor = [UIColor clearColor];
    }
    return _menuBackgroundColor;
}

- (void)setMenuBackgroundColor:(UIColor *)menuBackgroundColor
{
    _menuBackgroundColor = menuBackgroundColor;
    self.scrollView.leftMenuItemViewsContainer.backgroundColor = menuBackgroundColor;
    self.scrollView.rightMenuItemViewsContainer.backgroundColor = menuBackgroundColor;
    self.scrollView.leftCloseHandleViewContainer.backgroundColor = menuBackgroundColor;
    self.scrollView.rightCloseHandleViewContainer.backgroundColor = menuBackgroundColor;
}

- (void)setMainView:(UIView *)view
{
    for (UIView *subview in self.scrollView.mainViewContainer.subviews) {
        [subview removeFromSuperview];
    }
    if (!view) return;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.mainViewContainer addSubview:view];
    [view autolayoutFillSuperview];
}

- (void)setLeftMenuItemViews:(NSArray *)views
{
    for (UIView *subview in self.scrollView.leftMenuItemViewsContainer.subviews) {
        [subview removeFromSuperview];
    }
    for (UIView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView.leftMenuItemViewsContainer addSubview:view];
    }
    for (UIView *view in views) {
        [view autolayoutFillSuperviewVertically];
        if ([view isEqual:views.firstObject]) {
            [view autolayoutPinLeftEdgeToSuperview];
        }
        if ([view isEqual:views.lastObject]) {
            [view autolayoutPinRightEdgeToSuperview];
        }
        else {
            [view autolayoutPinRightEdgeToView:views[[views indexOfObject:view] + 1]];
        }
    }
}

- (void)setRightMenuItemViews:(NSArray *)views
{
    for (UIView *subview in self.scrollView.rightMenuItemViewsContainer.subviews) {
        [subview removeFromSuperview];
    }
    for (UIView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.scrollView.rightMenuItemViewsContainer addSubview:view];
    }
    for (UIView *view in views) {
        [view autolayoutFillSuperviewVertically];
        if ([view isEqual:views.firstObject]) {
            [view autolayoutPinLeftEdgeToSuperview];
        }
        if ([view isEqual:views.lastObject]) {
            [view autolayoutPinRightEdgeToSuperview];
        }
        else {
            [view autolayoutPinRightEdgeToView:views[[views indexOfObject:view] + 1]];
        }
    }
}

- (void)setLeftOpenHandleView:(UIView *)view
{
    for (UIView *subview in self.scrollView.leftOpenHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }
    if (!view) return;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.leftOpenHandleViewContainer addSubview:view];
    [view autolayoutFillSuperview];
}

- (void)setRightOpenHandleView:(UIView *)view
{
    for (UIView *subview in self.scrollView.rightOpenHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }
    if (!view) return;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.rightOpenHandleViewContainer addSubview:view];
    [view autolayoutFillSuperview];
}

- (void)setLeftCloseHandleView:(UIView *)view
{
    for (UIView *subview in self.scrollView.leftCloseHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }
    if (!view) return;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.leftCloseHandleViewContainer addSubview:view];
    [view autolayoutFillSuperview];
}

- (void)setRightCloseHandleView:(UIView *)view
{
    for (UIView *subview in self.scrollView.rightCloseHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }
    if (!view) return;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView.rightCloseHandleViewContainer addSubview:view];
    [view autolayoutFillSuperview];
}

- (void)revealLeftMenuAnimated:(BOOL)animated
{
    [self.scrollView scrollToLeftMenuAnimated:animated];
}

- (void)revealRightMenuAnimated:(BOOL)animated
{
    [self.scrollView scrollToRightMenuAnimated:animated];
}

- (void)closeMenuAnimated:(BOOL)animated
{
    [self.scrollView scrollToMainViewAnimated:animated];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // TODO: custom paging implementation

//    BOOL scrolledToEnd = ^BOOL() {
//        if (scrollView.contentSize.width <= scrollView.frame.size.width) {
//            return YES;
//        }
//        BOOL scrolledToLeftEnd = scrollView.contentOffset.x <= 0;
//        BOOL scrolledToRightEnd = scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.frame.size.width;
//        return scrolledToLeftEnd || scrolledToRightEnd;
//    }();
//
//    BOOL scrolledCenterView = ^BOOL() {
//        CGRect visibleRect = (CGRect) {
//            .origin = self.scrollView.contentOffset,
//            .size = self.scrollView.frame.size
//        };
//        return CGRectIntersectsRect(self.scrollView.closedViewsContainer.frame, visibleRect);
//    }();
//
//    if (scrollView.pagingEnabled) {
//        if (scrolledToEnd || !scrolledCenterView) {
//            scrollView.pagingEnabled = NO;
//        }
//    }
//    else {
//        if (!scrolledToEnd && scrolledCenterView) {
//            scrollView.pagingEnabled = YES;
//        }
//    }
}

@end
