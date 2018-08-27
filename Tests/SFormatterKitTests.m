//
//  Copyright © 2018 ZhiweiSun. All rights reserved.
//
//  File name: SFormatterKitTests.m
//  Author:    ZhiweiSun @Cyrex
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2018/6/22: Created by Cyrex on 2018/6/22
//

#import <XCTest/XCTest.h>
#import "NSString+SFormatterKit.h"

@interface SFormatterKitTests : XCTestCase

@end

@implementation SFormatterKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSplitStringUsingBlocks {
    NSString *result = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssertTrue([result isEqualToString:@"1234 1234 1234 1234"],
                  @"can't split string with blocks");

    result = [@"123412341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssertTrue([result isEqualToString:@"1234 1234 1234 123"],
                  @"can't split string with blocks");

    result = [@"123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssertTrue([result isEqualToString:@"1234 1234 1234 "],
                  @"can't split string with blocks");

    result = [@"12341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssertTrue([result isEqualToString:@"1234 1234 123"],
                  @"can't split string with blocks");

    result = [@"1222222333" splitStringWithBlocks:@[@1, @6, @3, @4] andDelimiter:@" "];
    XCTAssertTrue([result isEqualToString:@"1 222222 333 "],
                  @"can't split string with blocks");
}

- (void)testSplitStringWithPrefixUsingBlocks {
    NSString *result = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                                        delimiter:@" "
                                                        andPrefix:@"S"];
    XCTAssertTrue([result isEqualToString:@"S1234 1234 1234 1234"],
                  @"can't split string with prefix using blocks");

    result = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4]
                                              delimiter:@" "
                                              andPrefix:nil];
    XCTAssertTrue([result isEqualToString:@"1234 1234 1234 1234"],
                  @"can't split string with prefix using blocks");
}

- (void)testCheckDateString {
    NSString *result = [@"1995" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/"],
                  @"can't check date string");

    result = [@"199" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"199"],
                  @"can't check date string");
    result = [@"1995/3" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/03/"],
                  @"can't check date string");
    result = [@"1995/00" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/01/"],
                  @"can't check date string");
    result = [@"1995/13" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/12/"],
                  @"can't check date string");
    result = [@"1995/1" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/1"],
                  @"can't check date string");
    result = [@"1995/12/5" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/12/05"],
                  @"can't check date string");
    result = [@"1995/12/2" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/12/2"],
                  @"can't check date string");
    result = [@"1995/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1995/02/28"],
                  @"can't check date string");
    result = [@"2000/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"2000/02/29"],
                  @"can't check date string");

    result = [@"5" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"05/"],
                  @"can't check date string");
    result = [@"1" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"1"],
                  @"can't check date string");
    result = [@"12" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"12/"],
                  @"can't check date string");
    result = [@"13" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"12/"],
                  @"can't check date string");
    result = [@"01/9" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"01/09"],
                  @"can't check date string");
    result = [@"00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"01/"],
                  @"can't check date string");
    result = [@"02/00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"02/01"],
                  @"can't check date string");
    result = [@"02/29" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssertTrue([result isEqualToString:@"02/29"],
                  @"can't check date string");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
