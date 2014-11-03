//
//  LGCoreDataManager.h
//  LanGuru
//
//  Created by Felix Belau on 01.07.14.
//  Copyright (c) 2014 Bob Schlund Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface LGCoreDataManager : NSObject

@property(strong,nonatomic) RKManagedObjectStore *managedObjectStore;

+ (LGCoreDataManager *)sharedInstance;
-(void)setupStoreManager;
-(void)saveContext;

@end
