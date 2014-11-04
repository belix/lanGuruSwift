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

-(void)searchForOpponentForUser:(id)user withCompletion:(void (^)(id Match))returnMatch
{

    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *userDict = @{@"userid" : ((User*)user).userID,
                               @"username" : ((User*)user).username,
                               @"ranking" : ((User*)user).ranking,
                               @"nativelang" : @"DE",
                               @"foreignlang" : @"EN"};

    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/find-random-opponent" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        
        NSLog(@"match %@",operation.HTTPRequestOperation.responseString);
       
        
        returnMatch(match);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        returnMatch(nil);
    
        NSLog(@"operation %@",operation.HTTPRequestOperation.responseString);

    }];
}

-(void)checkForFriendChallenge:(id)friend fromUser:(id)user withCompletion:(void (^)(NSInteger matchID))returnMatchID
{
    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *userDict = @{@"userid1" : ((User*)user).userID,
                               @"username1" : ((User*)user).username,
                               @"nativelang1" : @"DE",
                               @"ranking1" : ((User*)user).ranking,
                               @"userid2" : ((User*)friend).userID,
                               @"foreignlang" : @"EN"};
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/request-friend" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        NSLog(@"match %@",operation.HTTPRequestOperation.responseString);
        returnMatchID(match.identity);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
        NSLog(@"operation %@",operation.HTTPRequestOperation.responseString);
        returnMatchID(0);
        
    }];
    
}


-(void)challengeFriendForMatch:(NSInteger)matchID andStatus:(NSInteger)status withCompletion:(void (^)(id Match))returnMatch;
{
    
    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *userDict = @{@"matchID" : @(matchID),
                               @"status" : @(status)};
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/challenge-friend" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        
        NSLog(@"match %@",operation.HTTPRequestOperation.responseString);
        returnMatch(match);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        returnMatch(nil);
        
        NSLog(@"operation %@",operation.HTTPRequestOperation.responseString);
        
    }];
}





@end
