//
//  LGClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface LGClient : NSObject

@property (strong,nonatomic) RKObjectManager *objectManager;

@end
