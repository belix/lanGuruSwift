//
//  LGVocabularyClient.h
//  lanGuruSwift
//
//  Created by Felix Belau on 23.10.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

#import "LGClient.h"

@interface LGVocabularyClient : LGClient

-(void)downloadVocabularyWithCompletion:(void (^)(BOOL success))success;

@end
