//
//  PNTUtility.m
//  ShapeButtons
//
//  Created by Josip Ćavar on 10/01/14.
//  Copyright (c) 2014 Planet 1107. All rights reserved.
//

#import "PNTUtility.h"

@implementation PNTUtility

// top, right, left, bottom
CGPoint points1[4] = {{10, 1}, {160, 10}, {0, 10}, {10, 160}};
CGPoint points2[4] = {{310, 1}, {10, 160}, {150, 160}, {160, 10}};
CGPoint points3[4] = {{160, 150}, {160, 310}, {0, 310}, {310, 160}};

+ (instancetype)sharedUtility {
    
    static PNTUtility *sharedUtility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtility = [[PNTUtility alloc] init];
    });
    return sharedUtility;
}

- (UIBezierPath *)bezierPathForButton:(UIButton *)button {
    
    NSInteger index = [self.buttons indexOfObject:button];
    CGPoint point1  = points1[index % 4];
    CGPoint point2 = points2[(index) % 4];
    CGPoint point3  = points3[index % 4];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:point1];
    [bezierPath addLineToPoint:point2];
    [bezierPath addLineToPoint:point3];
    [bezierPath closePath];
    return bezierPath;
}

@end
