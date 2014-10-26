//
//  PNTButton.m
//  ShapeButtons
//
//  Created by Josip Ćavar on 10/01/14.
//  Copyright (c) 2014 Planet 1107. All rights reserved.
//

#import "PNTButton.h"
#import "PNTUtility.h"

@implementation PNTButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    if (self.willAnimate) {
        UIBezierPath *path = [[PNTUtility sharedUtility] bezierPathForButton:self];
        [(self.isCorrectClick ? [UIColor colorWithRed:0 green:0.816 blue:0.68 alpha:1.0f] : [UIColor colorWithRed:1.0 green:0.21 blue:0.35 alpha:1.0]) setFill];
        [path fill];
    }
    else{
        UIBezierPath *path = [[PNTUtility sharedUtility] bezierPathForButton:self];
        [[[PNTUtility sharedUtility] colorForButton:self] setFill];
        [path fill];
    }
}

-(void)animatePath:(BOOL)isCorrect{
    UIBezierPath *path = [[PNTUtility sharedUtility] bezierPathForButton:self];
    [(isCorrect ? [UIColor greenColor] : [UIColor redColor]) setFill];
    [path fill];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIBezierPath *path = [[PNTUtility sharedUtility] bezierPathForButton:self];
    if ([path containsPoint:point]) {
        return self;
    } else {
        return nil;
    }
}

@end
