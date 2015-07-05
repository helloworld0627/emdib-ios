//
//  EMBaseModel.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

extern NSString* const kISO8601DateTransformerString;

@interface EMBaseModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic, readonly) NSNumber *modelId;
@property(strong, nonatomic, readonly) NSDate *createdAt;
@property(strong, nonatomic, readonly) NSDate *updatedAt;

@end
