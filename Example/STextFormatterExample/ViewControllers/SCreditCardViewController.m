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

@property (nonatomic, strong) UIImageView *creditCardImage;

@end

@implementation SCreditCardViewController
#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        self.formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        
        self.formatter.category = STextFormatterCategoryCreditCard;
        self.formatter.creditCardDelegate = self;
        self.formatter.delegate  = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.creditCardImage];
}


#pragma mark - CreditCardDelegate
- (void)onCreditCardTypeChanged:(SCreditCardType)type {
    switch (type) {
        case SCreditCardTypeNone:
            self.creditCardImage.image = nil;
            NSLog(@"CreditCardTypeNone");
            break;
        case SCreditCardTypeVISA:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_visa"];
            NSLog(@"CreditCardTypeVISA");
            break;
        case SCreditCardTypeAmericanExpress:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_amex"];
            NSLog(@"CreditCardTypeAmericanExpress");
            break;
        case SCreditCardTypeDinersClub:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_diners"];
            NSLog(@"CreditCardTypeDinersClub");
            break;
        case SCreditCardTypeMasterCard:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_mastercard"];
            NSLog(@"CreditCardTypeMasterCard");
            break;
        case SCreditCardTypeJCB:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_jcb"];
            NSLog(@"CreditCardTypeJCB");
            break;
        case SCreditCardTypeDiscover:
            self.creditCardImage.image = [UIImage imageNamed:@"stp_card_discover"];
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


#pragma mark - Getters
- (UIImageView *)creditCardImage {
    if (!_creditCardImage) {
        _creditCardImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 64, 42)];
    }
    
    return _creditCardImage;
}

@end
