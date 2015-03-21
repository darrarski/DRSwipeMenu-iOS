//
//  DRSwipeMenuView.m
//  DRSwipeMenu
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRSwipeMenuView.h"

@interface DRSwipeMenuView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *closedViewsContainer;
@property (nonatomic, strong) UIView *mainViewContainer;
@property (nonatomic, strong) UIView *openHandleViewContainer;
@property (nonatomic, strong) UIView *closeHandleViewContainer;
@property (nonatomic, strong) UIView *menuItemViewsContainer;

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

    self.menuItemViewsContainer.backgroundColor = menuBackgroundColor;
    self.closeHandleViewContainer.backgroundColor = menuBackgroundColor;
}

- (void)setMainView:(UIView *)view
{
    for (UIView *subview in self.mainViewContainer.subviews) {
        [subview removeFromSuperview];
    }

    if (!view) {
        return;
    }

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainViewContainer addSubview:view];
    [self.mainViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                                   options:(NSLayoutFormatOptions) 0
                                                                                   metrics:nil
                                                                                     views:@{
                                                                                         @"view": view
                                                                                     }]];
    [self.mainViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                                   options:(NSLayoutFormatOptions) 0
                                                                                   metrics:nil
                                                                                     views:@{
                                                                                         @"view": view
                                                                                     }]];
}

- (void)setMenuItemViews:(NSArray *)views
{
    for (UIView *subview in self.menuItemViewsContainer.subviews) {
        [subview removeFromSuperview];
    }

    for (UIView *view in views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.menuItemViewsContainer addSubview:view];
    }

    for (UIView *view in views) {
        [self.menuItemViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                                            options:(NSLayoutFormatOptions) 0
                                                                                            metrics:nil
                                                                                              views:@{
                                                                                                  @"view": view
                                                                                              }]];

        if ([view isEqual:views.firstObject]) {
            [self.menuItemViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]"
                                                                                                options:(NSLayoutFormatOptions) 0
                                                                                                metrics:nil
                                                                                                  views:@{
                                                                                                      @"view": view
                                                                                                  }]];
        }

        if ([view isEqual:views.lastObject]) {
            [self.menuItemViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]|"
                                                                                                options:(NSLayoutFormatOptions) 0
                                                                                                metrics:nil
                                                                                                  views:@{
                                                                                                      @"view": view
                                                                                                  }]];
        }
        else {
            [self.menuItemViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view][nextView]"
                                                                                                options:(NSLayoutFormatOptions) 0
                                                                                                metrics:nil
                                                                                                  views:@{
                                                                                                      @"view": view,
                                                                                                      @"nextView": views[[views indexOfObject:view] + 1]
                                                                                                  }]];
        }
    }
}

- (void)setOpenHandleView:(UIView *)view
{
    for (UIView *subview in self.openHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }

    if (!view) {
        return;
    }

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.openHandleViewContainer addSubview:view];
    [self.openHandleViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                                         options:(NSLayoutFormatOptions) 0
                                                                                         metrics:nil
                                                                                           views:@{
                                                                                               @"view": view
                                                                                           }]];
    [self.openHandleViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                                         options:(NSLayoutFormatOptions) 0
                                                                                         metrics:nil
                                                                                           views:@{
                                                                                               @"view": view
                                                                                           }]];
}

- (void)setCloseHandleView:(UIView *)view
{
    for (UIView *subview in self.closeHandleViewContainer.subviews) {
        [subview removeFromSuperview];
    }

    if (!view) {
        return;
    }

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.closeHandleViewContainer addSubview:view];
    [self.closeHandleViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                                          options:(NSLayoutFormatOptions) 0
                                                                                          metrics:nil
                                                                                            views:@{
                                                                                                @"view": view
                                                                                            }]];
    [self.closeHandleViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                                          options:(NSLayoutFormatOptions) 0
                                                                                          metrics:nil
                                                                                            views:@{
                                                                                                @"view": view
                                                                                            }]];
}

- (void)revealMenuAnimated:(BOOL)animated
{
    CGRect rect = (CGRect) {
        .origin.x = self.closeHandleViewContainer.frame.origin.x,
        .origin.y = 0,
        .size.width = MIN(self.scrollView.frame.size.width, self.closeHandleViewContainer.frame.size.width + self.menuItemViewsContainer.frame.size.width),
        .size.height = self.scrollView.frame.size.height
    };

    [self.scrollView scrollRectToVisible:rect
                                animated:animated];
}

- (void)closeMenuAnimated:(BOOL)animated
{
    CGRect rect = (CGRect) {
        .origin.x = 0,
        .origin.y = 0,
        .size.width = self.scrollView.frame.size.width,
        .size.height = self.scrollView.frame.size.height
    };

    [self.scrollView scrollRectToVisible:rect
                                animated:animated];
}

#pragma mark - Internals

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];

    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;

    [self setupSubviews];
}

