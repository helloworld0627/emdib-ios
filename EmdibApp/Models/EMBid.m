//
//  EMBid.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMBid.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation EMBid

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"price": @"bid_price",
             @"status": @"bid_status",
             @"auctionId": @"auction_id",
             @"buyerId" : @"buyer_id"
             };
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"begin": @(BidStatusBegin),
                                                                           @"end_win": @(BidStatusEndWin),
                                                                           @"end_lose": @(BidStatusEndLose),
                                                                           @"cancel": @(BidStatusCancel)
                                                                           }];
}


@end
