//
//  Utils.m
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString*)getConfigurationValueForKey:(NSString*)key {
    NSDictionary *mainDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"]];
    
    return [mainDictionary objectForKey:key];
}

@end
