//
//  LGFacebookClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGClient.h"

@interface LGFacebookClient : LGClient

-(void)downloadProfilePicture;

-(void)uploadProfileAndCoverPicture;

-(void)loadFriendsDetails;

@end
