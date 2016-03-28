//
//  Lfs.h
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Vars.h"

@protocol Lfs

@end

@interface Lfs : JSONModel

@property (nonatomic, strong) NSString *lf;
@property (nonatomic, strong) NSNumber *freq;
@property (nonatomic, strong) NSNumber *since;
@property (nonatomic, strong) NSArray <Vars> *vars;

@end
