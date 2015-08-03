//
//  EMCommentListViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMCommentListViewController.h"
#import "EMCommentListTableViewCell.h"
#import "EMAPIClient.h"

@interface EMCommentListViewController ()

@end

@implementation EMCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    EMComment *currentComment = [self.comments objectAtIndex:idx];

    UITableViewCell *tableViewCell = [self.commentListTableView dequeueReusableCellWithIdentifier:@"CommentListItem"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentListItem"];
    }

    EMCommentListTableViewCell *cell = (EMCommentListTableViewCell*)tableViewCell;
    cell.userNameLabel.text = currentComment.userId.stringValue;
    cell.commentTextView.text = currentComment.content;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
