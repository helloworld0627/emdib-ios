//
//  EMCommentListViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMCommentListViewController.h"
#import "EMAPIClient.h"

@interface EMCommentListViewController ()

@property (nonatomic, strong) EMComment *addComment;
@property (nonatomic) BOOL addCommentEnabled;

@end

@implementation EMCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma marks - setter

- (void)setAddCommentEnabled:(BOOL)addCommentEnabled {
    _addCommentEnabled = addCommentEnabled;
    self.navigationItem.rightBarButtonItem.enabled = !addCommentEnabled;
}


# pragma marks - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.comments.count;
    if (self.addCommentEnabled) {
        count = count + 1;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    UITableViewCell *tableViewCell = [self.commentListTableView dequeueReusableCellWithIdentifier:@"CommentListItem"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentListItem"];
    }

    EMCommentListTableViewCell *cell = (EMCommentListTableViewCell*)tableViewCell;
    cell.delegate = self;
    if (self.addCommentEnabled && idx == self.comments.count) {
        cell.userNameLabel.text = @"me";
        cell.mode = EMCommentListTableViewCellModeWrite;
        return cell;
    }

    EMComment *currentComment = [self.comments objectAtIndex:idx];
    cell.mode = EMCommentListTableViewCellModeRead;
    cell.userNameLabel.text = currentComment.userId.stringValue;
    cell.commentTextView.text = currentComment.content;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


# pragma marks - EMCommentListTableViewCellDelegate

- (void)onCommentSubmitted {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.comments.count inSection:0];
    UITableViewCell *tableViewCell = [self.commentListTableView cellForRowAtIndexPath:path];
    EMCommentListTableViewCell *cell = (EMCommentListTableViewCell*)tableViewCell;

    self.addComment.content = cell.commentTextView.text;
    self.addComment.auctionId = self.auction.modelId;
    self.addComment.userId = @1;

    [[EMAPIClient sharedAPIClient] createComment:self.addComment
                                    onCompletion:^(EMComment *comment, NSError *error) {
                                        if(error) {
                                            NSLog(@"%@", error.localizedDescription);
                                            return;
                                        }
                                        self.addCommentEnabled = NO;
                                        [self refreshTableView];
                                    }];
}

- (void)onCommentCancelled {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.comments.count inSection:0];
    NSArray *indexArray = [NSArray arrayWithObjects:path, nil];
    [self.commentListTableView beginUpdates];
    self.addComment = nil;
    self.addCommentEnabled = NO;
    [self.commentListTableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.commentListTableView endUpdates];
}


# pragma marks - others

- (IBAction)presentRightBarItemActionController:(id)sender {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.comments.count inSection:0];
    NSArray *indexArray = [NSArray arrayWithObjects:path,nil];
    [self.commentListTableView beginUpdates];

    self.addComment = [[EMComment alloc] init];
    self.addCommentEnabled = YES;

    [self.commentListTableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.commentListTableView endUpdates];
}

- (void)refreshTableView {
    [[EMAPIClient sharedAPIClient] fetchCommentsByAuctionId:self.auction.modelId
                                               onCompletion:^(NSArray *comments, NSError *error) {
                                                   if (error) {
                                                       NSLog(@"%@", error.localizedDescription);
                                                       return;
                                                   }
                                                   self.comments = comments;
                                                   [self.commentListTableView reloadData];
                                               }
     ];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
