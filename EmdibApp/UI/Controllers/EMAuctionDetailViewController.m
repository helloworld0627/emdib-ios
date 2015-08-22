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
#import "EMCommentListViewController.h"
#import "EMBidListViewController.h"
#import "EMAuctionStatusViewController.h"
#import "EMCategoryViewController.h"
#import "EMAPIClient.h"

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

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation EMAuctionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isNewMode]) {
        self.selectedAuction.startDate = [NSDate date];
        self.selectedAuction.endDate = [NSDate date];
        self.selectedAuction.status = AuctionStatusBegin;
        self.selectedAuction.startPrice = @(10);
        self.selectedAuction.endPrice = @(20);
        self.selectedAuction.categoryId = @1;
        self.selectedAuction.auctionTitle = @"asdf";

        UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                        target:self action:@selector(createAuction)];
        self.navigationItem.rightBarButtonItem = createButton;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.auctionDetailTableView reloadData]; // to reload selected cell
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isNewMode {
    return self.selectedAuction.modelId == nil;
}

-(void)createAuction {
    [self updateAuctionFromTableView];
    [[EMAPIClient sharedAPIClient] createAuction:self.selectedAuction
                                    onCompletion:^(EMAuction *auction, NSError *error) {
                                            if (error) {
                                                NSLog(@"%@", error.localizedDescription);
                                            }
                                            UIAlertController *alertMenu = [UIAlertController alertControllerWithTitle: @"Created"
                                                                                                                message: nil
                                                                                                        preferredStyle: UIAlertControllerStyleAlert];
                                            UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                                 style:UIAlertActionStyleDefault
                                                                                               handler:^(UIAlertAction *action) {
                                                                                                   }];
                                                [alertMenu addAction:doneAction];
                                                [self presentViewController:alertMenu animated:YES completion:nil];
                                            }];
}


#pragma marks - UITableViewDataSource

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
        if (self.selectedAuction.categoryId == nil) {
            return cell;
        }
        cell.category = [EMCategory categoryWithModeId:self.selectedAuction.categoryId
                                                  from:self.categories];
        cell.categoryLabel.text = cell.category.name;
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


#pragma marks - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [[self class] cellIdentifiers][indexPath.row];
    if ([cellIdentifier isEqualToString:DESC_CELL_ID ]) {
        return 120;
    } else if ([cellIdentifier isEqualToString:MAP_CELL_ID ]) {
        return 120;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cellIdentifiers = [[self class] cellIdentifiers];
    NSString *cellIdentifier = cellIdentifiers[indexPath.row];
    if ([STARTDATE_CELL_ID isEqualToString:cellIdentifier]) {
        void(^selectDateBlock)(UIAlertAction*) = ^(UIAlertAction *action) {
            self.selectedAuction.startDate = self.datePicker.date;
            [self.auctionDetailTableView reloadData];
        };
        [self presentDatePicker:self.selectedAuction.startDate handler:selectDateBlock];
    } else if ([ENDDATE_CELL_ID isEqualToString:cellIdentifier]) {
        void(^selectDateBlock)(UIAlertAction*) = ^(UIAlertAction *action) {
            self.selectedAuction.endDate = self.datePicker.date;
            [self.auctionDetailTableView reloadData];
        };
        [self presentDatePicker:self.selectedAuction.endDate handler:selectDateBlock];
    }
}

- (void)presentDatePicker:(NSDate*)date handler:(void(^)(UIAlertAction*))selectDateBlock {
    UIAlertController *selectDateMenu = [UIAlertController alertControllerWithTitle:@"Select Date"
                                                                            message:nil
                                                                     preferredStyle: UIAlertControllerStyleActionSheet];

    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    //datePicker.datePickerMode = UIDatePickerModeDate;
    UIViewController *subviewController = [[UIViewController alloc] init];
    subviewController.preferredContentSize = CGSizeMake(subviewController.preferredContentSize.width, 200);
    [subviewController.view addSubview:self.datePicker];

    UIAlertAction *selectDateAction = [UIAlertAction actionWithTitle:@"Done"
                                                               style:UIAlertActionStyleDefault
                                                             handler:selectDateBlock];

    [selectDateMenu setValue:subviewController forKey:@"contentViewController"];
    [selectDateMenu addAction:selectDateAction];
    [self presentViewController:selectDateMenu animated:YES completion:nil];
}


#pragma mark - pop up actions

- (IBAction)presentRightBarItemActionController:(id)sender {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil
                                                                        message:nil
                                                                 preferredStyle: UIAlertControllerStyleActionSheet];
    [optionMenu addAction:[self saveAction]];
    [optionMenu addAction:[self commentAction]];
    [optionMenu addAction:[self bidAction]];
    [optionMenu addAction:cancelAction];
    [self presentViewController:optionMenu animated:YES completion:nil];
}

