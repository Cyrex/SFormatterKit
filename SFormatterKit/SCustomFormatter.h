//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SCustomFormatter.h
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

typedef NS_ENUM(NSUInteger, SCustomStringCase) {
    SCustomStringTypeCaseNone = 10000,
    SCustomStringTypeCaseUpper,
    SCustomStringTypeCaseLower
};

@interface SCustomFormatter : SNormalFormatter

/**
 *  default is SCustomStringTypeCaseNone
 */
@property (nonatomic, assign) SCustomStringCase stringCase;

@end

NS_ASSUME_NONNULL_END
