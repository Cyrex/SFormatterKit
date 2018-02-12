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
#import "STextFormatter.h"

@interface SCustomViewController ()

@property (nonatomic, strong) STextFormatter   *formatter;


@end

@implementation SCustomViewController
#pragma mark - Init
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        _formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        _formatter.category = STextFormatterCategoryCustom;
        _formatter.blocks = [NSArray arrayWithObjects:@1, @2, @3, nil];
        _formatter.delimiter = @"-";
    }
    
    return self;
}


#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
