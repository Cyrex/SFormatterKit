//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: NSString+STextFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//

#import "NSString+STextFormatter.h"

NSString *const SDateMonthReg = @"^(1[012]";
NSString *const SDateDayReg   = @"^(0[1-9]|[12][0-9])";

#define SDatePre(type) [NSPredicate predicateWithFormat:@"SELF MATCHES %@", S##type##Reg]

@implementation NSString (STextFormatter)
- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks andDelimiter:(NSString *)delimiter {
    __block NSMutableString *result = [NSMutableString string];
    __block NSMutableString *leftString    = [NSMutableString stringWithString:self];
    
    [blocks enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        if (leftString.length > [obj integerValue]) {
            NSString *block = [leftString substringToIndex:[obj integerValue]];
            result = (NSMutableString *)[result stringByAppendingString:[block stringByAppendingString:delimiter]];
            leftString = (NSMutableString *)[leftString substringFromIndex:[obj integerValue]];
        } else if (leftString.length == [obj integerValue] && (blocks.count - 1) != idx) {
            result = (NSMutableString *)[result stringByAppendingString:[leftString stringByAppendingString:delimiter]];
            *stop = YES;
        } else {
            result = (NSMutableString *)[result stringByAppendingString:leftString];
            *stop = YES;
        }
    }];
    
    return [result copy];
}

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks delimiter:(NSString *)delimiter andPrefix:(NSString *)prefix {
    if (nil != prefix || 0 != prefix.length) {
        NSString *sub = [self substringFromIndex:prefix.length - 1];
        
        return [prefix stringByAppendingString:[sub splitStringWithBlocks:blocks andDelimiter:delimiter]];
    }
    
    return [self splitStringWithBlocks:blocks andDelimiter:delimiter];
}

- (NSString *)checkDate:(SDateFormatPattern)pattern andDelimiter:(NSString *)delimiter {
    NSArray<NSString *> *splitString = [self componentsSeparatedByString:delimiter];
    
    NSMutableString *result = [NSMutableString string];
    
    NSString *_year  = [NSString string];
    NSString *_month = [NSString string];
    NSString *_day   = [NSString string];
    
    switch (pattern) {
        case SDateFormatPatternYMD:
            switch (splitString.count) {
                case 3:
                    _day   = splitString[2];
                case 2:
                    _month = splitString[1];
                case 1:
                    _year  = splitString[0];
                    break;
            }
            break;
        case SDateFormatPatternMD:
            switch (splitString.count) {
                case 2:
                    _day   = splitString[1];
                case 1:
                    _month = splitString[0];
                    break;
            }
    }
    
    if (SDateFormatPatternYMD == pattern) {
        if (_year.length < 4) {
            result = (NSMutableString *)[result stringByAppendingString:_year];
        } else {
            result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%@/", _year]];
        }
    }
    
    if ([_month isEqualToString:@"00"]) {
        result = (NSMutableString *)[result stringByAppendingString:@"01/"];
    } else if (1 == _month.length && [_month intValue] > 1) {
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"0%@/", _month]];
    } else if ([_month intValue] > 12) {
        result = (NSMutableString *)[result stringByAppendingString:@"12/"];
    } else if (![_month isEqualToString:@""]){
        result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%@/", _month]];
    }
    
    
    if (splitString.count > 1) {
        if ([_day isEqualToString:@"00"]) {
            result = (NSMutableString *)[result stringByAppendingString:@"01"];
        } else if (1 == _day.length && [_day intValue] > 3) {
            result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"0%@", _day]];
        } else if ([_month intValue] > 31) {
            result = (NSMutableString *)[result stringByAppendingString:@"31"];
        } else {
            result = (NSMutableString *)[result stringByAppendingString:_day];
        }
    }
    
    return result;
}

@end
