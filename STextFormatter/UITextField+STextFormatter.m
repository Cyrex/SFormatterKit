//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: UITextField+STextFormatter.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/6/29: Created by Cyrex on 2018/6/29
//

#import "UITextField+STextFormatter.h"
#import "STextFormatter.h"

#import <objc/runtime.h>

@implementation UITextField (STextFormatter)
- (STextFormatter *)textFormatter {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTextFormatter:(STextFormatter *)textFormatter {
    objc_setAssociatedObject(self,
                             @selector(textFormatter),
                             textFormatter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (textFormatter) {
        [self addTarget:self
                 action:@selector(handleTextChanged:)
       forControlEvents:UIControlEventEditingChanged];
    } else {
        [self removeTarget:self
                    action:@selector(handleTextChanged:)
          forControlEvents:UIControlEventEditingChanged];
    }
}

- (BOOL)isFormatting {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsFormatting:(BOOL)isFormatting {
    objc_setAssociatedObject(self,
                             @selector(isFormatting),
                             @(isFormatting),
                             OBJC_ASSOCIATION_RETAIN);
}


#pragma mark - PUblic Methods
-(void)formatCurrentText {
    if (!self.textFormatter) {
        return ;
    }

    [self handleTextChanged:nil];
}


#pragma mark - Notifications
- (void)handleTextChanged:(NSNotification *)notification {
    // check for recursion
    if (self.isFormatting) {
        return ;
    }
    self.isFormatting = YES;

    // format text string
    NSString *newString = [self.textFormatter formatString:self.text];
    self.text = newString;

    self.isFormatting = NO;
}

@end
