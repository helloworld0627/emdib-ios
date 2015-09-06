//
//  EMAuctionListViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/18/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAuctionListViewController.h"
#import "EMAuctionListTableViewCell.h"
#import "EMAuctionDetailViewController.h"
#import "EMAPIClient.h"

@interface EMAuctionListViewController ()

@property (nonatomic, strong) NSArray *auctions;
@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;

@end

@implementation EMAuctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMAPIClient sharedAPIClient] fetchAllCategoriesOnCompletion:^(NSArray *categories, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        self.categories = categories;
    }];
    [[EMAPIClient sharedAPIClient] fetchAuctionsAsSellerOnCompletion:^(NSArray *auctions, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        self.auctions = auctions;
        [self.auctionListTableView reloadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.auctionListTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.auctions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.row;
    EMAuction *currentAuction = [self.auctions objectAtIndex:idx];

    UITableViewCell *tableViewCell = [self.auctionListTableView dequeueReusableCellWithIdentifier:@"AuctionListItem"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AuctionListItem"];
    }

    EMAuctionListTableViewCell *auctionListTableViewCell = (EMAuctionListTableViewCell*)tableViewCell;

    NSDate *endDate = currentAuction.endDate;
    NSTimeInterval timeInterval = [endDate timeIntervalSinceNow];
    NSString *timeLeft = (timeInterval > 0)? [[NSDateComponentsFormatter new] stringFromTimeInterval:timeInterval] : @"-";

    auctionListTableViewCell.titleLabel.text = currentAuction.title;
    auctionListTableViewCell.statusLabel.text = [EMAuction stringFromAuctionStatus:currentAuction.status];
    auctionListTableViewCell.timeLeftLabel.text = timeLeft;

    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)presentLoginView:(id)sender {
    UIViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController presentViewController:loginView animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"AuctionDetailSegue"]) {
        NSInteger idx = [[self.auctionListTableView indexPathForSelectedRow] row];
        EMAuction *selectedAuction = [self.auctions objectAtIndex:idx];
        EMAuctionDetailViewController *controller = segue.destinationViewController;
        controller.selectedAuction = selectedAuction;
        controller.categories = self.categories;

    } else if ([[segue identifier] isEqualToString:@"AuctionDetailCreateSegue"]) {
        EMAuctionDetailViewController *controller = segue.destinationViewController;
        controller.selectedAuction = [[EMAuction alloc] init];
        controller.categories = self.categories;
    }
}


@end