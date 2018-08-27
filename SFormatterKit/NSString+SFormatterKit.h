//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: NSString+SFormatterKit.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import "SDateFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SFormatterKit)

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                       andDelimiter:(NSString *)delimiter;

- (NSString *)splitStringWithBlocks:(NSArray<NSNumber *> *)blocks
                          delimiter:(NSString *)delimiter
                          andPrefix:(nullable NSString *)prefix;

- (NSString *)formatterDateWithPattern:(SDateFormatPattern)pattern
                          andDelimiter:(NSString *)delimiter;

@end

NS_ASSUME_NONNULL_END
