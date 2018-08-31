//
//  CCTableHeaderView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCTableHeaderView.h"

#import "CitrusCobaltumApplication.h"

#import "CCColor.h"
#import "CCLabel.h"
#import "CCStyle.h"
#import "CCTheme.h"

@implementation CCTableHeaderView

#pragma mark - method

//
// method
//

// 初期化
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        // テーマ
        CCTheme *theme = [CitrusCobaltumApplication callTheme];
        
        // スタイル
        [[[self label] callStyle] addStyleDictionary:@{
                                                       @"color"             :[CCColor hexStringWithColor:[theme callTableCellHeadTextColor]],
                                                       @"background-color"  :[CCColor hexStringWithColor:[theme callTableCellHeadBackColor]]
                                                       }];
    }
    return self;
}

// リサイクルID取得
+ (NSString *)reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CCTableHeaderView_%03ld", (long)section];
}

@end
