//
//  TableViewCell.m
//  DRSwipeMenuExample
//
//  Created by Dariusz Rybicki on 21/03/15.
//  Copyright (c) 2015 Darrarski. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self cleanUp];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self cleanUp];
}

- (void)cleanUp
{
    self.cellLabel.text = nil;
}

@end
