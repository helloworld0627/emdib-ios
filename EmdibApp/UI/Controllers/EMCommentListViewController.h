//
//  EMCommentListViewController.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/25/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMAuction.h"
#import "EMComment.h"

@interface EMCommentListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *commentListTableView;
@property (strong, nonatomic) EMAuction *auction;
@property (strong, nonatomic) NSArray *comments;

@end
