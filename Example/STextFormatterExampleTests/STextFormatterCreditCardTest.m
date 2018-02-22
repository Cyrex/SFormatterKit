//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterCreditCardTest.m
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

#import "SCreditCardViewController.h"

QuickSpecBegin(STextFormatterCreditCardTest)
    __block SCreditCardViewController *viewController = nil;

    beforeEach(^{
        viewController = [[SCreditCardViewController alloc] initWithTitle:@"Credit Card"];
    });

    describe(@"SCreditCardViewController", ^{
        beforeEach(^{
            [viewController viewDidLoad];
        });

        it(@"text formatter should not be nil", ^{
            expect(viewController.formatter).notTo(beNil());
        });

        it(@"asd", ^{
            [viewController.baseField setText:@"4662"];
            expect(viewController.baseField.text).to(equal(@"4662"));
        });
    });
QuickSpecEnd
