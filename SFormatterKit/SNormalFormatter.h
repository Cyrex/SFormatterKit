//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SNormalFormatter.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SFormatterType) {
    SFormatterTypeNone = 0,
    SFormatterTypeCreditCard,
    SFormatterTypePhoneNumber,
    SFormatterTypeDate,
    SFormatterTypeNumeral,
    SFormatterTypeCustom,
    SFormatterTypeUserDefined // user-defined
};

@interface SNormalFormatter : NSObject

/**
 *  SFormatterType, default is SFormatterTypeNone.
 */
@property (nonatomic) SFormatterType type;

/**
 *  Only useful in SFormatterTypeCustom and SFormatterTypeNone.
 *  the length UITextfield's text is less than it. default is INT8_MAX.
 */
@property (nonatomic, assign) NSUInteger limitedLength;

/**
 *  Only useful in SFormatterTypeCustom, it will not work if set value in other type.
 *  If it is nil, the function is same as SFormatterTypeNone.
 *  @example if you set blocks is @[@1, @2, @3, @4], the UITextField's text will be @"X XX XXX XXXX" when
 *          delimiter or delimiters is nil.
 */
@property (nullable, nonatomic, strong) NSArray<NSNumber *> *blocks;

/**
 *  Only useful in SFormatterTypeCustom, it will not work if set value in other type.
 *  @example if you set this is @[@".", @".", @"-"], the UITextField's text will be @"X.XX.XXX-XXXX"
 *  careful _delimiters.count should be equal to blocks.count - 1. if not, will use delimiter.
 *
 *  It has a higher priority than delimiter.
 */
@property (nullable, nonatomic, strong) NSArray<NSString *> *delimiters;

/**
 *  Only useful in SFormatterTypeCustom, it will not work if set value in other type.
 *  SFormatterTypeCreditCard   default is @" " and it's immutable
 *  SFormatterTypePhoneNumber  default is @" " and it's immutable
 *  SFormatterTypeDate         default is @"/" and it's immutable
 *  SFormatterTypeNumeral      default is @"," and it's immutable
 *  SFormatterTypeCustom       default is @" " and it's mutable
 */
@property (nullable, nonatomic, copy) NSString *delimiter;

@property (nonatomic, assign, readonly) BOOL removeSuffix;

- (NSString *)formatString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
