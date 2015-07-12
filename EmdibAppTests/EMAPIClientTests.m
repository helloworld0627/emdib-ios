//
//  EMAPIClientTests.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/11/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EMAPIClient.h"

// TODO: use OHHTTPStubs stubs network call

@interface EMAPIClientTests : XCTestCase

@end

@implementation EMAPIClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testFetchAllCategoriesOnCompletion {
    [[EMAPIClient sharedAPIClient] fetchAllCategoriesOnCompletion:^(NSArray *categories, NSError *error) {
        ;
    }];
}

-(void)testFetchComments {
    [[EMAPIClient sharedAPIClient] fetchCommentsByAuctionId:@1
                                            onCompletion:^(NSArray *comments, NSError *error) {
                                            }
     ];

}

-(void)testCreateComment {
     [[EMAPIClient sharedAPIClient] createComment:nil
                                     onCompletion:^(EMComment *comment, NSError *error) {
     }];
}

-(void)testFetchAuctionsAsSeller {
    [[EMAPIClient sharedAPIClient] fetchAuctionsAsSellerOnCompletion:^(NSArray *auctions, NSError *error) {
    }];
}

-(void)testFetchBidsAsSellerByAuctionId {
    [[EMAPIClient sharedAPIClient] fetchBidsAsSellerByAuctionId:@1 onCompletion:^(NSArray *bids, NSError *error) {
    }];
}

-(void)testCreateAuction {
    [[EMAPIClient sharedAPIClient] createAuction:nil
                                    onCompletion:^(EMAuction *auction, NSError *error) {
                                    }
     ];
}

-(void)testUpdateAuction {
    [[EMAPIClient sharedAPIClient] updateAuction:nil
                                    onCompletion:^(EMAuction *auction, NSError *error) {
                                    }
     ];
}

-(void)testSetBidStatus {
    [[EMAPIClient sharedAPIClient] setBidStatus:BidStatusBegin
                                      auctionId:@1 bidId:@1
                                   onCompletion:^(EMBid *bid, NSError *error) {

                                      }
     ];
}

-(void)testFetchAuctionsAsBuyer {
    [[EMAPIClient sharedAPIClient] fetchAuctionsAsBuyerOnCompletion:^(NSArray *auctions, NSError *error) {
    }];
}

-(void)testFetchBidById {
    [[EMAPIClient sharedAPIClient] fetchBidById:@1
                                      auctionId:@1
                                   onCompletion:^(EMBid *bid, NSError *error) {

                                      }
     ];
}

-(void)testCreateBid {
    [[EMAPIClient sharedAPIClient] createBid:nil
                                onCompletion:^(EMBid *bid, NSError *error) {
                                }
     ];
}

@end
