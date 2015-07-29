//
//  EMAuctionDetailViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAuction+MKAnnotation.h"

@interface EMAuctionDetailViewController : UIViewController<UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *auctionDetailTableView;
@property (strong, nonatomic) EMAuction *selectedAuction;

@end
