//
//  PNTUtility.h
//  ShapeButtons
//
//  Created by Josip Ćavar on 10/01/14.
//  Copyright (c) 2014 Planet 1107. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PNTUtility : NSObject

@property (strong, nonatomic) NSArray *buttons;

+ (instancetype)sharedUtility;
- (UIBezierPath *)bezierPathForButton:(UIButton *)button;

@end
