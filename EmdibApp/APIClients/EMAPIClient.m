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
        NSString *token = @"CAACEdEose0cBALbfLVc1BxdybEPhEQfkkm9RkZBJZAG3EoLLcqTBw6PZBLv7fP66GyDQ0ILg14axhCZCdb1w2JyOZAWtjDnOqerGu4ezlbjDHCwCWKNfvswhnGadhIvthSZBtl8XxesPYFrDZCA7YJfmohLn9lbkDauRNkUH8gvYKAZBsT8vOynGlUgJUaDjzokaVWeiiBcDSwZDZD";
        httpSessionManager = [AFHTTPSessionManager manager];
        httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Token token=\"%@\"", token] forHTTPHeaderField:@"Authorization"];
    }
    return self;
}


#pragma mark - EMUtilAPI

-(NSURLSessionDataTask *)fetchAllCategoriesOnCompletion:(void (^)(NSArray* categories, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:PATH_UTIL_CATEGORIES];
    return [httpSessionManager GET: path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               NSArray *parsedCategories = [self getCategoriesFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedCategories, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)fetchCommentsByAuctionId:(NSNumber*)auctionId
                                     onCompletion:(void (^)(NSArray* comments, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_UTIL_COMMENTS, auctionId]];
    return [httpSessionManager GET: path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               NSArray *parsedComments = [self getCommentsFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedComments, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)createComment:(EMComment*)comment
                          onCompletion:(void (^)(EMComment* comment, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_UTIL_COMMENTS, comment.auctionId]];
    NSError *error;
    return [httpSessionManager POST:path
                         parameters:[self dictionaryFromModel:comment error:&error]
                            success: ^(NSURLSessionDataTask *task, id responseObject){
                                NSError *JSONError;
                                EMComment *parsedComment = [self getCommentFromResponse:responseObject error:&JSONError];
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedComment, JSONError); });
                                }
                            }
                            failure: ^(NSURLSessionDataTask *task, NSError *error){
                                /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                                }
                            }
            ];
}


#pragma mark - EMSellerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsSellerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:PATH_SELLER_AUCTIONS];
    return [httpSessionManager GET:path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               NSArray *parsedAuctions = [self getAuctionsFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedAuctions, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)fetchBidsAsSellerByAuctionId:(NSNumber*)auctionId
                                         onCompletion:(void (^)(NSArray* bids, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_SELLER_BIDS, auctionId]];
    return [httpSessionManager GET:path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               NSArray *parsedBids = [self getBidsFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedBids, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)createAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:PATH_SELLER_AUCTION];
    return [httpSessionManager POST:path
                         parameters:nil
                            success: ^(NSURLSessionDataTask *task, id responseObject){
                                NSError *JSONError;
                                EMAuction *parsedAuction = [self getAuctionFromResponse:responseObject error:&JSONError];
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedAuction, JSONError); });
                                }
                            }
                            failure: ^(NSURLSessionDataTask *task, NSError *error){
                                /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                                }
                            }
            ];
}

-(NSURLSessionDataTask *)updateAuction:(EMAuction*)auction
                          onCompletion:(void (^)(EMAuction* auction, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_SELLER_AUCTION, auction.modelId]];
    NSError *error;
    return [httpSessionManager PUT:path
                        parameters:[self dictionaryFromModel:auction error:&error]
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               EMAuction *parsedAuction = [self getAuctionFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedAuction, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)setBidStatus:(BidStatus) bidStatus
                            auctionId:(NSNumber*) auctionId
                                bidId:(NSNumber*) bidId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_SELLER_BID, auctionId, bidId]];
    EMBid *bid = [EMBid new];
    bid.auctionId = auctionId;
    bid.status = bidStatus;
    NSError *error;
    return [httpSessionManager PUT:path
                        parameters:[self dictionaryFromModel:bid error:&error]
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               EMBid *parsedBid = [self getBidFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedBid, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}


#pragma mark - EMBuyerAPI

-(NSURLSessionDataTask *)fetchAuctionsAsBuyerOnCompletion:(void (^)(NSArray* auctions, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:PATH_BUYER_AUCTIONS];
    return [httpSessionManager GET:path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               NSArray *parsedAuctions = [self getAuctionsFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedAuctions, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)fetchBidById:(NSNumber*)bidId
                            auctionId:(NSNumber*)auctionId
                         onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath: [[NSString alloc] initWithFormat:PATH_BUYER_BID, auctionId, bidId]];
    return [httpSessionManager GET:path
                        parameters:nil
                           success: ^(NSURLSessionDataTask *task, id responseObject){
                               NSError *JSONError;
                               EMBid *parsedBid = [self getBidFromResponse:responseObject error:&JSONError];
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedBid, JSONError); });
                               }
                           }
                           failure: ^(NSURLSessionDataTask *task, NSError *error){
                               /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                               if (completionBlock) {
                                   dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                               }
                           }
            ];
}

-(NSURLSessionDataTask *)createBid:(EMBid*)bid
                      onCompletion:(void (^)(EMBid* bid, NSError *error))completionBlock {
    NSString *path = [self hostURLWithPath:[[NSString alloc] initWithFormat:PATH_BUYER_BIDS, bid.auctionId]];
    return [httpSessionManager POST:path
                         parameters:nil
                            success: ^(NSURLSessionDataTask *task, id responseObject){
                                NSError *JSONError;
                                EMBid *parsedBid = [self getBidFromResponse:responseObject error:&JSONError];
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(parsedBid, JSONError); });
                                }
                            }
                            failure: ^(NSURLSessionDataTask *task, NSError *error){
                                /*error = [self networkErrorForResponse:task.response withUnderlyingError:error description:TCCScoutingLocalizedString(@"Unable to retrieve scouting activity", nil)];*/
                                if (completionBlock) {
                                    dispatch_async(dispatch_get_main_queue(), ^{ completionBlock(nil, error); });
                                }
                            }
            ];
}


#pragma mark - Private Mantle

// Categories
-(NSArray *)getCategoriesFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelsOfClass:[EMCategory class] fromJSONArray:responseObject error:error];
}

// Comments
-(NSArray *)getCommentsFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelsOfClass:[EMComment class] fromJSONArray:responseObject error:error];
}

-(EMComment *)getCommentFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelOfClass:[EMComment class] fromJSONDictionary:responseObject error:error];
}

// Auctions
-(NSArray *)getAuctionsFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelsOfClass:[EMAuction class] fromJSONArray:responseObject error:error];
}

-(EMAuction *)getAuctionFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelOfClass:[EMAuction class] fromJSONDictionary:responseObject error:error];
}

// Bids
-(NSArray *)getBidsFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelsOfClass:[EMBid class] fromJSONArray:responseObject error:error];
}

-(EMBid *)getBidFromResponse:(id)responseObject error:(NSError**)error {
    return [MTLJSONAdapter modelOfClass:[EMBid class] fromJSONDictionary:responseObject error:error];
}

// Error
-(NSError *)getErrorFromFailureBlock:(void (^)(EMBid* bid, NSError *error))failure {
    return nil;
}


#pragma mark - Helper

-(NSDictionary *)dictionaryFromModel:(id<MTLJSONSerializing>)model error:(NSError**)error {
    return [MTLJSONAdapter JSONDictionaryFromModel:model error:error];
}

- (NSString *)hostURLWithPath:(NSString*)path {
    // TODO move to property list
    NSURL *hostURL = [[NSURL alloc]initWithString:@"https://sleepy-inlet-9029.herokuapp.com"];
    NSURL *fullURL = [hostURL URLByAppendingPathComponent: path];
    return [fullURL absoluteString];
}

@end
