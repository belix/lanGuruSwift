//
//  LGMatchClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"

@interface LGMatchClient : LGClient

-(void)updateMatchScore:(NSDictionary*) matchDictionary;

-(void)sendFinalMatchResults:(NSDictionary*)matchResults withCompletion:(void (^)(id Match))returnMatch;

@end
