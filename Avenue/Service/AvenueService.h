//
//  AvenueService.h
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sf.h"

@interface AvenueService : NSObject

+(void)getSf:(NSString *)searchText
      success:(void (^)(Sf *sfResponse))success
      failure:(void (^)(NSError *error))failure;

@end
