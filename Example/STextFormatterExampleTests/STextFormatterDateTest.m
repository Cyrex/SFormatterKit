//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterDateTest.m
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

#import "SDateViewController.h"

QuickSpecBegin(STextFormatterDateTest)
    __block SDateViewController *viewController = nil;

    beforeEach(^{
        viewController = [[SDateViewController alloc] initWithTitle:@"Date"];
    });

    describe(@"SDateViewController", ^{
        beforeEach(^{
            [viewController viewDidLoad];
        });
        
        it(@"text formatter should not be nil", ^{
            expect(viewController.formatter).notTo(beNil());
        });
        
        it(@"set date", ^{
            [viewController.baseField setText:@"1995"];
            expect(viewController.baseField.text).to(equal(@"1995"));
        });
    });
QuickSpecEnd
