//
//  EMAuction.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMBaseModel.h"

typedef enum : NSUInteger {
    AuctionStatusBegin,
    AuctionStatusEnd,
    AuctionStatusCancel,
} AuctionStatus;


@interface EMAuction : EMBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic) AuctionStatus status;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSNumber *startPrice;
@property (nonatomic, strong) NSNumber *endPrice;

@property (nonatomic, strong) NSNumber *sellerId;
@property (nonatomic, strong) NSNumber *categoryId;

@property (nonatomic, strong) NSNumber *longtitude;
@property (nonatomic, strong) NSNumber *latitude;


@end