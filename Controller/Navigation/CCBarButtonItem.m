//
//  CCBarButtonItem.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBarButtonItem.h"

#import "CitrusCobaltumApplication.h"
#import "CCColor.h"
#import "CCTheme.h"

@implementation CCBarButtonItem

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        CCThemeNavigationBar *theme = [[CitrusCobaltumApplication callTheme] callNavigationBar];
        [self setTintColor:[CCColor colorWithHEXString:[theme callItemColor]]];
    }
    return self;
}

@end
