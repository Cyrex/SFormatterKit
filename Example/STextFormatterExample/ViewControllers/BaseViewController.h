//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: BaseViewController.h
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import <UIKit/UIKit.h>

@class STextFormatter;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) STextFormatter *formatter;

@property (nonatomic, strong) UITextField *baseField;

- (instancetype)initWithTitle:(NSString *)title;

@end
