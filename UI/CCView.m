//
//  CCView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCView.h"

@implementation CCView

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

@end
