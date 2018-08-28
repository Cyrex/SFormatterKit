//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SCreditCardFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import "SCreditCardFormatter.h"
#import "NSString+SFormatterKit.h"

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

@interface SCreditCardFormatter ()

@property (nonatomic) SCreditCardType creditCardType;

@end

@implementation SCreditCardFormatter
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        self.type = SFormatterTypeCreditCard;
    }

    return self;
}


#pragma mark - Public Methods
- (NSString *)formatString:(NSString *)string {
    BOOL creditCardTypeChanged = NO;
    if ([self creditCardTypeJudge:string] != self.creditCardType) {
        creditCardTypeChanged = YES;
        self.creditCardType = [self creditCardTypeJudge:string];
    }

    if (creditCardTypeChanged && [self.delegate respondsToSelector:@selector(onCreditCardTypeChanged:)]) {
        [self.delegate onCreditCardTypeChanged:self.creditCardType];
    }

    NSString *newString = nil;
    NSString *tmp = [string splitStringWithBlocks:self.blocks delimiter:self.delimiter andPrefix:nil];
    if ([tmp hasSuffix:self.delimiter] && self.removeSuffix) {
        newString = [tmp substringToIndex:tmp.length - 1];
    } else {
        newString = tmp;
    }

    return string;
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

@end
