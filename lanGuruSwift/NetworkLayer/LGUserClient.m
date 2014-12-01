//
//  LGUserClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGUserClient.h"
#import <RestKit/RestKit.h>
#import "LGCoreDataManager.h"
#import "lanGuruSwift-Swift.h"

@implementation LGUserClient

- (void) updateFriendsDetailsWithCompletion:(void (^)(BOOL success))success
{
    //get responseDescripter from UserClass
    RKResponseDescriptor *responseDescriptor = [User responseDescriptorForUserDetails];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSMutableArray *facebookFriendsIDs = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookFriends"];
    if (facebookFriendsIDs.count < 1)
    {
        success(NO);
        return;
    }
    
    NSDictionary *userDict = @{@"fbids" : facebookFriendsIDs};
    
    // POST to create
    [self.objectManager postObject:nil path:@"/matchmaking/update-friend-details" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        [[LGCoreDataManager sharedInstance] saveContext];
        success(YES);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        NSLog(@"Request Operation failed': %@", error);
        success(NO);
    }];
}

@end
