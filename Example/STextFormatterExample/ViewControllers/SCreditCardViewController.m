//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SCreditCardViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "SCreditCardViewController.h"
#import "STextFormatter.h"

@interface SCreditCardViewController () <CreditCardDelegate, TextFiledFormatterDelegate>

@property (nonatomic, strong) STextFormatter   *formatter;

@end

@implementation SCreditCardViewController
#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        _formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        
        _formatter.category = STextFormatterCategoryCreditCard;
        _formatter.creditCardDelegate = self;
        _formatter.delegate  = self;
    }
    
    return self;
}


#pragma mark - CreditCardDelegate
- (void)onCreditCardTypeChanged:(SCreditCardType)type {
    switch (type) {
        case SCreditCardTypeNone:
            NSLog(@"CreditCardTypeNone");
            break;
        case SCreditCardTypeVISA:
            NSLog(@"CreditCardTypeVISA");
            break;
        case SCreditCardTypeAmericanExpress:
            NSLog(@"CreditCardTypeAmericanExpress");
            break;
        case SCreditCardTypeDinersClub:
            NSLog(@"CreditCardTypeDinersClub");
            break;
        case SCreditCardTypeMasterCard:
            NSLog(@"CreditCardTypeMasterCard");
            break;
        case SCreditCardTypeJCB:
            NSLog(@"CreditCardTypeJCB");
            break;
        case SCreditCardTypeDiscover:
            NSLog(@"CreditCardTypeDiscover");
            break;
        default:
            break;
    }
}

- (BOOL)s_textFieldShouldReturn:(UITextField *)textField {
    [self.baseField resignFirstResponder];
    return YES;
}

@end
