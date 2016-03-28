//
//  Sf.m
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import "Sf.h"
#import <JSONKeyMapper.h>

@implementation Sf
+(JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"sf":@"sf",
                                                       @"lfs":@"lfs"}];
}
@end
