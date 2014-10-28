//
//  LGMatchmakingClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 28.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"

@interface LGMatchmakingClient : LGClient

-(void)searchForOpponentForUser:(id)user withCompletion:(void (^)(id Match))returnMatch;


@end
