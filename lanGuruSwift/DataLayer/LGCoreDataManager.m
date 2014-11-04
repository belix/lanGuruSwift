//
//  LGCoreDataManager.m
//  LanGuru
//
//  Created by Felix Belau on 01.07.14.
//  Copyright (c) 2014 Bob Schlund Studios. All rights reserved.
//

#import "LGCoreDataManager.h"

#define BASE_URL @"http://chaoshennen.de"

@implementation LGCoreDataManager

+ (LGCoreDataManager *)sharedInstance
{
    static LGCoreDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[LGCoreDataManager alloc] init];
    });
    return sharedMyManager;
}

// this method is called in the AppDelegate to initialize the store manager
-(void)setupStoreManager
{
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    self.managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    [self.managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"lanGuruSwift.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"lanGuruSwift" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [_managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [self.managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    self.managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:self.managedObjectStore.persistentStoreManagedObjectContext];
}

-(void)saveContext
{
    NSManagedObjectContext *managedObjCtx = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSError *executeError = nil;
    if(![managedObjCtx saveToPersistentStore:&executeError])
    {
        NSLog(@"Failed to save to data store");
    }
}

@end
