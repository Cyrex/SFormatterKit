//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: UITextField+SFormatterKit.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SNormalFormatter;

@interface UITextField (SFormatterKit)

@property (nonatomic, strong) SNormalFormatter *textFormatter;

@property (nonatomic, assign) BOOL isFormatting;

-(void)formatCurrentText;

@end

NS_ASSUME_NONNULL_END
