//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SDateFormatter.h
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

typedef NS_ENUM(NSUInteger, SDateFormatPattern) {
    SDateFormatPatternYMD = 100,
    SDateFormatPatternMD
};

@interface SDateFormatter : SNormalFormatter

@property (nonatomic) SDateFormatPattern datePattern;

@end

NS_ASSUME_NONNULL_END
