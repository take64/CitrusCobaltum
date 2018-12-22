//
//  CCImageButton.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/11.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCImageButton.h"

@interface CCImageButton()

#pragma mark - property
//
// property
//
@property UIImageView *imageView;

@end



@implementation CCImageButton

#pragma mark - extends
//
// extends
//

// layoutSubviews
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [[self imageView] setCenter:[self center]];
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithImageView:(UIImageView *)view
{
    self = [super initWithFrame:[view frame]];
    if (self)
    {
        [self setImageView:view];
        [self addSubview:view];
    }
    return self;
}

@end
