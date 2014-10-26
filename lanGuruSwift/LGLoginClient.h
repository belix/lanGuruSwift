//
//  LGLoginClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGClient.h"

@interface LGLoginClient : LGClient

-(void)loginForUser:(NSDictionary*)userDict isFacebookLogin:(BOOL)isFacebookLogin completion:(void (^)(BOOL success))success;

-(void)registerUser:(NSDictionary*)userDict completion:(void (^)(BOOL success))success;

@end
