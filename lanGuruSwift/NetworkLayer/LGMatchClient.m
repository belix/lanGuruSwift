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

#pragma mark internal

- (NSString*) timeStamp
{
    NSString *temp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    return [temp substringWithRange:NSMakeRange(0, [temp rangeOfString:@"."].location)] ;
}

#pragma mark public

-(void)updateMatchScore:(NSDictionary*) matchDictionary withCompletion:(void (^)(NSInteger opponentScore))returnOpponentScore
{
    NSMutableDictionary *mutableMatchDictionary = [NSMutableDictionary dictionaryWithDictionary:matchDictionary];
    mutableMatchDictionary[@"timestamp"] = [self timeStamp];
    
    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/ping-server" parameters:mutableMatchDictionary success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];
        returnOpponentScore(match.opponentScore);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
    }];
}

-(void)sendFinalMatchResults:(NSDictionary*)matchResults withCompletion:(void (^)(id Match))returnMatch
{
    //get responseDescripter from Match Class
    RKResponseDescriptor *responseDescriptor = [Match responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/finish-match" parameters:matchResults success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"responste %@",operation.HTTPRequestOperation.responseString);
        NSLog(@"FINIIISH %@",[[mappingResult dictionary] valueForKey:@"match"]);
        Match *match = [[mappingResult dictionary] valueForKey:@"match"];

        returnMatch(match);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        
        NSLog(@"ERRROR %@",operation.HTTPRequestOperation.responseString);
        
        returnMatch(nil);
    }];
}

-(void)closeMatch:(NSDictionary *)matchDictionary
{    
    NSError *error;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:matchDictionary options:kNilOptions error:&error];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: @"http://chaoshennen.de/matchmaking/close-match"]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: postData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^( NSURLResponse * response, NSData * data, NSError * error )
     {
     }
     ];
}


@end
