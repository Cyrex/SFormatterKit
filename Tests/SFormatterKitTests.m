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

#pragma mark - Test
- (void)testSplitStringUsingBlocks {
    NSString *testString = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssert([testString isEqualToString:@"1234 1234 1234 1234"],
              @"NSString+SFormatterKit can't split string using blocks");

    testString = [@"123412341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssert([testString isEqualToString:@"1234 1234 1234 123"],
              @"NSString+SFormatterKit can't split string using blocks");

    testString = [@"123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssert([testString isEqualToString:@"1234 1234 1234 "],
              @"NSString+SFormatterKit can't split string using blocks");

    testString = [@"12341234123" splitStringWithBlocks:@[@4, @4, @4, @4] andDelimiter:@" "];
    XCTAssert([testString isEqualToString:@"1234 1234 123"],
              @"NSString+SFormatterKit can't split string using blocks");

    testString = [@"1222222333" splitStringWithBlocks:@[@1, @6, @3, @4] andDelimiter:@" "];
    XCTAssert([testString isEqualToString:@"1 222222 333 "],
              @"NSString+SFormatterKit can't split string using blocks");
}

- (void)testSplitStringWithPrefixUsingBlocks {
    NSString *testString = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] delimiter:@" " andPrefix:@"S"];
    XCTAssert([testString isEqualToString:@"S1234 1234 1234 1234"],
              @"NSString+SFormatterKit can't split string with prefix using blocks");

    testString = [@"1234123412341234" splitStringWithBlocks:@[@4, @4, @4, @4] delimiter:@" " andPrefix:nil];
    XCTAssert([testString isEqualToString:@"1234 1234 1234 1234"],
              @"NSString+SFormatterKit can't split string with prefix using blocks");
}

- (void)testCheckDateString {
    NSString *testString = [@"1995" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/"],
              @"NSString+SFormatterKit can't check date string");

    testString = [@"199" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"199"],
              @"NSString+SFormatterKit can't check date string");

    testString = [@"1995/3" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/03/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/00" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/01/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/13" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/12/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/1" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/1"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/12/5" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/12/05"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/12/2" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/12/2"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1995/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1995/02/28"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"2000/02/29" formatterDateWithPattern:SDateFormatPatternYMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"2000/02/29"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"5" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"05/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"1" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"1"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"12" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"12/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"13" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"12/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"01/9" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"01/09"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"01/"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"02/00" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"02/01"],
              @"NSString+SFormatterKit can't check date strin");

    testString = [@"02/29" formatterDateWithPattern:SDateFormatPatternMD andDelimiter:@"/"];
    XCTAssert([testString isEqualToString:@"02/29"],
              @"NSString+SFormatterKit can't check date strin");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
