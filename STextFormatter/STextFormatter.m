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

@property (nonatomic) SCreditCardType creditCardType;

@end

@implementation STextFormatter 
#pragma mark - Life Cycle
- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [super init]) {
        textField.delegate  = self;
        self.shouldDeleteSuffix = NO;
        _field                  = textField;
        _limitedLength          = INT8_MAX;
        [_field addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    }
    
    return self;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.shouldDeleteSuffix = (range.length >= 1);
    if (range.length >= 1 || [self canEdit:[_field.text stringByReplacingCharactersInRange:range withString:string]]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldShouldBeginEditing:)]) {
        return [_delegate s_textFieldShouldClear:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldDidBeginEditing:)]) {
        [_delegate s_textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldShouldEndEditing:)]) {
        return [_delegate s_textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldDidEndEditing:)]) {
        [_delegate s_textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldShouldClear:)]) {
        return [_delegate s_textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(s_textFieldShouldReturn:)]) {
        return [_delegate s_textFieldShouldReturn:textField];
    }
    
    return YES;
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

- (void)valueChanged:(NSNotification *)notic {
    NSString *noDelimiterStr = [_field.text stringByReplacingOccurrencesOfString:self.delimiter withString:@""];
    
    if (STextFormatterCategoryCreditCard == _category) {
        BOOL creditCardTypeChanged = NO;
        if (_creditCardType != [self creditCardTypeJudge:noDelimiterStr]) {
            creditCardTypeChanged = YES;
            _creditCardType = [self creditCardTypeJudge:noDelimiterStr];
        }
        
        if (creditCardTypeChanged && [_creditCardDelegate respondsToSelector:@selector(onCreditCardTypeChanged:)]) {
            [_creditCardDelegate onCreditCardTypeChanged:_creditCardType];
        }
    }
//    if (_preLen > _field.text.length) {
//        _preLen = _field.text.length;
//        return ;
//    }
    
    switch (_category) {
        case STextFormatterCategoryCreditCard: {
            NSString *tmp = [noDelimiterStr splitStringWithBlocks:self.blocks delimiter:self.delimiter andPrefix:nil];
            if ([tmp hasSuffix:self.delimiter] && self.shouldDeleteSuffix) {
                _field.text = [tmp substringToIndex:tmp.length - 1];
            } else {
                _field.text = tmp;
            }
        }
            break;
        case STextFormatterCategoryDate:
            _field.text = [_field.text checkDate:_dateFormatPattern andDelimiter:self.delimiter];
            break;
        case STextFormatterCategoryPhoneNumber:
        case STextFormatterCategoryNumeral:
        case STextFormatterCategoryCustom:
        case STextFormatterCategoryNone:
            break;
    }
    
    _preLen = _field.text.length;
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


#pragma mark - Setters
- (void)setCategory:(STextFormatterCategory)category {
    _category = category;
    switch (category) {
        case STextFormatterCategoryPhoneNumber:
        case STextFormatterCategoryCreditCard:
        case STextFormatterCategoryNumeral:
        case STextFormatterCategoryDate:
            _field.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case STextFormatterCategoryCustom:
        case STextFormatterCategoryNone:
        default:
            break;
    }
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


