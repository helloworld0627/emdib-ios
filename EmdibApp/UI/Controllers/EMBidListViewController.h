//
//  EMBidListViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAuction.h"
#import "EMBid.h"

@interface EMBidListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bidListTableView;
@property (strong, nonatomic) EMAuction *auction;
@property (strong, nonatomic) NSArray *bids;

@end
