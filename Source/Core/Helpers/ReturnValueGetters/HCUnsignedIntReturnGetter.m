// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import "HCUnsignedIntReturnGetter.h"


@implementation HCUnsignedIntReturnGetter

- (instancetype)initWithSuccessor:(nullable HCReturnValueGetter *)successor
{
    self = [super initWithType:@encode(unsigned int) successor:successor];
    return self;
}

- (id)returnValueFromInvocation:(NSInvocation *)invocation
{
    unsigned int value;
    [invocation getReturnValue:&value];
    return @(value);
}

@end
