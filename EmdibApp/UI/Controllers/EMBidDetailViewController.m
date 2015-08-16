//
//  EMBidDetailViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMBidDetailViewController.h"
#import "EMBidDetailPriceTableViewCell.h"
#import "EMBidDetailStatusTableViewCell.h"
#import "EMAPIClient.h"

static NSString * const IMAGE_CELL_ID = @"BidDetailImageCell";
static NSString * const PRICE_CELL_ID = @"BidDetailPriceCell";
static NSString * const STATUS_CELL_ID = @"BidDetailStatusCell";

@interface EMBidDetailViewController ()

@end

@implementation EMBidDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self class] cellIdentifiers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    NSString *cellIdentifier = [[self class] cellIdentifiers][idx];
    UITableViewCell *tableViewCell = nil;
    if ([cellIdentifier isEqualToString:IMAGE_CELL_ID]) {
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:IMAGE_CELL_ID];

    }else if ([cellIdentifier isEqualToString:PRICE_CELL_ID]) {
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:PRICE_CELL_ID];
        EMBidDetailPriceTableViewCell *cell = (EMBidDetailPriceTableViewCell*)tableViewCell;
        cell.priceLabel.text = [[NSString alloc] initWithFormat:@"%.02f", self.selectedBid.price.doubleValue];

    } else if ([cellIdentifier isEqualToString:STATUS_CELL_ID]) {
        tableViewCell = [tableView dequeueReusableCellWithIdentifier:STATUS_CELL_ID];
        EMBidDetailStatusTableViewCell *cell = (EMBidDetailStatusTableViewCell*)tableViewCell;
        cell.statusLabel.text = [EMBid stringFromBidStatus:self.selectedBid.status];
    }

    return tableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [[self class] cellIdentifiers][indexPath.row];
    if ([cellIdentifier isEqualToString:IMAGE_CELL_ID]) {
        return 120;
    } else {
        return 44;
    }
}

+ (NSArray*)cellIdentifiers {
    static NSArray *cellIdentifiers;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        cellIdentifiers = @[IMAGE_CELL_ID, PRICE_CELL_ID, STATUS_CELL_ID];
    });

    return cellIdentifiers;
}

- (IBAction)saveBid:(id)sender {
    [self updateBidFromTableView];
    self.selectedBid.status = BidStatusEndLose;
    [[EMAPIClient sharedAPIClient] setBidStatus:self.selectedBid.status
                                      auctionId:self.selectedBid.auctionId
                                          bidId:self.selectedBid.modelId
                                   onCompletion:^(EMBid *bid, NSError *error) {
                                       if (error) {
                                           NSLog(@"%@", error.localizedDescription);
                                           return;
                                       }
                                       [self.bidDetailTableView reloadData];
    }];
}

- (void)updateBidFromTableView {
    NSArray *cellIdentifiers = [[self class] cellIdentifiers];
    for (int i = 0; i < cellIdentifiers.count; i++) {
        NSString* cellIdentifier = cellIdentifiers[i];
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [self.bidDetailTableView cellForRowAtIndexPath:path];
        if ([cellIdentifier isEqualToString:PRICE_CELL_ID]) {
            EMBidDetailPriceTableViewCell *priceCell = (EMBidDetailPriceTableViewCell*)cell;
            self.selectedBid.price = [[NSNumber alloc] initWithDouble: priceCell.priceLabel.text.doubleValue];

        } else if ([cellIdentifier isEqualToString:STATUS_CELL_ID]) {
            EMBidDetailStatusTableViewCell *statusCell = (EMBidDetailStatusTableViewCell*)cell;
            self.selectedBid.status = [EMBid bidStatusFromString:statusCell.statusLabel.text];
        }
    }
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
