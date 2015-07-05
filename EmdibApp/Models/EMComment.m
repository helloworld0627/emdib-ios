//
//  EMBid.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMComment.h"

@implementation EMComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"content": @"content",
             @"auctionId": @"auction_id",
             @"userId": @"user_id",
             };
}


@end
