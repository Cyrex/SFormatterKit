//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: UITextField+SFormatterKit.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/8/27: Created by Cyrex on 2018/8/27
//

#import "UITextField+SFormatterKit.h"
#import "SNormalFormatter.h"

#import <objc/runtime.h>

@implementation UITextField (SFormatterKit)
- (SNormalFormatter *)textFormatter {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTextFormatter:(SNormalFormatter *)textFormatter {
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
