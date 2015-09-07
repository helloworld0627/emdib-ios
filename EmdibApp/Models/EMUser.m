//
//  EMUser.m
//  EmdibApp
//
//  Created by Chris Kwok on 9/6/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMUser.h"

@implementation EMUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *parentDict = [super JSONKeyPathsByPropertyKey];
    return [parentDict mtl_dictionaryByAddingEntriesFromDictionary: @{
                                                                      @"name": @"name",
                                                                      }];
}

@end
