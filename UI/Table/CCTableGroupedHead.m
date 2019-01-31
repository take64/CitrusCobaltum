//
//  CCTableGroupedHead.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/18.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableGroupedHead.h"

#import "CitrusCobaltumApplication.h"
#import "CitrusCobaltumTypedef.h"
#import "CCStyle.h"
#import "CCTheme.h"



@interface CCTableGroupedHead()

@end



@implementation CCTableGroupedHead

#pragma mark - synthesize
//
// synthesize
//
@synthesize cellView;



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
        // テーマ
        CCThemeTableView *theme = [[CitrusCobaltumApplication callTheme] callTableView];
        // ヘッダビュー
        [self setCellView:[[CCControl alloc] initWithStyleKeys:@{
                                                                 @"width"           :@"320",
                                                                 @"height"          :@"24",
                                                                 @"text-align"      :@"left",
                                                                 @"font-weight"     :@"bold",
                                                                 @"font-size"       :@"16",
                                                                 @"color"           :[theme callHeadTextColor],
                                                                 @"padding"         :@"0 0 0 16",
                                                                 @"background-color":[theme callHeadBackgroundColor],
                                                                 }]];
        [self addSubview:[self cellView]];
    }
    return self;
}

- (void) layoutSubviews
{
    // 自動で高さ調節しておく
    CGRect rect = [self frame];
    [[[self cellView] callStyle] addStyleKeys:@{
                                                @"width"    :CCStr(rect.size.width),
                                                @"height"   :CCStr(rect.size.height),
                                                }];
}



#pragma mark - method
//
// method
//

// テキストの設定
- (void) setText:(NSString *)textString
{
    [[self cellView] setTitle:textString];
}

// 色の設定
- (void) setTintColor:(NSString *)tintColorString
{
    [[[self cellView] callStyle] addStyleKey:@"background-color" value:tintColorString];
}

@end
