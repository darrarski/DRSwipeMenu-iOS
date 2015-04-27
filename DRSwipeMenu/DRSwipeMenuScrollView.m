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
@property (nonatomic, weak) UIView *mainViewCover;

@end

@implementation DRSwipeMenuScrollView {
    CGSize _lastContentSize;
    CGPoint _lastContentOffset;
    CGPoint _lastClosedViewsContainerOrigin;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (CGSizeEqualToSize(_lastContentSize, CGSizeZero)) {
        self.contentOffset = self.closedViewsContainer.frame.origin;
        [super layoutSubviews];
    }
    else if (_lastContentSize.width != self.contentSize.width) {
        if (CGPointEqualToPoint(_lastContentOffset, _lastClosedViewsContainerOrigin)) {
            self.contentOffset = self.closedViewsContainer.frame.origin;
        }
        else {
            CGPoint contentOffset = self.contentOffset;
            contentOffset.x = _lastContentOffset.x;
            if (!CGPointEqualToPoint(_lastClosedViewsContainerOrigin, self.closedViewsContainer.frame.origin)) {
                contentOffset.x += self.closedViewsContainer.frame.origin.x - _lastClosedViewsContainerOrigin.x;
            }
            contentOffset.x = MAX(0, MIN(self.contentSize.width - self.frame.size.width, contentOffset.x));
            self.contentOffset = contentOffset;
        }
        [super layoutSubviews];
    }

    _lastContentSize = self.contentSize;
    _lastContentOffset = self.contentOffset;
    _lastClosedViewsContainerOrigin = self.closedViewsContainer.frame.origin;
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
    [self.mainViewCover.superview autolayoutSubview:self.mainViewCover
                       setSamePositionAndSizeAsView:self.mainViewContainer];
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

    if (animated) {
        [self scrollRectToVisible:rect animated:YES];
    }
    else {
        self.contentOffset = rect.origin;
    }
}

- (void)scrollToRightMenuAnimated:(BOOL)animated
{
    CGRect rect = (CGRect) {
        .origin.x = self.rightCloseHandleViewContainer.frame.origin.x,
        .origin.y = 0,
        .size.width = MIN(self.frame.size.width, self.rightCloseHandleViewContainer.frame.size.width + self.rightMenuItemViewsContainer.frame.size.width),
        .size.height = self.frame.size.height
    };
    CGFloat offset = rect.size.width - self.frame.size.width;
    if (offset > 0) {
        rect.origin.x -= offset;
        rect.size.width = self.frame.size.width;
    }

    if (animated) {
        [self scrollRectToVisible:rect animated:YES];
    }
    else {
        self.contentOffset = rect.origin;
    }
}

- (void)scrollToMainViewAnimated:(BOOL)animated
{
    if (animated) {
        [self scrollRectToVisible:self.closedViewsContainer.frame animated:YES];
    }
    else {
        self.contentOffset = self.closedViewsContainer.frame.origin;
    }
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

- (CGRect)visibleRect
{
    return (CGRect) {
        .origin = self.contentOffset,
        .size = self.frame.size
    };
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

- (UIView *)mainViewCover
{
    if (!_mainViewCover) {
        _mainViewCover = [self createAndAddSubview];
        _mainViewCover.userInteractionEnabled = NO;
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainViewCoverTapAction:)];
        [_mainViewCover addGestureRecognizer:tgr];
    }
    return _mainViewCover;
}

- (UIView *)createAndAddSubview
{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    return view;
}

#pragma mark -

- (void)setCloseByTappingMainViewEnabled:(BOOL)enabled
{
    self.mainViewCover.userInteractionEnabled = enabled;
}

- (void)mainViewCoverTapAction:(id)sender
{
    [self scrollToMainViewAnimated:YES];
}

@end
