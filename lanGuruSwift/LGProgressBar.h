//
//  LGProgressBar.h
//  LanGuru
//
//  Created by Felix Belau on 01.07.14.
//  Copyright (c) 2014 Bob Schlund Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGProgressBar : UIView{
    UIImageView *_flashImage;
}

@property(nonatomic) float percent;

- (void)setupViews;

@end
