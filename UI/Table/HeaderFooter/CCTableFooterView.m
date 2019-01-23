//
//  CCTableFooterView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableFooterView.h"

#import "CitrusCobaltumApplication.h"

#import "CCColor.h"
#import "CCLabel.h"
#import "CCStyle.h"
#import "CCTheme.h"

@implementation CCTableFooterView

#pragma mark - method
//
// method
//

// テーマ設定
- (void) bindTheme
{
    // テーマ
    CCThemeTableView *theme = [[CitrusCobaltumApplication callTheme] callTableView];
    [self setLabelColor:[theme callFootTextColor]];
    [self setLabelBackgroundColor:[theme callFootBackgroundColor]];
    
    // 適用
    [super bindTheme];
}



#pragma mark - static method
//
// static method
//

// リサイクルID取得
+ (NSString *) reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CCTableFooterView_%03ld", (long)section];
}

@end
