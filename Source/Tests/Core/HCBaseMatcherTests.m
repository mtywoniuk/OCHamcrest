// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import <OCHamcrest/HCBaseMatcher.h>

#import "MatcherTestCase.h"
#import <OCHamcrest/HCStringDescription.h>


@interface BaseMatcherWithDescription : HCBaseMatcher
@end

@implementation BaseMatcherWithDescription

- (void)describeTo:(id <HCDescription>)description
{
    [description appendText:@"SOME DESCRIPTION"];
}

@end


@interface HCBaseMatcherTests : MatcherTestCase
@end

@implementation HCBaseMatcherTests
{
    BaseMatcherWithDescription *matcher;
}

- (void)setUp
{
    [super setUp];
    matcher = [[BaseMatcherWithDescription alloc] init];
}

- (void)tearDown
{
    matcher = nil;
    [super tearDown];
}

- (void)test_description_shouldDescribeMatcher
{
    XCTAssertEqualObjects(matcher.description, @"SOME DESCRIPTION");
}

- (void)test_shouldSupportImmutableCopying
{
    BaseMatcherWithDescription *matcherCopy = [matcher copy];
    XCTAssertEqual(matcherCopy, matcher);
}

@end


@interface IncompleteBaseMatcher : HCBaseMatcher
@end

@implementation IncompleteBaseMatcher
@end


@interface IncompleteMatcherTests : MatcherTestCase
@end

@implementation IncompleteMatcherTests
{
    IncompleteBaseMatcher *matcher;
}

- (void)setUp
{
    [super setUp];
    matcher = [[IncompleteBaseMatcher alloc] init];
}

- (void)tearDown
{
    matcher = nil;
    [super tearDown];
}

- (void)test_requireSubclassToDefineMatches
{
    XCTAssertThrows([matcher matches:nil]);
}

- (void)test_requireSubclassToDefineDescribeTo
{
    XCTAssertThrows([matcher describeTo:[[HCStringDescription alloc] init]]);
}

@end
