//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: NSString+STextFormatter.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "STextFormatter.h"

@interface NSString (STextFormatter)
- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                       andDelimiter:(NSString *)delimiter;

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                       andDelimiter:(NSString *)delimiter
                          HasPrefix:(NSString *)prefix;

- (NSString *)checkDate:(SDateFormatPattern)pattern
          withDelimiter:(NSString *)delimiter;

@end
