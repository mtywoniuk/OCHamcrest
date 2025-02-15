// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import <OCHamcrest/HCTestFailureReporterChain.h>

#import <OCHamcrest/HCTestFailureReporter.h>

@import XCTest;


@interface HCTestFailureReporterChainTests : XCTestCase
@end

@implementation HCTestFailureReporterChainTests

- (void)tearDown
{
    [HCTestFailureReporterChain reset];
    [super tearDown];
}

- (void)test_defaultChain_pointsToXCTestIssueHandlerAsHeadOfChain
{
    HCTestFailureReporter *chain = [HCTestFailureReporterChain reporterChain];

    XCTAssertEqualObjects(NSStringFromClass([chain class]), @"HCXCTestIssueFailureReporter");
    XCTAssertNotNil(chain.successor);
}

- (void)test_addReporter_setsHeadOfChainToGivenHandler
{
    HCTestFailureReporter *reporter = [[HCTestFailureReporter alloc] init];

    [HCTestFailureReporterChain addReporter:reporter];

    XCTAssertEqual([HCTestFailureReporterChain reporterChain], reporter);
}

- (void)test_addReporter_setsHandlerSuccessorToPreviousHeadOfChain
{
    HCTestFailureReporter *reporter = [[HCTestFailureReporter alloc] init];
    HCTestFailureReporter *oldHead = [HCTestFailureReporterChain reporterChain];
    
    [HCTestFailureReporterChain addReporter:reporter];
    
    XCTAssertEqual(reporter.successor, oldHead);
}

- (void)test_addReporter_setsHandlerSuccessorEvenIfHeadOfChainHasNotBeenReferenced
{
    HCTestFailureReporter *reporter = [[HCTestFailureReporter alloc] init];

    [HCTestFailureReporterChain addReporter:reporter];

    XCTAssertNotNil(reporter.successor);
}

@end
