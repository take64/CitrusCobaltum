//
//  CCNavigationController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCNavigationController.h"

#import "CitrusCobaltumApplication.h"
#import "CCColor.h"
#import "CCTheme.h"

@interface CCNavigationController ()

@end

@implementation CCNavigationController

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        // テーマ
        CCThemeNavigationBar *theme = [[CitrusCobaltumApplication callTheme] callNavigationBar];
        
        // ナヴィゲーション
        [[self navigationBar] setBarTintColor:[CCColor colorWithHEXString:[theme callBackgroundColor]]];
        [[self navigationBar] setTitleTextAttributes:@{
                                                       NSForegroundColorAttributeName:[CCColor colorWithHEXString:[theme callTitleColor]],
                                                       }];
    }
    return self;
}

@end
