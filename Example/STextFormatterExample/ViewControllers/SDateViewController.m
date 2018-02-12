//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SDateViewController.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/2/12: Created by Cyrex on 2018/2/12
//

#import "SDateViewController.h"
#import "STextFormatter.h"

@interface SDateViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) STextFormatter   *formatter;

@property (nonatomic, strong) UIPickerView      *pickView;

@end

@implementation SDateViewController
#pragma mark - Life Cycle
- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super initWithTitle:title]) {
        _formatter = [[STextFormatter alloc] initWithTextField:self.baseField];
        _formatter.category = STextFormatterCategoryDate;
        
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 150, SCREEN_WIDTH - 100, 40)];
        _pickView.tag = 1000;
        _pickView.dataSource = self;
        _pickView.delegate = self;
        [self.view addSubview:_pickView];
    }
    
    return self;
}


#pragma mark -
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == row) {
        return @"YYYY/MM/DD";
    }
    else {
        return @"MM/DD";
    }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (0 == row) {
        _formatter.dateFormatPattern = SDateFormatPatternYMD;
    } else {
        _formatter.dateFormatPattern = SDateFormatPatternMD;
    }
}

@end
