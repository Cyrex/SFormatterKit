//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      02/12/2018: Created by Cyrex on 02/12/2018
//

#import "SViewController.h"
#import "SCreditCardViewController.h"
#import "SPhoneNumberViewController.h"
#import "SDateViewController.h"
#import "SNumeralViewController.h"
#import "SCustomViewController.h"

#ifndef ButtonMake
#define ButtonMake(__button, __rect)                    \
__button = [[UIButton alloc] initWithFrame:__rect];     \
__button.layer.cornerRadius  = 20;                      \
__button.layer.masksToBounds = YES;                     \
__button.backgroundColor     = [UIColor whiteColor];    \
[__button setTitleColor:UIColorFromRGB(23, 22, 22)      \
           forState:UIControlStateNormal];

#endif


@interface SViewController ()

@property (nonatomic, strong) UIButton      *creditCard;
@property (nonatomic, strong) UIButton      *phoneNumber;
@property (nonatomic, strong) UIButton      *date;
@property (nonatomic, strong) UIButton      *numberal;
@property (nonatomic, strong) UIButton      *custom;

@end

@implementation SViewController
#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        ;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViews];
}


#pragma mark - Private Methods
- (void)configViews {
    self.view.backgroundColor = UIColorFromRGB(245, 245, 249);
    
    ButtonMake(_creditCard, CGRectMake(40, 100, SCREEN_WIDTH - 80, 40));
    [_creditCard setTitle:@"Credit Card" forState:UIControlStateNormal];
    [_creditCard addTarget:self
                    action:@selector(creditCardTest)
          forControlEvents:UIControlEventTouchUpInside];
    
    ButtonMake(_phoneNumber, CGRectMake(40, 100 + BASE_HEIGHT, SCREEN_WIDTH - 80, 40));
    [_phoneNumber setTitle:@"Phone Number" forState:UIControlStateNormal];
    [_phoneNumber addTarget:self
                     action:@selector(phoneNumberTest)
           forControlEvents:UIControlEventTouchUpInside];
    
    ButtonMake(_date, CGRectMake(40, 100 + 2 * BASE_HEIGHT, SCREEN_WIDTH - 80, 40));
    [_date setTitle:@"Date" forState:UIControlStateNormal];
    [_date addTarget:self
              action:@selector(dateTest)
    forControlEvents:UIControlEventTouchUpInside];
    
    ButtonMake(_numberal, CGRectMake(40, 100 + 3 * BASE_HEIGHT, SCREEN_WIDTH - 80, 40));
    [_numberal setTitle:@"Numberal" forState:UIControlStateNormal];
    [_numberal addTarget:self
                  action:@selector(numberalTest)
        forControlEvents:UIControlEventTouchUpInside];
    
    ButtonMake(_custom, CGRectMake(40, 100 + 4 * BASE_HEIGHT, SCREEN_WIDTH - 80, 40));
    [_custom setTitle:@"Custom" forState:UIControlStateNormal];
    [_custom addTarget:self
                action:@selector(customTest)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_creditCard];
    [self.view addSubview:_phoneNumber];
    [self.view addSubview:_date];
    [self.view addSubview:_numberal];
    [self.view addSubview:_custom];
}


#pragma mark - Action Methods
- (void)creditCardTest {
    SCreditCardViewController *creditVC = [[SCreditCardViewController alloc] initWithTitle:@"Credit Card"];
    [self presentViewController:creditVC animated:YES completion:nil];
}

- (void)phoneNumberTest {
    SPhoneNumberViewController *phoneNumberVC = [[SPhoneNumberViewController alloc] initWithTitle:@"Phone Number"];
    [self presentViewController:phoneNumberVC animated:YES completion:nil];
}

- (void)dateTest {
    SDateViewController *dateVC = [[SDateViewController alloc] initWithTitle:@"Date"];
    [self presentViewController:dateVC animated:YES completion:nil];
}

- (void)numberalTest {
    SNumeralViewController *numberalVC = [[SNumeralViewController alloc] initWithTitle:@"Numberal"];
    [self presentViewController:numberalVC animated:YES completion:nil];
}

- (void)customTest {
    SCustomViewController *customVC = [[SCustomViewController alloc] initWithTitle:@"Custom"];
    [self presentViewController:customVC animated:YES completion:nil];
}

@end
