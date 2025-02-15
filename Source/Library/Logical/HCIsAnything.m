// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import "HCIsAnything.h"


@implementation HCIsAnything
{
    NSString *_description;
}

- (instancetype)init
{
    self = [self initWithDescription:@"ANYTHING"];
    return self;
}

- (instancetype)initWithDescription:(NSString *)description
{
    self = [super init];
    if (self)
        _description = [description copy];
    return self;
}

- (BOOL)matches:(nullable id)item
{
    return YES;
}

- (void)describeTo:(id <HCDescription>)aDescription
{
    [aDescription appendText:_description];
}

@end


id HC_anything()
{
    return [[HCIsAnything alloc] init];
}

id HC_anythingWithDescription(NSString *description)
{
    return [[HCIsAnything alloc] initWithDescription:description];
}
