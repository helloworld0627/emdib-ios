//
//  EMBaseModel.m
//  EmdibApp
//
//  Created by Chris Kwok on 7/5/15.
//  Copyright (c) 2015 Chris Kwok. All rights reserved.
//

#import "EMBaseModel.h"
#import "MTLValueTransformer.h"
#import "ISO8601DateFormatter.h"


NSString* const kISO8601DateTransformerString = @"ISO8601DateTransformer";

@implementation EMBaseModel

+ (void)initialize {
    if (self == [EMBaseModel class]) {
        [NSValueTransformer setValueTransformer: [self ISO8601DateTransformer] forName: kISO8601DateTransformerString];
    }
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"modelId": @"id",
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at"
             };
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kISO8601DateTransformerString];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kISO8601DateTransformerString];
}

+ (NSValueTransformer *)ISO8601DateTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate: date];
    }];
}

+ (ISO8601DateFormatter *)dateFormatter {
    ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
    dateFormatter.format = ISO8601DateFormatCalendar;
    dateFormatter.includeTime = YES;
    return dateFormatter;
}


@end
