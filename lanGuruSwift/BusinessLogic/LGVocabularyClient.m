//
//  LGVocabularyClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGVocabularyClient.h"
#import "lanGuruSwift-Swift.h"

@implementation LGVocabularyClient


-(void)downloadVocabularyWithCompletion:(void (^)(BOOL success))success
{
    //get responseDescripter from Words Class
    RKResponseDescriptor *responseDescriptor = [Word responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    [self.objectManager getObjectsAtPath:@"/matchmaking/getwords"
                              parameters:nil
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     
                                     NSLog(@"result %@",mappingResult.array);
                                     [[LGCoreDataManager sharedInstance] saveContext];
                                     [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"vocabularyDownloaded"];
                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                //     success(YES);
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                     NSLog(@"Request operation failed': %@", error);
                                   //  success(NO);
                                 }];
}

@end
