// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import <OCHamcrest/HCAssertThat.h>

#import <OCHamcrest/HCIsEqual.h>
#import <OCHamcrest/HCTestFailure.h>
#import <objc/runtime.h>

@import XCTest;


@interface HCXCTestFailureReporterTests : XCTestCase
@property (nonatomic, assign) BOOL interceptFailure;
@property (nonatomic, assign) NSUInteger failureCount;
@property (nonatomic, copy) NSString *failureDescription;
@property (nonatomic, copy) NSString *failureFile;
@property (nonatomic, assign) NSUInteger failureLine;
@property (nonatomic, assign) BOOL failureExpected;
@end

@implementation HCXCTestFailureReporterTests

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"

- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filePath
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected
{
    if (!self.interceptFailure)
        [super recordFailureWithDescription:description inFile:filePath atLine:lineNumber expected:expected];
    else
    {
        self.failureCount += 1;
        self.failureDescription = description;
        self.failureFile = filePath;
        self.failureLine = lineNumber;
        self.failureExpected = expected;
    }
}

#pragma clang diagnostic pop

- (void)test_XCTestCase_withMatch_shouldNotRecordFailure
{
    self.interceptFailure = YES;
    assertThat(@0, equalTo(@0));
    self.interceptFailure = NO;
    
    XCTAssertEqual(self.failureCount, 0U);
}

- (void)test_XCTestCase_withMismatch_shouldRecordFailure
{
    self.interceptFailure = YES;
    assertThat(@1, equalTo(@0));
    self.interceptFailure = NO;
    
    XCTAssertEqual(self.failureCount, 1U);
}

- (void)test_XCTestCase_withMismatch_shouldRecordFailureWithMismatchDescription
{
    NSString *expected = @"EXPECTED";
    NSString *actual = @"ACTUAL";
    NSString *expectedMessage = @"Expected \"EXPECTED\", but was \"ACTUAL\"";
    
    self.interceptFailure = YES;
    assertThat(actual, equalTo(expected));
    self.interceptFailure = NO;
    
    XCTAssertEqualObjects(expectedMessage, self.failureDescription);
}

- (void)test_XCTestCase_withMismatch_shouldRecordFailureWithCurrentFileName
{
    self.interceptFailure = YES;
    assertThat(@1, equalTo(@0));
    self.interceptFailure = NO;
    
    XCTAssertEqualObjects(
            [NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding],
            self.failureFile);
}

- (void)test_XCTestCase_withMismatch_shouldRecordFailureWithCurrentLineNumber
{
    self.interceptFailure = YES;
    NSUInteger assertLine = __LINE__ + 1;
    assertThat(@1, equalTo(@0));
    self.interceptFailure = NO;

    XCTAssertEqual(self.failureLine, assertLine);
}

- (void)test_XCTestCase_withMismatch_shouldRecordFailureAsExpectedMeaningAnAssertionFailure
{
    self.interceptFailure = YES;
    assertThat(@1, equalTo(@0));
    self.interceptFailure = NO;

    XCTAssertTrue(self.failureExpected);
}

@end
