//
//  EMAuctionDetailViewController.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/20/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAuctionDetailViewController.h"
#import "EMAuctionDetailTitleTableViewCell.h"
#import "EMAuctionDetailDescriptionTableViewCell.h"
#import "EMAuctionDetailCategoryTableViewCell.h"
#import "EMAuctionDetailStartDateTableViewCell.h"
#import "EMAuctionDetailEndDateTableViewCell.h"
#import "EMAuctionDetailStartPriceTableViewCell.h"
#import "EMAuctionDetailEndPriceTableViewCell.h"
#import "EMAuctionDetailLocationTableViewCell.h"
#import "EMAuctionDetailStatusTableViewCell.h"

static NSString * const MAP_CELL_ID = @"AuctionDetailMapCell";
static NSString * const TITLE_CELL_ID = @"AuctionDetailTitleCell";
static NSString * const DESC_CELL_ID = @"AuctionDetailDescCell";
static NSString * const CATEGORY_CELL_ID = @"AuctionDetailCategoryCell";
static NSString * const STATUS_CELL_ID = @"AuctionDetailStatusCell";
static NSString * const STARTDATE_CELL_ID = @"AuctionDetailStartDateCell";
static NSString * const ENDDATE_CELL_ID = @"AuctionDetailEndDateCell";
static NSString * const STARTPRICE_CELL_ID = @"AuctionDetailStartPriceCell";
static NSString * const ENDPRICE_CELL_ID = @"AuctionDetailEndPriceCell";

@interface EMAuctionDetailViewController ()

@end

@implementation EMAuctionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EMAuctionDetailViewController cellIdentifiers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cellIdentifiers = [EMAuctionDetailViewController cellIdentifiers];
    NSInteger idx = indexPath.row;
    NSString *cellIdentifier = cellIdentifiers[idx];
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    // assign cell's value
    if ([TITLE_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailTitleTableViewCell *cell = (EMAuctionDetailTitleTableViewCell*)tableViewCell;
        cell.titleLabel.text = self.selectedAuction.auctionTitle;
        return cell;

    } else if ([DESC_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailDescriptionTableViewCell *cell = (EMAuctionDetailDescriptionTableViewCell*)tableViewCell;
        cell.descriptionTextView.text = self.selectedAuction.desc;
        return cell;

    } else if ([CATEGORY_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailCategoryTableViewCell *cell = (EMAuctionDetailCategoryTableViewCell*)tableViewCell;
        cell.categoryLabel.text = @"asdf";
        return cell;

    } else if ([STATUS_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailStatusTableViewCell *cell = (EMAuctionDetailStatusTableViewCell*)tableViewCell;
        cell.statusLabel.text = [EMAuction stringFromAuctionStatus:self.selectedAuction.status];
        return cell;

    } else if ([STARTDATE_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailStartDateTableViewCell *cell = (EMAuctionDetailStartDateTableViewCell*)tableViewCell;
        cell.startDateLabel.text = [[self class] formatDate:self.selectedAuction.startDate];
        return cell;

    } else if ([ENDDATE_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailEndDateTableViewCell *cell = (EMAuctionDetailEndDateTableViewCell*)tableViewCell;
        cell.endDateLabel.text = [[self class] formatDate:self.selectedAuction.endDate];
        return cell;

    } else if ([STARTPRICE_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailStartPriceTableViewCell *cell = (EMAuctionDetailStartPriceTableViewCell*)tableViewCell;
        cell.startPriceTextField.text = [[NSString alloc] initWithFormat:@"%.02f", self.selectedAuction.startPrice.doubleValue];
        return cell;

    } else if ([ENDPRICE_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailEndPriceTableViewCell *cell = (EMAuctionDetailEndPriceTableViewCell*)tableViewCell;
        cell.endPriceTextField.text = [[NSString alloc] initWithFormat:@"%.02f", self.selectedAuction.endPrice.doubleValue];
        return cell;
    } else if ([MAP_CELL_ID isEqualToString:cellIdentifier]) {
        EMAuctionDetailLocationTableViewCell *cell = (EMAuctionDetailLocationTableViewCell*)tableViewCell;
        [cell.mapView addAnnotation:self.selectedAuction];
        [cell.mapView showAnnotations:cell.mapView.annotations animated:YES];
        return cell;
    }

    return tableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [[self class] cellIdentifiers][indexPath.row];
    if ([cellIdentifier isEqualToString:DESC_CELL_ID ]) {
        return 120;
    } else if ([cellIdentifier isEqualToString:MAP_CELL_ID ]) {
        return 120;
    } else {
        return 44;
    }
}


#pragma mark - cell identifier

+ (NSArray*) cellIdentifiers {
    static NSArray* cellIdentifiers;
    if (!cellIdentifiers) {
        @synchronized(self) {
            if (!cellIdentifiers) {
                // do not change order
                cellIdentifiers = @[MAP_CELL_ID,
                                    TITLE_CELL_ID,
                                    DESC_CELL_ID,
                                    CATEGORY_CELL_ID,
                                    STATUS_CELL_ID,
                                    STARTDATE_CELL_ID,
                                    ENDDATE_CELL_ID,
                                    STARTPRICE_CELL_ID,
                                    ENDPRICE_CELL_ID];
            }
        }
    }

    return cellIdentifiers;
}


#pragma mark - date formatter

+ (NSString*)formatDate:(NSDate*)date {
    static NSDateFormatter * dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];    // Example: "2014-07-25 16:40:03"
        [dateFormatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
    });

    return [dateFormatter stringFromDate:date];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end