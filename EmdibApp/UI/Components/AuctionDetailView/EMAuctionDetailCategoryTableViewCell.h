//
//  EMAuctionDetailCategoryTableViewCell.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMCategory.h"

@interface EMAuctionDetailCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) EMCategory *category;

@end
