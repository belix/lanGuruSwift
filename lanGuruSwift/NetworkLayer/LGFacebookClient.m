//
//  LGFacebookClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGFacebookClient.h"
#import "lanGuruSwift-Swift.h"

@implementation LGFacebookClient


#pragma mark internal

-(void)processFriendDetails:(FBGraphObject*)friendDetail{
    NSMutableArray *facebookFriendsIDs = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookFriends"];
    if (!facebookFriendsIDs) {
        facebookFriendsIDs = [[NSMutableArray alloc] init];
    }
    for (FBGraphObject* set in [friendDetail objectForKey:@"data"]) {
        
        if (![facebookFriendsIDs containsObject:[[set objectForKey:@"user"] objectForKey:@"id"]]) {
            [facebookFriendsIDs addObject:[[set objectForKey:@"user"] objectForKey:@"id"]];
        }
        
    }
    
    NSLog(@"facebookFriendsArray %@",facebookFriendsIDs);
    [[NSUserDefaults standardUserDefaults] setObject:facebookFriendsIDs forKey:@"facebookFriends"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self downloadFriendsDetails];
}


- (void) downloadFriendsDetails
{
    //get responseDescripter from UserClass
    RKResponseDescriptor *responseDescriptor = [User responseDescriptorForUserDetails];
    [self.objectManager addResponseDescriptor:responseDescriptor];
    
    NSMutableArray *facebookFriendsIDs = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebookFriends"];
    NSDictionary *userDict = @{@"fbids" : facebookFriendsIDs};
    
    // POST to create
    [self.objectManager postObject:nil path:@"/multimatchmaking/friend-details" parameters:userDict success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        
        [[LGCoreDataManager sharedInstance] saveContext];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error){
        NSLog(@"Request Operation failed': %@", error);
    }];
}


#pragma mark public

-(void)loadFriendsDetails
{
    NSString *scorePath = [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"FacebookAppID"] stringByAppendingString:@"/scores"];
    [FBRequestConnection startWithGraphPath:scorePath
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if(!error){
                                  [self processFriendDetails:result];
                              }
                          }];
}

-(void)downloadProfilePicture
{
    NSString *urlString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=82&height=82", [User getLocalUser].facebookID];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                if (!error) {
                    [User getLocalUser].profilePicture = [data base64EncodedStringWithOptions:kNilOptions];
                    [[LGCoreDataManager sharedInstance] saveContext];
                    [self downloadCoverPicture];
                }
                
            }] resume];
}

-(void)downloadCoverPicture
{
    NSString *coverUrl = [NSString stringWithFormat:@"https://graph.facebook.com/%@?fields=cover", [User getLocalUser].facebookID];
    NSData *mydata = [NSData dataWithContentsOfURL:[NSURL URLWithString:coverUrl]];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:mydata
                          options:kNilOptions
                          error:&error];
    NSString *coverPictureURL = [[json objectForKey:@"cover"] objectForKey:@"source"];
    
    if (coverPictureURL)
    {
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithURL:[NSURL URLWithString:coverPictureURL]
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (!error) {
                        [User getLocalUser].coverPicture = [data base64EncodedStringWithOptions:kNilOptions];;
                        [[LGCoreDataManager sharedInstance] saveContext];
                        [self uploadProfileAndCoverPicture];
                    }
                    
                }] resume];
    }
}


-(void)uploadProfileAndCoverPicture
{
    User *user = [User getLocalUser];
    
    NSDictionary *userDict = @{@"userid" : user.userID,
                               @"coverpic" : user.coverPicture,
                               @"profilepic" : user.profilePicture};
    
    NSError *error;
    NSData* postData = [NSJSONSerialization dataWithJSONObject:userDict options:kNilOptions error:&error];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: @"http://chaoshennen.de/registration/save-pictures"]];
    
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
         if (!error) {
             NSLog(@"pictures successfully uploaded");
         }
     }
     ];
}

@end
