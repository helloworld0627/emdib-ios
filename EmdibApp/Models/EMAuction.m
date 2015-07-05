//
//  EMAuction.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAuction.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation EMAuction

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"auction_title",
             @"status": @"auction_status",
             @"desc": @"auction_desc",
             @"startPrice": @"auction_start_price",
             @"endPrice": @"auction_end_price",
             @"startDate": @"auction_start_date",
             @"endDate": @"auction_end_date",
             @"sellerId": @"seller_id",
             @"categoryId": @"category_id",
             @"longtitude": @"longtitude",
             @"latitude": @"latitude"
             };
}

+ (NSValueTransformer *)startDateJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kISO8601DateTransformerString];
}

+ (NSValueTransformer *)endDateJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kISO8601DateTransformerString];
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                           @"begin": @(AuctionStatusBegin),
                                                                           @"end": @(AuctionStatusEnd),
                                                                           @"cancel": @(AuctionStatusCancel)
                                                                           }];
}

@end