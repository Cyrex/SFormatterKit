//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SCreditCardFormatter.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import "SNormalFormatter.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SCreditCardType) {
    SCreditCardTypeNone = 10,
    SCreditCardTypeVISA,
    SCreditCardTypeAmericanExpress,
    SCreditCardTypeDinersClub,
    SCreditCardTypeMasterCard,
    SCreditCardTypeJCB,
    SCreditCardTypeDiscover
};

@protocol SCreditCardDelegate <NSObject>
@optional
- (void)onCreditCardTypeChanged:(SCreditCardType)type;

@end

@interface SCreditCardFormatter : SNormalFormatter

@property (nullable, nonatomic, weak) id<SCreditCardDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
