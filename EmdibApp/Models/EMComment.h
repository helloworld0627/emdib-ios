//
//  EMBid.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMBaseModel.h"

@interface EMComment : EMBaseModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong, readonly) NSNumber *auctionId;

@end
