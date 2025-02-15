// OCHamcrest by Jon Reid, https://qualitycoding.org
// Copyright 2022 hamcrest.org. https://github.com/hamcrest/OCHamcrest/blob/main/LICENSE.txt
// SPDX-License-Identifier: BSD-2-Clause

#import "HCArgumentCaptor.h"


@interface HCArgumentCaptor ()
@property (nonatomic, strong, readonly) NSMutableArray *values;
@end

@implementation HCArgumentCaptor

@dynamic allValues;
@dynamic value;

- (instancetype)init
{
    self = [super initWithDescription:@"<Capturing argument>"];
    if (self)
    {
        _values = [[NSMutableArray alloc] init];
        _captureEnabled = YES;
    }
    return self;
}

- (BOOL)matches:(nullable id)item
{
    [self capture:item];
    return [super matches:item];
}

- (void)capture:(id)item
{
    if (self.captureEnabled)
    {
        id value = item ?: [NSNull null];
        if ([value conformsToProtocol:@protocol(NSCopying)])
            value = [value copyWithZone:nil];
        [self.values addObject:value];
    }
}

- (id)value
{
    if (!self.values.count)
        return nil;
    return self.values.lastObject;
}

- (NSArray *)allValues
{
    return [self.values copy];
}

@end
