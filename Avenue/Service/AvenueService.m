//
//  AvenueService.m
//  Avenue
//
//  Created by Ana Finotti on 3/27/16.
//  Copyright © 2016 Finotti. All rights reserved.
//

#import "AvenueService.h"
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "Utils.h"
#import "Sf.h"

@implementation AvenueService


+(void)getSf:(NSString *)searchText
        success:(void (^)(Sf *sfResponse))success
      failure:(void (^)(NSError *error))failure {
    
    NSString* serverAddress = [Utils getConfigurationValueForKey:@"serverAddress"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSTimeInterval timeInterval = 15;
    manager.requestSerializer.timeoutInterval = timeInterval;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary *params = @{@"sf":searchText};
    [manager GET:serverAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);

        NSError *error = nil;
        NSArray* sfs = [Sf arrayOfModelsFromDictionaries:responseObject error:&error];
        
        Sf *sf = [[Sf alloc] init];
        sf = [sfs firstObject];
        
        success(sf);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}

@end
