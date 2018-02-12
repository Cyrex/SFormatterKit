//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SNumeralViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "SNumeralViewController.h"
#import "STextFormatter.h"

@interface SNumeralViewController ()

@property (nonatomic, strong) STextFormatter   *formatter;

@end

@implementation SNumeralViewController
#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        _formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        _formatter.category = STextFormatterCategoryNumeral;
        _formatter.numeralGroupStyle = SNumeralGroupStyleThousand;
    }
    
    return self;
}


#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
