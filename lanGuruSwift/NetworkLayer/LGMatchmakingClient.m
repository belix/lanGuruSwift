//
//  LGMatchmakingClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGMatchmakingClient.h"
#import "lanGuruSwift-Swift.h"

@implementation LGMatchmakingClient

#pragma mark public

-(void)searchForOpponentForUser:(id)user withCompletion:(void (^)(id Match))returnMatch{

    //get responseDescripter from Words Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *userDict = @{@"user" : @{@"username" : ((User*)user).username,
                                           @"nativelang" : @"de",
                                           @"foreignlang" : @"en"}};

    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/find-opponent" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        NSLog(@"match %@",match);
        returnMatch(match);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        returnMatch(nil);
        NSLog(@"operation %@",operation.HTTPRequestOperation.responseString);

    }];

}


@end
