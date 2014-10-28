//
//  LGMatchClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGMatchClient.h"
#import "lanGuruSwift-Swift.h"

@implementation LGMatchClient

-(void)updateMatchScore:(NSDictionary*) matchDictionary{

    //get responseDescripter from Words Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/ping-server" parameters:matchDictionary success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"SCHLUUUUND %@",operation.HTTPRequestOperation.responseString);
        NSLog(@"UPDAAATE %@",[[mappingResult dictionary] valueForKey:@"match"]);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
    }];
}

@end
