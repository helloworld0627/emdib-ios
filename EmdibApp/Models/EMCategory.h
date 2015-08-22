//
//  EMCategory.h
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMBaseModel.h"

@interface EMCategory : EMBaseModel

@property(strong, nonatomic, readonly) NSNumber *parentCategoryId;
@property(strong, nonatomic, readonly) NSString *name;


+ (EMCategory *)categoryWithModeId:(NSNumber*)modelId from:(NSArray*)categories;

@end
