//
//  LGClient.m
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"
#import "LGCoreDataManager.h"

@implementation LGClient

-(id)init
{
    if (self = [super init])
    {
        // initialize AFNetworking HTTPClient
        NSURL *baseURL = [NSURL URLWithString:@"http://chaoshennen.de"];
        
        [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
        
        
        // initialize RestKit
        self.objectManager = [RKObjectManager managerWithBaseURL:baseURL];
        
        [self.objectManager setRequestSerializationMIMEType:@"application/json"];
        [self.objectManager setAcceptHeaderWithMIMEType:@"application/json"];
        [self.objectManager.HTTPClient setDefaultHeader:@"Content-Type" value:@"application/json"];
        
        self.objectManager.managedObjectStore = [LGCoreDataManager sharedInstance].managedObjectStore;
    }
    return self;
}

@end
