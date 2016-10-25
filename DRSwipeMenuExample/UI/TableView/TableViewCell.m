//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "TableViewCell.h"
#import "TableViewCellMainView.h"
#import "DRSwipeMenuView.h"

@interface TableViewCell ()

@property (nonatomic, strong) DRSwipeMenuView *swipeMenuView;
@property (nonatomic, strong) TableViewCellMainView *mainView;

@end

@implementation TableViewCell

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.swipeMenuView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[swipeMenu]|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:nil
                                                                               views:@{
                                                                                   @"swipeMenu": self.swipeMenuView
                                                                               }]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[swipeMenu]|"
                                                                             options:(NSLayoutFormatOptions) 0
                                                                             metrics:nil
                                                                               views:@{
                                                                                   @"swipeMenu": self.swipeMenuView
                                                                               }]];
    [self.swipeMenuView setMainView:self.mainView];
    [self cleanUp];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self cleanUp];
}

- (void)cleanUp
{
    [self setCellText:nil];
    [self setLeftSwipeMenuViews:nil];
    [self setRightSwipeMenuViews:nil];
    [self.swipeMenuView closeMenuAnimated:NO];
}

#pragma mark - Public methods

- (void)setCellText:(NSString *)text
{
    self.mainView.textLabel.text = text;
}

- (void)setLeftSwipeMenuViews:(NSArray *)views
{
    if (views.count > 0) {
        __weak typeof(self) welf = self;
        [self.swipeMenuView setLeftOpenHandleView:^UIView *() {
            UIView *view = [[UIView alloc] init];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.contentMode = UIViewContentModeCenter;
            [view addSubview:imageView];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[imageView(width)]-(margin)-|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:@{
                                                                             @"margin" : @8,
                                                                             @"width" : @20
                                                                         }
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:nil
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:welf action:@selector(didTapLeftOpenHandle:)];
            [view addGestureRecognizer:tgr];
            return view;
        }()];
        [self.swipeMenuView setLeftCloseHandleView:^UIView *() {
            UIView *view = [[UIView alloc] init];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left"]];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.contentMode = UIViewContentModeCenter;
            [view addSubview:imageView];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[imageView(width)]-(margin)-|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:@{
                                                                             @"margin" : @8,
                                                                             @"width" : @20
                                                                         }
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:nil
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:welf action:@selector(didTapOnCloseHandle:)];
            [view addGestureRecognizer:tgr];
            return view;
        }()];
    }
    else {
        [self.swipeMenuView setLeftOpenHandleView:nil];
        [self.swipeMenuView setLeftCloseHandleView:nil];
    }

    [self.swipeMenuView setLeftMenuItemViews:views];
}

- (void)setRightSwipeMenuViews:(NSArray *)views
{
    if (views.count > 0) {
        __weak typeof(self) welf = self;
        [self.swipeMenuView setRightOpenHandleView:^UIView *() {
            UIView *view = [[UIView alloc] init];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_left"]];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.contentMode = UIViewContentModeCenter;
            [view addSubview:imageView];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[imageView(width)]-(margin)-|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:@{
                                                                             @"margin" : @8,
                                                                             @"width" : @20
                                                                         }
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:nil
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:welf action:@selector(didTapRightOpenHandle:)];
            [view addGestureRecognizer:tgr];
            return view;
        }()];
        [self.swipeMenuView setRightCloseHandleView:^UIView *() {
            UIView *view = [[UIView alloc] init];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
            imageView.translatesAutoresizingMaskIntoConstraints = NO;
            imageView.contentMode = UIViewContentModeCenter;
            [view addSubview:imageView];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[imageView(width)]-(margin)-|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:@{
                                                                             @"margin" : @8,
                                                                             @"width" : @20
                                                                         }
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                         options:(NSLayoutFormatOptions) 0
                                                                         metrics:nil
                                                                           views:@{
                                                                               @"imageView" : imageView
                                                                           }]];
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:welf action:@selector(didTapOnCloseHandle:)];
            [view addGestureRecognizer:tgr];
            return view;
        }()];
    }
    else {
        [self.swipeMenuView setRightOpenHandleView:nil];
        [self.swipeMenuView setRightCloseHandleView:nil];
    }

    [self.swipeMenuView setRightMenuItemViews:views];
}

#pragma mark - Subviews

- (TableViewCellMainView *)mainView
{
    if (!_mainView) {
        _mainView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCellMainView class]) owner:self options:nil].firstObject;
    }
    return _mainView;
}

- (DRSwipeMenuView *)swipeMenuView
{
    if (!_swipeMenuView) {
        _swipeMenuView = [[DRSwipeMenuView alloc] init];
        _swipeMenuView.translatesAutoresizingMaskIntoConstraints = NO;
        _swipeMenuView.menuBackgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        _swipeMenuView.shouldCloseByTapingOnMainView = YES;
    }
    return _swipeMenuView;
}

#pragma mark - UI actions

- (void)didTapLeftOpenHandle:(id)sender
{
    if ([self.swipeMenuView isMenuClosed]) {
        [self.swipeMenuView revealLeftMenuAnimated:YES];
    }
    else {
        [self.swipeMenuView closeMenuAnimated:YES];
    }
}

- (void)didTapRightOpenHandle:(id)sender
{
    if ([self.swipeMenuView isMenuClosed]) {
        [self.swipeMenuView revealRightMenuAnimated:YES];
    }
    else {
        [self.swipeMenuView closeMenuAnimated:YES];
    }
}

- (void)didTapOnCloseHandle:(id)sender
{
    [self.swipeMenuView closeMenuAnimated:YES];
}

@end
