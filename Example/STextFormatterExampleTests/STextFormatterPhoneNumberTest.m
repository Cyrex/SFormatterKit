//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterPhoneNumberTest.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      02/13/2018: Created by Cyrex on 02/13/2018
//

@import Quick;
@import Nimble;

#import "SPhoneNumberViewController.h"

QuickSpecBegin(STextFormatterPhoneNumberTest)
    __block SPhoneNumberViewController *viewController = nil;

    beforeEach(^{
        viewController = [[SPhoneNumberViewController alloc] initWithTitle:@"Phone Number"];
    });

    describe(@"SPhoneNumberViewController", ^{
        beforeEach(^{
            [viewController viewDidLoad];
        });
    
        it(@"text formatter should not be nil", ^{
            expect(viewController.formatter).notTo(beNil());
        });
    });
QuickSpecEnd
