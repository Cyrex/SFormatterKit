//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SFViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      08/27/2018: Created by Cyrex on 08/27/2018
//

#import "SFViewController.h"
#import <SFormatterKit/SFormatterKit.h>

@interface SFViewController ()

@property (nonatomic, strong) UITextField *field;

@end

@implementation SFViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SCreditCardFormatter *formatter = [[SCreditCardFormatter alloc] init];

    self.field.textFormatter = formatter;
}

@end
