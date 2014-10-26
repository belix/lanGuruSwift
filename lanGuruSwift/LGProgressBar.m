//
//  LGProgressBar.m
//  LanGuru
//
//  Created by Felix Belau on 01.07.14.
//  Copyright (c) 2014 Bob Schlund Studios. All rights reserved.
//

#import "LGProgressBar.h"

@implementation LGProgressBar{
    BOOL _imageIsRed;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViews];
    }
    return self;
}

- (void)setPercent:(float)p {
    _percent = p;
    _flashImage.frame = CGRectMake(0, 0, self.frame.size.width * p, self.frame.size.height);
    if (p <= 0.2f && !_imageIsRed) {
        [_flashImage setImage:[UIImage imageNamed:@"Zeitbalken_rot.png"]];
    }
}

-(void)setupViews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    _percent = 0.0f;
    self.backgroundColor = [UIColor clearColor];
    UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Zeitbalkenweiß72.png"]];
    im.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:im];
    
    _flashImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Zeitbalken_blau.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0)]];
    _flashImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_flashImage];
}


@end
