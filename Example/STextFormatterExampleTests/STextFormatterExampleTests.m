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
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                 andDelimiter:@" "]).to(equal(@"1234 1234 1234 1234"));
            expect([@"123412341234123" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                andDelimiter:@" "]).to(equal(@"1234 1234 1234 123"));
            expect([@"123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                             andDelimiter:@" "]).to(equal(@"1234 1234 1234 "));
            expect([@"12341234123" splitStringWithBlocks:@[@4, @4, @4, @4]
                                            andDelimiter:@" "]).to(equal(@"1234 1234 123"));
        });
        
        it(@"can split string with prefix using blocks", ^{
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                 andDelimiter:@" "
                                                    HasPrefix:@"S"]).to(equal(@"S1234 1234 1234 1234"));
            expect([@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                 andDelimiter:@" "
                                                    HasPrefix:nil]).to(equal(@"1234 1234 1234 1234"));
        });
        
        it(@"can check date string", ^{
            expect([@"1995" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"1995/"));
            expect([@"199" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"199"));
            expect([@"1995/3" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"1995/03/"));
//            expect([@"1995/1" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"1995/1"));
            expect([@"1995/12/5" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"1995/12/05"));
            expect([@"1995/12/2" checkDate:SDateFormatPatternYMD withDelimiter:@"/"]).to(equal(@"1995/12/2"));
            
            expect([@"5" checkDate:SDateFormatPatternMD withDelimiter:@"/"]).to(equal(@"05/"));
        });
    });
QuickSpecEnd