- (void)setupSubviews
{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.closedViewsContainer];
    [self.closedViewsContainer addSubview:self.mainViewContainer];
    [self.closedViewsContainer addSubview:self.openHandleViewContainer];
    [self.scrollView addSubview:self.closeHandleViewContainer];
    [self.scrollView addSubview:self.menuItemViewsContainer];

    [self setupScrollViewConstraints];
    [self setupScrollViewSubviewsConstraints];
    [self setupClosedViewsContainerSubviewsConstraints];
}

- (void)setupScrollViewConstraints
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                 options:(NSLayoutFormatOptions) 0
                                                                 metrics:nil
                                                                   views:@{
                                                                       @"scrollView": self.scrollView
                                                                   }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                 options:(NSLayoutFormatOptions) 0
                                                                 metrics:nil
                                                                   views:@{
                                                                       @"scrollView": self.scrollView
                                                                   }]];
}

- (void)setupScrollViewSubviewsConstraints
{
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[closedView(==scrollView)][closeHandle][menu]|"
                                                                            options:(NSLayoutFormatOptions) 0
                                                                            metrics:nil
                                                                              views:@{
                                                                                  @"closedView": self.closedViewsContainer,
                                                                                  @"scrollView": self.scrollView,
                                                                                  @"closeHandle": self.closeHandleViewContainer,
                                                                                  @"menu": self.menuItemViewsContainer
                                                                              }]];

    for (UIView *subview in self.scrollView.subviews) {
        [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview(==container)]|"
                                                                                options:(NSLayoutFormatOptions) 0
                                                                                metrics:nil
                                                                                  views:@{
                                                                                      @"subview": subview,
                                                                                      @"container": self.scrollView
                                                                                  }]];
    }
}

- (void)setupClosedViewsContainerSubviewsConstraints
{
    [self.closedViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[main][openHandle]|"
                                                                                      options:(NSLayoutFormatOptions) 0
                                                                                      metrics:nil
                                                                                        views:@{
                                                                                            @"main": self.mainViewContainer,
                                                                                            @"openHandle": self.openHandleViewContainer
                                                                                        }]];

    for (UIView *subview in self.closedViewsContainer.subviews) {
        [self.closedViewsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                                          options:(NSLayoutFormatOptions) 0
                                                                                          metrics:nil
                                                                                            views:@{
                                                                                                @"subview": subview
                                                                                            }]];
    }

    NSLayoutConstraint *openHandleMinWidth = [NSLayoutConstraint constraintWithItem:self.openHandleViewContainer
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:nil
                                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                                         multiplier:1
                                                                           constant:0];
    openHandleMinWidth.priority = 251;
    [self.openHandleViewContainer addConstraint:openHandleMinWidth];
}

#pragma mark - Subviews

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
    }

    return _scrollView;
}

- (UIView *)closedViewsContainer
{
    if (!_closedViewsContainer) {
        _closedViewsContainer = [[UIView alloc] init];
        _closedViewsContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _closedViewsContainer.backgroundColor = [UIColor clearColor];
    }

    return _closedViewsContainer;
}

- (UIView *)mainViewContainer
{
    if (!_mainViewContainer) {
        _mainViewContainer = [[UIView alloc] init];
        _mainViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _mainViewContainer.backgroundColor = [UIColor clearColor];
    }

    return _mainViewContainer;
}

- (UIView *)openHandleViewContainer
{
    if (!_openHandleViewContainer) {
        _openHandleViewContainer = [[UIView alloc] init];
        _openHandleViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _openHandleViewContainer.backgroundColor = [UIColor clearColor];
    }

    return _openHandleViewContainer;
}

- (UIView *)closeHandleViewContainer
{
    if (!_closeHandleViewContainer) {
        _closeHandleViewContainer = [[UIView alloc] init];
        _closeHandleViewContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _closeHandleViewContainer.backgroundColor = self.menuBackgroundColor;
    }

    return _closeHandleViewContainer;
}

- (UIView *)menuItemViewsContainer
{
    if (!_menuItemViewsContainer) {
        _menuItemViewsContainer = [[UIView alloc] init];
        _menuItemViewsContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _menuItemViewsContainer.backgroundColor = self.menuBackgroundColor;
    }

    return _menuItemViewsContainer;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BOOL scrolledToEnd = ^BOOL() {
        if (scrollView.contentSize.width <= scrollView.frame.size.width) {
            return YES;
        }
        return scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.frame.size.width;
    }();

    BOOL scrolledMenu = ^BOOL() {
        if (scrollView.contentSize.width <= scrollView.frame.size.width) {
            return NO;
        }
        return scrollView.contentOffset.x > scrollView.frame.size.width;
    }();

    if (scrollView.pagingEnabled) {
        if (scrolledToEnd || scrolledMenu) {
            scrollView.pagingEnabled = NO;
        }
    }
    else {
        if (!scrolledToEnd && !scrolledMenu) {
            scrollView.pagingEnabled = YES;
        }
    }
}

@end
