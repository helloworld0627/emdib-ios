//
//  EMCategoryViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAuction.h"

@interface EMCategoryViewController : UITableViewController

@property (strong, nonatomic) EMAuction *selectedAuction;

@end