- (UIAlertAction*)saveAction {
    void(^saveActionBlock)(UIAlertAction*) = ^(UIAlertAction *action) {
        [self updateAuctionFromTableView];
        [[EMAPIClient sharedAPIClient] updateAuction:self.selectedAuction
                                        onCompletion:^(EMAuction *auction, NSError *error) {
                                            if (error) {
                                                NSLog(@"%@", error.localizedDescription);
                                            }
                                            UIAlertController *alertMenu = [UIAlertController alertControllerWithTitle: @"Saved"
                                                                                                               message: nil
                                                                                                        preferredStyle: UIAlertControllerStyleAlert];
                                            UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                                 style:UIAlertActionStyleDefault
                                                                                               handler:^(UIAlertAction *action) {
                                                                                               }];
                                            [alertMenu addAction:doneAction];
                                            [self presentViewController:alertMenu animated:YES completion:nil];
                                        }];
    };
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save Auction Details"
                                                         style:UIAlertActionStyleDefault
                                                       handler:saveActionBlock];
    return saveAction;
}

- (UIAlertAction*)commentAction {
    void(^commentActionBlock)(UIAlertAction*) = ^(UIAlertAction *action) {
        EMCommentListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentListView"];
        controller.auction = self.selectedAuction;
        [self.navigationController pushViewController:controller animated:YES];
    };
    UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"Comments"
                                                            style:UIAlertActionStyleDefault
                                                          handler:commentActionBlock];
    return commentAction;
}

- (UIAlertAction*)bidAction {
    void(^bidActionBlock)(UIAlertAction*) = ^(UIAlertAction *action) {
        EMBidListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"BidListView"];
        controller.auction = self.selectedAuction;
        [self.navigationController pushViewController:controller animated:YES];
    };

    UIAlertAction *bidAction = [UIAlertAction actionWithTitle:@"Bids"
                                                        style:UIAlertActionStyleDefault
                                                      handler:bidActionBlock];
    return bidAction;
}

- (void)updateAuctionFromTableView {
    NSArray *cellIdentifiers = [EMAuctionDetailViewController cellIdentifiers];
    for (int i = 0; i < cellIdentifiers.count; i++) {
        NSString *cellIdentifier = cellIdentifiers[i];
        UITableViewCell *tableViewCell = [self.auctionDetailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        // assign cell's value
        if ([TITLE_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailTitleTableViewCell *cell = (EMAuctionDetailTitleTableViewCell*)tableViewCell;
            self.selectedAuction.auctionTitle = cell.titleLabel.text;

        } else if ([DESC_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailDescriptionTableViewCell *cell = (EMAuctionDetailDescriptionTableViewCell*)tableViewCell;
            self.selectedAuction.desc = cell.descriptionTextView.text;

        } else if ([CATEGORY_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailCategoryTableViewCell *cell = (EMAuctionDetailCategoryTableViewCell*)tableViewCell;
            for (EMCategory *c in self.categories) {
                if ([c.name isEqualToString:cell.categoryLabel.text]) {
                    self.selectedAuction.categoryId = c.modelId;
                    break;
                }
            }

        } else if ([STATUS_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailStatusTableViewCell *cell = (EMAuctionDetailStatusTableViewCell*)tableViewCell;
            cell.statusLabel.text = [EMAuction stringFromAuctionStatus:self.selectedAuction.status];

        } else if ([STARTDATE_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailStartDateTableViewCell *cell = (EMAuctionDetailStartDateTableViewCell*)tableViewCell;
            self.selectedAuction.startDate = [[self class] dateFromString:cell.startDateLabel.text];

        } else if ([ENDDATE_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailEndDateTableViewCell *cell = (EMAuctionDetailEndDateTableViewCell*)tableViewCell;
            self.selectedAuction.endDate = [[self class] dateFromString:cell.endDateLabel.text];

        } else if ([STARTPRICE_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailStartPriceTableViewCell *cell = (EMAuctionDetailStartPriceTableViewCell*)tableViewCell;
            self.selectedAuction.startPrice = [[NSNumber alloc] initWithDouble:[cell.startPriceTextField.text doubleValue]];

        } else if ([ENDPRICE_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailEndPriceTableViewCell *cell = (EMAuctionDetailEndPriceTableViewCell*)tableViewCell;
            self.selectedAuction.endPrice = [[NSNumber alloc] initWithDouble:[cell.endPriceTextField.text doubleValue]];

        } else if ([MAP_CELL_ID isEqualToString:cellIdentifier]) {
            EMAuctionDetailLocationTableViewCell *cell = (EMAuctionDetailLocationTableViewCell*)tableViewCell;
            for (id <MKAnnotation> annotation in cell.mapView.annotations) {
                self.selectedAuction.latitude = [[NSNumber alloc] initWithDouble:[annotation coordinate].latitude];
                self.selectedAuction.longtitude = [[NSNumber alloc] initWithDouble:[annotation coordinate].longitude];
            }
        }
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
    return [[[self class] dateFormatter] stringFromDate:date];
}

+ (NSDate*)dateFromString:(NSString*)date {
    return [[[self class] dateFormatter] dateFromString:date];
}

+ (NSDateFormatter*)dateFormatter {
    static NSDateFormatter * dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];    // Example: "2014-07-25 16:40:03"
        [dateFormatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
    });
    return dateFormatter;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AuctionStatusSegue"]) {
        EMAuctionStatusViewController *controller = segue.destinationViewController;
        controller.selectedAuction = self.selectedAuction;
    } else if ([segue.identifier isEqualToString:@"AuctionCategorySegue"]) {
        EMCategoryViewController *controller = segue.destinationViewController;
        controller.selectedAuction = self.selectedAuction;
    }
}


@end