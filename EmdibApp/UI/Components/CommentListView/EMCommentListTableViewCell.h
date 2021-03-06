//
//  EMCommentListTableViewCell.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EMCommentListTableViewCellModeRead,
    EMCommentListTableViewCellModeWrite
} EMCommentListTableViewCellMode;

@protocol EMCommentListTableViewCellDelegate

- (void)onCommentSubmitted;
- (void)onCommentCancelled;

@end

@interface EMCommentListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic)EMCommentListTableViewCellMode mode;
@property (weak, nonatomic) id<EMCommentListTableViewCellDelegate> delegate;

@end
