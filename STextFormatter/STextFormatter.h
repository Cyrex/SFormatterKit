//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatter.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UITextField+STextFormatter.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, STextFormatterCategory) {
    STextFormatterCategoryNone = 0,
    STextFormatterCategoryCreditCard,
    STextFormatterCategoryPhoneNumber,
    STextFormatterCategoryDate,
    STextFormatterCategoryNumeral,
    STextFormatterCategoryCustom
};

typedef NS_ENUM(NSUInteger, SCreditCardType) {
    SCreditCardTypeNone = 10,
    SCreditCardTypeVISA,
    SCreditCardTypeAmericanExpress,
    SCreditCardTypeDinersClub,
    SCreditCardTypeMasterCard,
    SCreditCardTypeJCB,
    SCreditCardTypeDiscover
};

typedef NS_ENUM(NSUInteger, SDateFormatPattern) {
    SDateFormatPatternYMD = 100,
    SDateFormatPatternMD
};

typedef NS_ENUM(NSUInteger, SNumeralGroupStyle) {
    SNumeralGroupStyleThousand = 1000,
    SNumeralGroupStyleWan
};

typedef NS_ENUM(NSUInteger, SCustomStringCase) {
    SCustomStringTypeCaseNone = 10000,
    SCustomStringTypeCaseUpper,
    SCustomStringTypeCaseLower
};

@protocol CreditCardDelegate <NSObject>
@optional
- (void)onCreditCardTypeChanged:(SCreditCardType)type;

@end

@interface STextFormatter : NSObject

/**
 *  STextFormatterCategoryCategory, default is STextFormatterCategoryNone.
 */
@property (nonatomic) STextFormatterCategory                   category;

/**
 *  Only useful in STextFormatterCategoryDate, default is SDateFormatPatternYMD.
 */
@property (nonatomic) SDateFormatPattern                       dateFormatPattern;

/**
 *  Only useful in STextFormatterCategoryNumeral, default is SNumeralGroupStyleThousand.
 */
@property (nonatomic) SNumeralGroupStyle                       numeralGroupStyle;

/**
 *  Only useful in STextFormatterCategoryNumeral and STextFormatterCategoryNone.
 *  the length UITextfield's text is less than it. default is INT8_MAX.
 */
@property (nonatomic, assign) NSUInteger                        limitedLength;

/**
 *  Only useful in STextFormatterCategoryCustom.
 *  If it is nil, the function is same as STextFormatterCategoryNone.
 *  @example if you set blocks is @[@1, @2, @3, @4], the UITextField's text will be @"X XX XXX XXXX" when
 *          delimiter or delimiters is nil.
 */
@property (nullable, nonatomic, strong) NSArray<NSNumber *>     *blocks;

/**
 *  Only useful in STextFormatterCategoryCustom.
 *  @example if you set this is @[@".", @".", @"-"], the UITextField's text will be @"X.XX.XXX-XXXX"
 *  careful _delimiters.count = blocks.count - 1. if not, will use delimiter.
 *
 *  It has a higher priority than delimiters.
 */
@property (nullable, nonatomic, strong) NSArray<NSString *>     *delimiters;

/**
 *  STextFormatterCategoryCreditCard   default is @" " and it's immutable
 *  STextFormatterCategoryPhoneNumber  default is @" " and it's immutable
 *  STextFormatterCategoryDate         default is @"/" and it's immutable
 *  STextFormatterCategoryNumeral      default is @"," and it's immutable
 *  STextFormatterCategoryCustom       default is @" " and it's mutable
 */
@property (nullable, nonatomic, copy)   NSString                *delimiter;

/**
 *  Only useful in STextFormatterCategoryCustom.
 *  @example if you set this is @"PREFIX", the UITextField's text will be @"PREFIX" with delimiter.
 */
@property (nullable, nonatomic, copy)   NSString                *prefix;

/**
 *  Only useful in STextFormatterCategoryCustom.
 *  default is SCustomStringTypeCaseNone
 */
@property (nonatomic, assign) SCustomStringCase                 stringCase;

@property (nullable, nonatomic, weak) id<CreditCardDelegate>         creditCardDelegate;

- (nullable instancetype)initWithTextField:(UITextField *)textField;

- (NSString *)formatString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
