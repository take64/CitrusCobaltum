//
//  CCLabel.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCLabel.h"

@implementation CCLabel

#pragma mark - method
//
// method
//

// 表示テキスト変更
- (void) setTitle:(NSString *)titleValue
{
    [super setTitle:titleValue];
    [self setNeedsDisplay];
}

@end
