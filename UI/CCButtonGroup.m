//
//  CCButtonGroup.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCButtonGroup.h"

#import "CitrusCobaltumApplication.h"
#import "CitrusCobaltumTypedef.h"
#import "CCButton.h"
#import "CCBarButtonItem.h"
#import "CCColor.h"
#import "CCStyle.h"
#import "CCTheme.h"



@interface CCButtonGroup()

#pragma mark - property
//
// property
//
@property NSMutableArray<CCButton *> *buttons;

@end



@implementation CCButtonGroup

#pragma mark - method
//
// method
//

// init
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[[self widthAnchor] constraintEqualToConstant:0] setActive:NO];
        [[[self heightAnchor] constraintEqualToConstant:0] setActive:NO];
    }
    return self;
}

// ボタングループの生成
+ (instancetype) bottunGroup
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

// ボタンの追加
- (void) addButton:(CCButton *)buttonValue
{
    if ([self buttons] == nil)
    {
        [self setButtons:[NSMutableArray array]];
    }

    [[self buttons] addObject:buttonValue];
    [self addSubview:buttonValue];
}

// ボタンの追加(文字列から)
- (CCButton *) addButtonWithTitle:(NSString *)titleString complete:(CCButtonTappedBlock)completeBlock
{
    // アプリケーションテーマ
    CCTheme *theme = [CitrusCobaltumApplication callTheme];
    
    // ボタン
    CCButton *button = [[CCButton alloc] initWithTitle:titleString];
    [button setOnTappedComplete:completeBlock];
    [[button callStyle] addStyleKeys:@{
                                       @"width"             :@"32",
                                       @"height"            :@"16",
                                       @"font-size"         :@"14",
                                       @"padding"           :@"4 8 4 8",
                                       @"color"             :[CCColor hexStringWithColor:[theme callNavigationBarTextColor]],
                                       @"background-color"  :[CCColor hexStringWithColor:[theme callNavigationBarTintColor]],
                                       }];
    [self addButton:button];

    return button;
}

// CTBarButtonItemへ変換
- (CCBarButtonItem *) toBarButtonItem
{
    return [[CCBarButtonItem alloc] initWithCustomView:self];
}



#pragma mark - private
//
// private
//

// 配下のボタンの再配置
- (void) layoutSubviews
{
    CGFloat width = 0;
    CGFloat height = 0;
    CCButton *firstButton = nil;
    CCButton *lastButton = nil;

    // 配下のボタンのサイズ調整
    for (CCButton *button in [self buttons])
    {
        // 非表示のアイテムはスルーする
        if ([button isHidden] == YES)
        {
            continue;
        }

        // 自動ボタンサイズ
        CGSize buttonSize = [button calcTextAutoSizeWithPadding];

        // ボタンの横位置調整
        [[button callStyle] addStyleKeys:@{
                                           @"left"  :CCStr(width),
                                           @"width" :CCStr(buttonSize.width),
                                           @"height":CCStr(buttonSize.height),
                                           }];
        // ボタングループ用のサイズスタック
        width += buttonSize.width;
        height = MAX(height, buttonSize.height);
        // ボタン角丸め用のスタック
        if (firstButton == nil)
        {
            firstButton = button;
        }
        lastButton = button;
    }
    
    // ボタングループのサイズ調整
    [[self callStyle] addStyleKeys:@{
                                     @"width"   :CCStr(width),
                                     @"height"  :CCStr(height),
                                     }];
    // ボタンの角丸め
    if (firstButton == lastButton)
    {
        [[firstButton callStyle] addStyleKey:@"border-radius" value:@"4"];
    }
    else
    {
        [[firstButton callStyle] addStyleKey:@"border-radius" value:@"4 0 0 4"];
        [[lastButton callStyle]  addStyleKey:@"border-radius" value:@"0 4 4 0"];
    }
}

@end
