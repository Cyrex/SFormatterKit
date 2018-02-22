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
//      2018/2/18: Refactor method for spliting string with blocks.

#import "STextFormatter.h"

@interface NSString (STextFormatter)

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks andDelimiter:(NSString *)delimiter;

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks delimiter:(NSString *)delimiter andPrefix:(NSString *)prefix;

- (NSString *)formatterDateWithPattern:(SDateFormatPattern)pattern andDelimiter:(NSString *)delimiter;

@end
