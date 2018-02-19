//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterNumeralTest.m
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

#import "SNumeralViewController.h"

QuickSpecBegin(STextFormatterNumeralTest)
    __block SNumeralViewController *viewController = nil;

    beforeEach(^{
        viewController = [[SNumeralViewController alloc] initWithTitle:@"Numeral"];
    });

    describe(@"SNumeralViewController", ^{
        beforeEach(^{
            [viewController viewDidLoad];
        });
        
        it(@"text formatter should not be nil", ^{
            expect(viewController.formatter).notTo(beNil());
        });
    });
QuickSpecEnd
