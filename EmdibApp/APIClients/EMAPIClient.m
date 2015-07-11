//
//  EMAPIClient.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/7/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMAPIClient.h"
#import <AFNetworking/AFHTTPSessionManager.h>

static NSString* const PATH_SELLER_BIDS = @"/seller/auctions/%@/bids";
static NSString* const PATH_SELLER_BID = @"/seller/auctions/%@/bids/%@";
static NSString* const PATH_SELLER_AUCTIONS = @"/seller/auctions";
static NSString* const PATH_SELLER_AUCTION = @"/seller/auctions/%@";

static NSString* const PATH_BUYER_BIDS = @"/buyer/auctions/%@/bids";
static NSString* const PATH_BUYER_BID = @"/buyer/auctions/%@/bids/%@";
static NSString* const PATH_BUYER_AUCTIONS = @"/buyer/auctions";

static NSString* const PATH_UTIL_CATEGORIES = @"/util/categories";
static NSString* const PATH_UTIL_CATEGORY = @"/util/categories/%@";

static NSString* const PATH_UTIL_COMMENTS = @"/util/auctions/%@/comments";
static NSString* const PATH_UTIL_COMMENT = @"/util/auctions/%@/comments/%@";


@implementation EMAPIClient {
    AFHTTPSessionManager* httpSessionManager;
}

static EMAPIClient* apiClient = nil;
+(id) sharedAPIClient {
    if (!apiClient) {
        @synchronized(self) {
            if (!apiClient) {
                apiClient = [[EMAPIClient alloc] init];
            }
        }
    }
    return apiClient;
}


-(instancetype)init {
    if(self = [super init]) {
        httpSessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}

#pragma mark - EMUtilAPI

-(NSURLSessionDataTask *)fetchAllCategoriesOnCompletion:(void (^)(NSArray* categories, NSError *error))completionBlock {

    return [httpSessionManager GET:PATH_UTIL_CATEGORIES
                        parameters:nil
                           success: nil
                           failure: nil];
}

-(NSURLSessionDataTask *)fetchCommentsByAuctionId:(NSNumber*)auctionId
                                     onCompletion:(void (^)(NSArray* comments, NSError *error))completionBlock {
    return [httpSessionManager GET:[[NSString alloc] initWithFormat:PATH_UTIL_COMMENTS, auctionId]
                        parameters:nil
                           success: nil
                           failure: nil];
}

-(NSURLSessionDataTask *)createComment:(EMComment*)comment
                          onCompletion:(void (^)(EMComment* comment, NSError *error))completionBlock {
    return [httpSessionManager POST:[[NSString alloc] initWithFormat:PATH_UTIL_COMMENTS, comment.auctionId]
                         parameters:nil
                            success: nil
                            failure: nil];
}


#pragma mark - EMSellerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsSellerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock {
    return [httpSessionManager GET:PATH_SELLER_AUCTIONS
                        parameters:nil
                           success: nil
                           failure: nil];
}

-(NSURLSessionDataTask *)fetchBidsAsSellerByAuctionId:(NSNumber*)auctionId
                                         onCompletion:(void (^)(NSArray* bids, NSError *error))completionBlock {
    return [httpSessionManager GET:[[NSString alloc] initWithFormat:PATH_SELLER_BIDS, auctionId]
                        parameters:nil
                           success: nil
                           failure: nil];
}

-(NSURLSessionDataTask *)createAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock {
    return [httpSessionManager POST:PATH_SELLER_AUCTIONS
                         parameters:nil
                            success: nil
                            failure: nil];
}

-(NSURLSessionDataTask *)updateAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock {
    return [httpSessionManager PUT:[[NSString alloc] initWithFormat:PATH_SELLER_AUCTION, auction.modelId]
                         parameters:nil
                            success: nil
                            failure: nil];
}

-(NSURLSessionDataTask *)setBidStatus:(BidStatus) bidStatus
                            auctionId:(NSNumber*) auctionId
                                bidId:(NSNumber*) bidId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    return [httpSessionManager PUT:[[NSString alloc] initWithFormat:PATH_SELLER_BID, auctionId, bidId]
                        parameters:nil
                           success: nil
                           failure: nil];
}


#pragma mark - EMBuyerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsBuyerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock {
    return [httpSessionManager GET:PATH_BUYER_AUCTIONS
                        parameters:nil
                           success: nil
                           failure: nil];
}

-(NSURLSessionDataTask *)fetchBidById:(NSNumber*)bidId
                            auctionId:(NSNumber*)auctionId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    return [httpSessionManager GET:[[NSString alloc] initWithFormat:PATH_BUYER_BID, auctionId, bidId]
                        parameters:nil
                           success: nil
                           failure: nil];

}

-(NSURLSessionDataTask *)createBid:(EMBid*)bid
                      onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    return [httpSessionManager POST:[[NSString alloc] initWithFormat:PATH_BUYER_BIDS, bid.auctionId]
                        parameters:nil
                           success: nil
                           failure: nil];
}


@end
