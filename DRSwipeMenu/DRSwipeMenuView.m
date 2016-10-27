//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRSwipeMenuView.h"
#import "DRSwipeMenuScrollView.h"
#import "UIView+DRSwipeMenuAutolayout.h"

@interface DRSwipeMenuView () <UIScrollViewDelegate>

@property (nonatomic, weak) DRSwipeMenuScrollView *scrollView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) CGFloat lastScrolledOffset;

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

#pragma mark - Properties

- (CGFloat)scrollDecelerationRate
{
    return self.scrollView.decelerationRate;
}

- (void)setScrollDeceleationRate:(CGFloat)scrollDeceleationRate
{
    self.scrollView.decelerationRate = scrollDeceleationRate;
}

#pragma mark - Subviews

- (DRSwipeMenuScrollView *)scrollView
{
    if (!_scrollView) {
        DRSwipeMenuScrollView *scrollView = [[DRSwipeMenuScrollView alloc] init];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        [scrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
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
    self.scrollView.leftMenuItemViewsContainer.backgroundColor = self.menuBackgroundColor;
    self.scrollView.rightMenuItemViewsContainer.backgroundColor = self.menuBackgroundColor;
    self.scrollView.leftCloseHandleViewContainer.backgroundColor = self.menuBackgroundColor;
    self.scrollView.rightCloseHandleViewContainer.backgroundColor = self.menuBackgroundColor;
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
    self.scrollView.scrollEnabled = YES;
}

- (void)revealRightMenuAnimated:(BOOL)animated
{
    [self.scrollView scrollToRightMenuAnimated:animated];
    self.scrollView.scrollEnabled = YES;
}

- (void)closeMenuAnimated:(BOOL)animated
{
    [self.scrollView scrollToMainViewAnimated:animated];
    self.scrollView.scrollEnabled = YES;
}

- (BOOL)isLeftMenuRevealed
{
    return [self.scrollView isLeftMenuVisibleInRect:[self.scrollView visibleRect]];
}

- (BOOL)isRightMenuRevealed
{
    return [self.scrollView isRightMenuVisibleInRect:[self.scrollView visibleRect]];
}

- (BOOL)isMenuClosed
{
    return ![self isLeftMenuRevealed] && ![self isRightMenuRevealed];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.lastScrolledOffset = self.lastContentOffset - scrollView.contentOffset.x;
    self.lastContentOffset = scrollView.contentOffset.x;
    [self.scrollView setCloseByTappingMainViewEnabled:self.shouldCloseByTapingOnMainView && ![self isMenuClosed]];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    DRSwipeMenuScrollView *menuScrollView = (DRSwipeMenuScrollView *) scrollView;

    void (^openLeftMenu)() = ^{
        targetContentOffset->x = MAX(0, CGRectGetMaxX(menuScrollView.leftCloseHandleViewContainer.frame) - CGRectGetWidth(menuScrollView.frame));
    };

    void (^openRightMenu)() = ^{
        targetContentOffset->x = CGRectGetMinX(menuScrollView.rightCloseHandleViewContainer.frame);
        CGFloat rightMenuWidth = CGRectGetWidth(menuScrollView.rightCloseHandleViewContainer.frame) + CGRectGetWidth(menuScrollView.rightMenuItemViewsContainer.frame);
        CGFloat menuScrollViewWidth = CGRectGetWidth(menuScrollView.frame);
        if (rightMenuWidth < menuScrollViewWidth) {
            targetContentOffset->x -= menuScrollViewWidth - rightMenuWidth;
        }
    };

    void (^closeMenu)() = ^{
        targetContentOffset->x = CGRectGetMinX(menuScrollView.closedViewsContainer.frame);
    };

    CGRect targetRect = (CGRect) {
        .origin = CGPointMake(targetContentOffset->x, targetContentOffset->y),
        .size = menuScrollView.frame.size
    };

    if ([menuScrollView isClosedViewVisibleInRect:targetRect]) {
        if ([menuScrollView isLeftMenuVisibleInRect:targetRect]) {
            if (self.lastScrolledOffset > 0 && ![menuScrollView isRightMenuVisibleInRect:[menuScrollView visibleRect]]) {
                openLeftMenu();
            }
            else {
                closeMenu();
            }
        }
        else if ([menuScrollView isRightMenuVisibleInRect:targetRect]) {
            if (self.lastScrolledOffset < 0 && ![menuScrollView isLeftMenuVisibleInRect:[menuScrollView visibleRect]]) {
                openRightMenu();
            }
            else {
                closeMenu();
            }
        }
        else {
            closeMenu();
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.shouldDisableScrollingWhileDecelerating) {
        scrollView.scrollEnabled = NO;
    }    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.scrollEnabled = YES;
}

@end
