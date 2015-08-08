//
//  EMBid.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMBaseModel.h"

typedef enum : NSUInteger {
    BidStatusBegin,
    BidStatusEndWin,
    BidStatusEndLose,
    BidStatusCancel,
} BidStatus;

@interface EMBid : EMBaseModel

@property (nonatomic) BidStatus status;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *auctionId;
@property (nonatomic, strong) NSNumber *buyerId;

+ (NSString*) stringFromBidStatus:(BidStatus)status;

@end
