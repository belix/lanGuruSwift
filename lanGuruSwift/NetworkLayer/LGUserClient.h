//
//  LGUserClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"

@interface LGUserClient : LGClient

- (void) updateFriendsDetailsWithCompletion:(void (^)(BOOL success))success;

@end
