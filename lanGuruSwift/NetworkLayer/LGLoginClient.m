//
//  LGLoginClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGLoginClient.h"
#import <RestKit/RestKit.h>
#import "LGCoreDataManager.h"
#import "lanGuruSwift-Swift.h"

@implementation LGLoginClient

#pragma mark public

-(void)loginForUser:(NSDictionary*)userDict isFacebookLogin:(BOOL)isFacebookLogin completion:(void (^)(BOOL success))success
{

    //get responseDescripter from UserClass
    RKResponseDescriptor *responseDescriptor = [User responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSString *path = (isFacebookLogin ? @"/registration/login-fbuser" :@"/registration/login-user");
    
    //server request - with completion block
    [self.objectManager postObject:nil path:path parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        NSLog(@"result %@",mappingResult.array);

        User *user = mappingResult.array[0];
        [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"localUserID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //save to coreData
        [[LGCoreDataManager sharedInstance] saveContext];
        
        success(YES);
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        NSLog(@"Request operation failed?': %@", error);
        success(NO);
    }];
}

-(void)registerUser:(NSDictionary*)userDict completion:(void (^)(BOOL success))success
{
    
    //get responseDescripter from UserClass
    RKResponseDescriptor *responseDescriptor = [User responseDescriptor];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    [self.objectManager postObject:nil path:@"/registration/register-user" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        NSLog(@"result %@",mappingResult.array);
        User *user = mappingResult.array[0];
        [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"localUserID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //save to coreData
        [[LGCoreDataManager sharedInstance] saveContext];
        
        success(YES);
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        NSLog(@"Request operation failed': %@", error);
        success(NO);
    }];
    
}

@end
