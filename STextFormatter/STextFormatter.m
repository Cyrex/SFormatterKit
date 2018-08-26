//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//

#import "NSString+STextFormatter.h"

// starts with 4; 16 digits
NSString *const SVISAReg = @"^4\\d{0,15}";

// starts with 34/37; 15 digits
NSString *const SAmericanExpressReg = @"^3[47]\\d{0,13}";

// starts with 2131/1800/35; 16 digits
NSString *const SJCBReg = @"^(?:2131|1800|(35\\d{0,2}))\\d{0,12}";

// starts with 300-305/309 or 36/38/39; 14 digits
NSString *const SDinersClubReg = @"^3(?:0([0-5]|9)|[689]\\d?)\\d{0,11}";

// starts with 6011/65/644-649; 16 digits
NSString *const SDiscoverReg = @"^(?:6011|65\\d{0,2}|64[4-9]\\d?)\\d{0,12}";

// starts with 51-55/22-27; 16 digits
NSString *const SMasterCardReg = @"^(5[1-5]|2[2-7])\\d{0,14}";

#define SCreditCardPre(type, string) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", S##type##Reg] evaluateWithObject:string]

@interface STextFormatter () <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger preLen;
@property (nonatomic, weak) UITextField *field;

@property (nonatomic, assign) BOOL shouldDeleteSuffix;
@property (nonatomic, strong) NSString *deleteString;

@property (nonatomic) SCreditCardType creditCardType;

@end

@implementation STextFormatter
#pragma mark - Life Cycle
- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [super init]) {
        textField.delegate  = self;
        self.shouldDeleteSuffix = NO;
        self.deleteString       = @"";
        self.stringCase         = SCustomStringTypeCaseNone;
        _field                  = textField;
        _limitedLength          = INT8_MAX;
    }

    return self;
}


#pragma mark - Public Methods
- (NSString *)formatString:(NSString *)string {
    NSString *noDelimiterStr = [string stringByReplacingOccurrencesOfString:self.delimiter withString:@""];

    if (STextFormatterCategoryCreditCard == self.category) {
        BOOL creditCardTypeChanged = NO;
        if ([self creditCardTypeJudge:noDelimiterStr] != self.creditCardType) {
            creditCardTypeChanged = YES;
            self.creditCardType = [self creditCardTypeJudge:noDelimiterStr];
        }

        if (creditCardTypeChanged && [self.creditCardDelegate respondsToSelector:@selector(onCreditCardTypeChanged:)]) {
            [self.creditCardDelegate onCreditCardTypeChanged:self.creditCardType];
        }
    }

    NSString *newString = nil;
    switch (self.category) {
        case STextFormatterCategoryCreditCard: {
            NSString *tmp = [noDelimiterStr splitStringWithBlocks:self.blocks delimiter:self.delimiter andPrefix:nil];
            if ([tmp hasSuffix:self.delimiter] && self.shouldDeleteSuffix) {
                newString = [tmp substringToIndex:tmp.length - 1];
            } else {
                newString = tmp;
            }
        }
            break;
        case STextFormatterCategoryDate: {
            NSString *tmp = [_field.text formatterDateWithPattern:self.dateFormatPattern andDelimiter:self.delimiter];
            if ([self.deleteString isEqualToString:self.delimiter] && self.shouldDeleteSuffix) {
                newString = [tmp substringToIndex:tmp.length - 2];
            } else {
                newString = tmp;
            }
        }
            break;
        case STextFormatterCategoryPhoneNumber:
        case STextFormatterCategoryNumeral:
        case STextFormatterCategoryCustom:
        case STextFormatterCategoryNone:
            break;
    }

    self.preLen = newString.length;

    return newString;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.shouldDeleteSuffix = (range.length >= 1);
    if (self.shouldDeleteSuffix) {
        self.deleteString = [_field.text substringWithRange:range];
    }
    if (range.length >= 1 || [self canEdit:[_field.text stringByReplacingCharactersInRange:range withString:string]]) {
        return YES;
    }

    return NO;
}


#pragma mark - Private Methods
- (SCreditCardType)creditCardTypeJudge:(NSString *)string {
    if (SCreditCardPre(VISA, string)) {
        return SCreditCardTypeVISA;
    } else if (SCreditCardPre(AmericanExpress, string)) {
        return SCreditCardTypeAmericanExpress;
    } else if (SCreditCardPre(JCB, string)) {
        return SCreditCardTypeJCB;
    } else if (SCreditCardPre(DinersClub, string)) {
        return SCreditCardTypeDinersClub;
    } else if (SCreditCardPre(Discover, string)) {
        return SCreditCardTypeDiscover;
    } else if (SCreditCardPre(MasterCard, string)) {
        return SCreditCardTypeMasterCard;
    }

    return SCreditCardTypeNone;
}

- (BOOL)canEdit:(NSString *)string {
    if (STextFormatterCategoryNumeral == _category) {
        return string.length <= self.limitedLength ? YES : NO;
    }

    if (nil == self.blocks) {
        return YES;
    }

    NSInteger count = self.blocks.count - 1;
    for (NSNumber *index in self.blocks) {
        count += index.integerValue;
    }

    if (string.length <= count) {
        return YES;
    }

    return NO;
}


#pragma mark - Getters
- (NSString *)delimiter {
    switch (_category) {
        case STextFormatterCategoryNone:
        case STextFormatterCategoryCreditCard:
        case STextFormatterCategoryPhoneNumber:
            return @" ";
        case STextFormatterCategoryDate:
            return @"/";
        case STextFormatterCategoryNumeral:
            return @",";
        case STextFormatterCategoryCustom:
            if (_delimiter) {
                return _delimiter;
            }
    }

    return @"";
}

- (NSArray<NSNumber *> *)blocks {
    switch (_category) {
        case STextFormatterCategoryNumeral:
        case STextFormatterCategoryNone:
            return nil;
        case STextFormatterCategoryCustom:
            return _blocks ? _blocks : nil;
        case STextFormatterCategoryPhoneNumber:
        case STextFormatterCategoryDate:
            switch (_dateFormatPattern) {
                case SDateFormatPatternMD:
                    return @[@2, @2];
                case SDateFormatPatternYMD:
                default:
                    return @[@4, @2, @2];
            }
        case STextFormatterCategoryCreditCard:
            switch (_creditCardType) {
                case SCreditCardTypeDinersClub:
                    return @[@4, @6, @4];
                case SCreditCardTypeAmericanExpress:
                    return @[@4, @6, @5];
                case SCreditCardTypeJCB:
                case SCreditCardTypeVISA:
                case SCreditCardTypeDiscover:
                case SCreditCardTypeMasterCard:
                case SCreditCardTypeNone:
                    return @[@4, @4, @4, @4];
            }
    }
}

@end


