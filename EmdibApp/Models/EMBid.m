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
    NSDictionary *parentDict = [super JSONKeyPathsByPropertyKey];
    return [parentDict mtl_dictionaryByAddingEntriesFromDictionary: @{
             @"price": @"bid_price",
             @"status": @"bid_status",
             @"auctionId": @"auction_id",
             @"buyerId" : @"buyer_id"
             }];
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"begin": @(BidStatusBegin),
                                                                           @"end_win": @(BidStatusEndWin),
                                                                           @"end_lose": @(BidStatusEndLose),
                                                                           @"cancel": @(BidStatusCancel)
                                                                           }];
}

+(BidStatus)bidStatusFromString:(NSString*)string {
    static NSDictionary *dict;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        dict = @{
                 @"begin": @(BidStatusBegin),
                 @"end_win": @(BidStatusEndWin),
                 @"end_lose": @(BidStatusEndLose),
                 @"cancel": @(BidStatusCancel)
                 };
    });

    NSNumber *val = dict[string];
    return (BidStatus)val.intValue;
};

+ (NSString*) stringFromBidStatus:(BidStatus)status {
    NSString *val = @"-";
    switch (status) {
        case BidStatusBegin:
            val = @"Begin";
            break;
        case BidStatusEndWin:
            val = @"End (Win)";
            break;
        case BidStatusEndLose:
            val = @"End (Lose)";
            break;
        case BidStatusCancel:
            val = @"Cancel";
            break;
    }
    return val;
}

@end
