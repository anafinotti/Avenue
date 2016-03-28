//
//  Sf.h
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Lfs.h"

@protocol Sf

@end

@interface Sf : JSONModel

@property (nonatomic, strong) NSString *sf;
@property (nonatomic, strong) NSArray<Lfs> *lfs;

@end
