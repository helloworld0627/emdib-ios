//
//  EMAuctionDetailTitleTableViewCell.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAuctionDetailTitleTableViewCell.h"

@implementation EMAuctionDetailTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.titleTextView.textContainer.maximumNumberOfLines = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
