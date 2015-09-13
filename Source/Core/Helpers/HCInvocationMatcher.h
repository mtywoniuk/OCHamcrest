//  OCHamcrest by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2015 hamcrest.org. See LICENSE.txt

#import <OCHamcrest/HCBaseMatcher.h>


/*!
 * @abstract Supporting class for matching a feature of an object.
 * @discussion Tests whether the result of passing a given invocation to the value satisfies a given matcher.
 */
@interface HCInvocationMatcher : HCBaseMatcher
{
    NSInvocation *_invocation;
    id <HCMatcher> _subMatcher;
}

/*!
 * @abstract Determines whether a mismatch will be described in short form.
 * @discussion Default is long form, which describes the object, the name of the invocation, and the
 * sub-matcher's mismatch diagnosis. Short form only has the sub-matcher's mismatch diagnosis.
 */
@property (nonatomic, assign) BOOL shortMismatchDescription;

/*!
 * @abstract Initializes a newly allocated HCInvocationMatcher with an invocation and a matcher.
 */
- (instancetype)initWithInvocation:(NSInvocation *)anInvocation matching:(id <HCMatcher>)aMatcher;

/*!
 * @abstract Invokes stored invocation on given item and returns the result.
 */
- (id)invokeOn:(id)item;

/*!
 * @abstract Returns string representation of the invocation's selector.
 */
- (NSString *)stringFromSelector;

@end
