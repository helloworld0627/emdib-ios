//
//  EMBidDetailViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMBid.h"

@interface EMBidDetailViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bidDetailTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;
@property (strong, nonatomic) EMBid *selectedBid;

@end
