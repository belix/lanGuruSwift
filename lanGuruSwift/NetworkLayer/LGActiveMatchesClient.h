//
//  LGActiveMatchesClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 04.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"

@interface LGActiveMatchesClient : LGClient

-(void)getActiveMatchesForUserID:(NSNumber*)userID withCompletion:(void (^)(id matches))returnMatches;

@end
