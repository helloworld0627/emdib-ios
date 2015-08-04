//
//  EMCommentListTableViewCell.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMCommentListTableViewCell.h"

@implementation EMCommentListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMode:(EMCommentListTableViewCellMode)mode {
    _mode = mode;
    BOOL hidden =(EMCommentListTableViewCellModeRead == mode);
    self.submitButton.hidden = hidden;
    self.cancelButton.hidden = hidden;
}

- (IBAction)submitComment:(id)sender {
    [self.delegate onCommentSubmitted];
    self.mode = EMCommentListTableViewCellModeRead;
}

- (IBAction)cancelComment:(id)sender {
    [self.delegate onCommentCancelled];
    self.mode = EMCommentListTableViewCellModeRead;
}

@end
