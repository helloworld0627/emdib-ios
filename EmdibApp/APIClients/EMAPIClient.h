//
//  EMAPIClient.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/7/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMAuction.h"
#import "EMBid.h"
#import "EMCategory.h"
#import "EMComment.h"

#define FB_TOKEN @"CAACEdEose0cBAGPT7gucIzS2oqAxd2M8GKakStsZAAjc53Y7Fo8TuuIbEakRf3V848VG1Xpe8nL7i5DQYkOWYJLlmwl7O8RoVkX5zgmRZAZBYawwFpnxfcl8CKE3ysE4FJGf3NZARVZCf7Mn9WLuLPGcVX7kIE5JAMhZCiPzfUkpOtgXDUJDosQlpbTFM5z3bEUMThs77XUwZDZD"

@protocol EMUtilAPI

-(NSURLSessionDataTask *)fetchAllCategoriesOnCompletion:(void (^)(NSArray* categories, NSError *error))completionBlock;

-(NSURLSessionDataTask *)fetchCommentsByAuctionId:(NSNumber*)auctionId
                                     onCompletion:(void (^)(NSArray* comments, NSError *error))completionBlock;

-(NSURLSessionDataTask *)createComment:(EMComment*)comment
                          onCompletion:(void (^)(EMComment* comment, NSError *error))completionBlock;

@end


@protocol EMSellerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsSellerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock;

-(NSURLSessionDataTask *)fetchBidsAsSellerByAuctionId:(NSNumber*)auctionId
                                         onCompletion:(void (^)(NSArray* bids, NSError *error))completionBlock;

-(NSURLSessionDataTask *)createAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock;

-(NSURLSessionDataTask *)updateAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock;

-(NSURLSessionDataTask *)setBidStatus:(BidStatus) bidStatus
                            auctionId:(NSNumber*) auctionId
                                bidId:(NSNumber*) bidId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock;

@end


@protocol EMBuyerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsBuyerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock;

-(NSURLSessionDataTask *)fetchBidById:(NSNumber*)bidId
                            auctionId:(NSNumber*)auctionId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock;

-(NSURLSessionDataTask *)createBid:(EMBid*)bid
                      onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock;

@end

@interface EMAPIClient : NSObject<EMUtilAPI, EMSellerAPI, EMBuyerAPI>

+(id) sharedAPIClient;

@end
