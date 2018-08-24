//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SCustomViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "SCustomViewController.h"
#import <STextFormatter/STextFormatter.h>

@interface SCustomViewController ()

@end

@implementation SCustomViewController
#pragma mark - Init
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        self.formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        self.formatter.category = STextFormatterCategoryCustom;
        self.formatter.blocks = [NSArray arrayWithObjects:@1, @2, @3, nil];
        self.formatter.delimiter = @"-";
    }

    return self;
}


#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
