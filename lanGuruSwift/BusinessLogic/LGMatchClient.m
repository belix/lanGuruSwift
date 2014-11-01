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

- (NSString*) timeStamp {
    NSString *temp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    return [temp substringWithRange:NSMakeRange(0, [temp rangeOfString:@"."].location)] ;
}

-(void)updateMatchScore:(NSDictionary*) matchDictionary withCompletion:(void (^)(NSInteger opponentScore))returnOpponentScore{

    
    NSMutableDictionary *mutableMatchDictionary = [NSMutableDictionary dictionaryWithDictionary:matchDictionary];
    mutableMatchDictionary[@"timestamp"] = [self timeStamp];
    
    //get responseDescripter from Words Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/ping-server" parameters:mutableMatchDictionary success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        NSLog(@"schlund %@",operation.HTTPRequestOperation.responseString);
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        if ([[User getLocalUser].username isEqualToString:match.opponent1])
        {
            NSLog(@"match.score2 %li",(long)match.score2);
            returnOpponentScore(match.score2);
            
        }
        else
        {
            NSLog(@"match.score1 %ld",(long)match.score1);
            returnOpponentScore(match.score1);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
    }];
}

-(void)sendFinalMatchResults:(NSDictionary*)matchResults withCompletion:(void (^)(id Match))returnMatch{
    
    //get responseDescripter from Words Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/finish-match" parameters:matchResults success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"FINIIISH %@",[[mappingResult dictionary] valueForKey:@"match"]);
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];

        returnMatch(match);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
        NSLog(@"ERRROR %@",operation.HTTPRequestOperation.responseString);
        
        returnMatch(nil);
    }];
    
}


@end
