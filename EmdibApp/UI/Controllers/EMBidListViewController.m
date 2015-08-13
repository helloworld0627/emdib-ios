//
//  EMBidListViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMBidListViewController.h"
#import "EMAPIClient.h"
#import "EMBidListTableViewCell.h"
#import "EMBidDetailViewController.h"

@interface EMBidListViewController ()

@end

@implementation EMBidListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bids.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewCell = [self.bidListTableView dequeueReusableCellWithIdentifier:@"BidListItem" forIndexPath:indexPath];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BidListItem"];
    }

    EMBid* bid = self.bids[indexPath.row];
    EMBidListTableViewCell *bidListTableViewCell = (EMBidListTableViewCell*) tableViewCell;
    bidListTableViewCell.priceLabel.text = [[NSString alloc] initWithFormat:@"%.02f", bid.price.doubleValue];
    bidListTableViewCell.statusLabel.text = [[NSString alloc] initWithFormat:@"%@", [EMBid stringFromBidStatus:bid.status]];

    return bidListTableViewCell;
}

- (void)refreshTableView {
    [[EMAPIClient sharedAPIClient] fetchBidsAsSellerByAuctionId:self.auction.modelId
                                                   onCompletion:^(NSArray *bids, NSError *error) {
                                                       if(error) {
                                                           NSLog(@"%@", error.localizedDescription);
                                                           return;
                                                       }
                                                       self.bids = bids;
                                                       [self.bidListTableView reloadData];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"BidDetailSegue"]) {
        EMBidDetailViewController *bidDetailViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.bidListTableView indexPathForSelectedRow];
        bidDetailViewController.selectedBid = self.bids[indexPath.row];
    }
}

@end
