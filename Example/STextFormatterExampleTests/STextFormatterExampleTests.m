//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: STextFormatterExampleTests.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      02/12/2018: Created by Cyrex on 02/12/2018
//

@import Quick;
@import Nimble;

#import "NSString+STextFormatter.h"

QuickSpecBegin(STextFormatterExampleTest)
    describe(@"NSString+STextFormatter", ^{
        it(@"can split string using blocks", ^{
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "]).to(equal(@"1234 1234 1234 1234"));
            expect([@"123412341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "]).to(equal(@"1234 1234 1234 123"));
            expect([@"123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "]).to(equal(@"1234 1234 1234 "));
            expect([@"12341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "]).to(equal(@"1234 1234 123"));
            expect([@"1222222333" splitStringWithBlocks:@[@1, @6, @3, @4] andDelimiter:@" "]).to(equal(@"1 222222 333 "));
        });

        it(@"can split string with prefix using blocks", ^{
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                    delimiter:@" "
                                                    andPrefix:@"S"]).to(equal(@"S1234 1234 1234 1234"));
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                    delimiter:@" "
                                                    andPrefix:nil]).to(equal(@"1234 1234 1234 1234"));
        });

        it(@"can check date string", ^{
            expect([@"1995" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/"));
            expect([@"199" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"199"));
            expect([@"1995/3" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/03/"));
            expect([@"1995/00" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/01/"));
            expect([@"1995/13" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/12/"));
            expect([@"1995/1" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/1"));
            expect([@"1995/12/5" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/12/05"));
            expect([@"1995/12/2" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/12/2"));
            expect([@"1995/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"1995/02/28"));
            expect([@"2000/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"]).to(equal(@"2000/02/29"));

            expect([@"5" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"05/"));
            expect([@"1" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"1"));
            expect([@"12" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"12/"));
            expect([@"13" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"12/"));
            expect([@"01/9" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"01/09"));
            expect([@"00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"01/"));
            expect([@"02/00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"02/01"));
            expect([@"02/29" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"]).to(equal(@"02/29"));
        });
    });
QuickSpecEnd
