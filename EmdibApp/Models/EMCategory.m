//
//  EMCategory.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMCategory.h"

@implementation EMCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentDict = [super JSONKeyPathsByPropertyKey];
    return [parentDict mtl_dictionaryByAddingEntriesFromDictionary:  @{
             @"name": @"name",
             @"parentCategoryId": @"parent_id"
             }];
}

@end
