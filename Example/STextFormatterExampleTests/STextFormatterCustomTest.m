//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterCustomTest.m
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

#import "SCustomViewController.h"

QuickSpecBegin(STextFormatterCustomTest)
    __block SCustomViewController *viewController = nil;

    beforeEach(^{
        viewController = [[SCustomViewController alloc] initWithTitle:@"Custom"];
    });

    describe(@"SCustomViewController", ^{
        beforeEach(^{
            [viewController viewDidLoad];
        });
        
        it(@"text formatter should not be nil", ^{
            expect(viewController.formatter).notTo(beNil());
        });
    });
QuickSpecEnd
