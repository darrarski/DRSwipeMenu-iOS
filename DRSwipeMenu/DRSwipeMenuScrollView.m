//
// Created by Dariusz Rybicki on 24/04/15.
// Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "DRSwipeMenuScrollView.h"
#import "UIView+DRSwipeMenuAutolayout.h"

@interface DRSwipeMenuScrollView ()

@property (nonatomic, weak) UIView *closedViewsContainer;
@property (nonatomic, weak) UIView *mainViewContainer;
@property (nonatomic, weak) UIView *leftOpenHandleViewContainer;
@property (nonatomic, weak) UIView *rightOpenHandleViewContainer;
@property (nonatomic, weak) UIView *leftCloseHandleViewContainer;
@property (nonatomic, weak) UIView *rightCloseHandleViewContainer;
@property (nonatomic, weak) UIView *leftMenuItemViewsContainer;
@property (nonatomic, weak) UIView *rightMenuItemViewsContainer;

@end

@implementation DRSwipeMenuScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize contentSizeBefore = self.contentSize;
    [super layoutSubviews];

    if (CGSizeEqualToSize(contentSizeBefore, CGSizeZero)) {
        [self scrollToMainViewAnimated:NO];
    }
}

#pragma mark - Initialization

- (void)commonInit
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;

    [self setupSubviews];
}

- (void)setupSubviews
{
    [self addSubview:self.leftMenuItemViewsContainer];
    [self addSubview:self.leftCloseHandleViewContainer];
    [self addSubview:self.closedViewsContainer];
    [self.closedViewsContainer addSubview:self.leftOpenHandleViewContainer];
    [self.closedViewsContainer addSubview:self.mainViewContainer];
    [self.closedViewsContainer addSubview:self.rightOpenHandleViewContainer];
    [self addSubview:self.rightCloseHandleViewContainer];
    [self addSubview:self.rightMenuItemViewsContainer];

    [self setupSubviewsConstraints];
    [self setupClosedViewsContainerSubviewsConstraints];
}

- (void)setupSubviewsConstraints
{
    [self autolayoutFillHorizontallyWithSubviews:@[
        self.leftMenuItemViewsContainer,
        self.leftCloseHandleViewContainer,
        self.closedViewsContainer,
        self.rightCloseHandleViewContainer,
        self.rightMenuItemViewsContainer
    ]];
    [self autolayoutSubview:self.closedViewsContainer setSameWidthAsView:self];
    for (UIView *subview in self.subviews) {
        [subview autolayoutFillSuperviewVertically];
        [self autolayoutSubview:subview setSameHeightAsView:self];
    }
}

- (void)setupClosedViewsContainerSubviewsConstraints
{
    [self.closedViewsContainer autolayoutFillHorizontallyWithSubviews:@[
        self.leftOpenHandleViewContainer,
        self.mainViewContainer,
        self.rightOpenHandleViewContainer
    ]];
    for (UIView *subview in self.closedViewsContainer.subviews) {
        [subview autolayoutFillSuperviewVertically];
    }
    [self.rightOpenHandleViewContainer autolayoutSetWidth:0 priority:749];
    [self.leftOpenHandleViewContainer autolayoutSetWidth:0 priority:749];
}

#pragma mark - Reveal / Close actions

- (void)scrollToLeftMenuAnimated:(BOOL)animated
{
    CGRect rect = (CGRect) {
        .origin.x = 0,
        .origin.y = 0,
        .size.width = self.leftCloseHandleViewContainer.frame.size.width + self.leftMenuItemViewsContainer.frame.size.width,
        .size.height = self.frame.size.height
    };
    CGFloat offset = rect.size.width - self.frame.size.width;
    if (offset > 0) {
        rect.origin.x += offset;
        rect.size.width = self.frame.size.width;
    }

    [self scrollRectToVisible:rect
                     animated:animated];
}

- (void)scrollToRightMenuAnimated:(BOOL)animated
{
    CGRect rect = (CGRect) {
        .origin.x = self.rightCloseHandleViewContainer.frame.origin.x,
        .origin.y = 0,
        .size.width = MIN(self.frame.size.width, self.rightCloseHandleViewContainer.frame.size.width + self.rightMenuItemViewsContainer.frame.size.width),
        .size.height = self.frame.size.height
    };

    [self scrollRectToVisible:rect
                     animated:animated];
}

- (void)scrollToMainViewAnimated:(BOOL)animated
{
    [self scrollRectToVisible:self.closedViewsContainer.frame
                     animated:animated];
}

#pragma mark - Subviews visibility

- (BOOL)isClosedViewVisibleInRect:(CGRect)rect
{
    return CGRectIntersectsRect(self.closedViewsContainer.frame, rect);
}

- (BOOL)isLeftMenuVisibleInRect:(CGRect)rect
{
    return CGRectGetMinX(rect) < CGRectGetMaxX(self.leftCloseHandleViewContainer.frame);
}

- (BOOL)isRightMenuVisibleInRect:(CGRect)rect
{
    return CGRectGetMaxX(rect) > CGRectGetMinX(self.rightCloseHandleViewContainer.frame);
}

#pragma mark - Subviews lazy loading

- (UIView *)closedViewsContainer
{
    if (!_closedViewsContainer) {
        _closedViewsContainer = [self createAndAddSubview];
    }
    return _closedViewsContainer;
}

- (UIView *)mainViewContainer
{
    if (!_mainViewContainer) {
        _mainViewContainer = [self createAndAddSubview];
    }
    return _mainViewContainer;
}

- (UIView *)leftOpenHandleViewContainer
{
    if (!_leftOpenHandleViewContainer) {
        _leftOpenHandleViewContainer = [self createAndAddSubview];
    }
    return _leftOpenHandleViewContainer;
}

- (UIView *)rightOpenHandleViewContainer
{
    if (!_rightOpenHandleViewContainer) {
        _rightOpenHandleViewContainer = [self createAndAddSubview];
    }
    return _rightOpenHandleViewContainer;
}

- (UIView *)leftCloseHandleViewContainer
{
    if (!_leftCloseHandleViewContainer) {
        _leftCloseHandleViewContainer = [self createAndAddSubview];
    }
    return _leftCloseHandleViewContainer;
}

- (UIView *)rightCloseHandleViewContainer
{
    if (!_rightCloseHandleViewContainer) {
        _rightCloseHandleViewContainer = [self createAndAddSubview];
    }
    return _rightCloseHandleViewContainer;
}

- (UIView *)leftMenuItemViewsContainer
{
    if (!_leftMenuItemViewsContainer) {
        _leftMenuItemViewsContainer = [self createAndAddSubview];
    }
    return _leftMenuItemViewsContainer;
}

- (UIView *)rightMenuItemViewsContainer
{
    if (!_rightMenuItemViewsContainer) {
        _rightMenuItemViewsContainer = [self createAndAddSubview];
    }
    return _rightMenuItemViewsContainer;
}

- (UIView *)createAndAddSubview
{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    return view;
}

@end
