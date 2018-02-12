//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: NSString+STextFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "NSString+STextFormatter.h"

NSString *const SDateMonthReg = @"^(1[012]";
NSString *const SDateDayReg   = @"^(0[1-9]|[12][0-9])";

#define SDatePre(type) [NSPredicate predicateWithFormat:@"SELF MATCHES %@", S##type##Reg]

@implementation NSString (STextFormatter)
- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                       andDelimiter:(NSString *)delimiter {
    
    NSMutableString *result = [NSMutableString string];
    NSMutableString *sub    = [NSMutableString stringWithString:self];
    
    NSNumber *block;
    for (int idx = 0; idx < blocks.count; idx++) {
        block = [blocks objectAtIndex:idx];
        
        if (sub.length > block.integerValue) {
            result = (NSMutableString *)[result stringByAppendingString:[[sub substringToIndex:block.integerValue] stringByAppendingString:delimiter]];
            sub = (NSMutableString *)[sub substringFromIndex:block.integerValue];
        } else if (sub.length == block.integerValue && idx != blocks.count - 1) {
            result = (NSMutableString *)[result stringByAppendingString:[sub stringByAppendingString:delimiter]];
            return [result copy];
        } else {
            result = (NSMutableString *)[result stringByAppendingString:sub];
            return [result copy];
        }
    }
    
    return [result copy];
}

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                       andDelimiter:(NSString *)delimiter
                          HasPrefix:(NSString *)prefix {
    
    if (nil != prefix || 0 != prefix.length) {
        NSString *sub = [self substringFromIndex:prefix.length];
        
        return [prefix stringByAppendingString:[sub splitStringWithBlocks:blocks
                                                             andDelimiter:delimiter]];
    }
    
    return [self splitStringWithBlocks:blocks
                          andDelimiter:delimiter];
}

- (NSString *)checkDate:(SDateFormatPattern)pattern
          withDelimiter:(NSString *)delimiter {
    
    NSArray<NSString *> *test = [self componentsSeparatedByString:delimiter];
    
    NSMutableString *result = [NSMutableString string];
    
    NSString *_year = [NSString string];
    NSString *_month = [NSString string];
    NSString *_day = [NSString string];
    
    switch (pattern) {
        case SDateFormatPatternYMD:
            switch (test.count) {
                case 3:
                    _day   = test[2];
                case 2:
                    _month = test[1];
                case 1:
                    _year  = test[0];
                    break;
            }
            break;
        case SDateFormatPatternMD:
            switch (test.count) {
                case 2:
                    _day   = test[1];
                case 1:
                    _month = test[0];
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
    
    
    if (test.count > 1) {
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
