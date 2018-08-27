//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SNormalFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import "SNormalFormatter.h"

@interface SNormalFormatter ()

@property (nonatomic, assign, readwrite) BOOL shouldDeleteSuffix;

@end

@implementation SNormalFormatter
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        ;
    }

    return self;
}


#pragma mark - Public Methods
- (NSString *)formatString:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:self.delimiter withString:@""];
}

@end
