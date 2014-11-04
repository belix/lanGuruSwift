//
//  LGActiveMatchesClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 04.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGActiveMatchesClient.h"
#import "lanGuruSwift-Swift.h"


@implementation LGActiveMatchesClient

-(void)getActiveMatchesForUserID:(NSNumber*)userID withCompletion:(void (^)(id matches))returnMatches;
{
    
    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptorForActiveMatches];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *userDict = @{@"userid" : userID};
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/get-challenges" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSArray *matches = [[mappingResult dictionary] valueForKey:@"matches"];
        
        NSLog(@"match %@",operation.HTTPRequestOperation.responseString);
       // returnMatches(matches);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        //returnMatches(nil);
        NSLog(@"operation %@",operation.HTTPRequestOperation.responseString);
        
    }];
}

@end
