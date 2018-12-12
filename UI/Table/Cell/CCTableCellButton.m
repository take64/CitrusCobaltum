//
//  CCTableCellButton.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/12.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellButton.h"

#import "CCButton.h"
#import "CCStyle.h"



@interface CCTableCellButton()

#pragma mark - property
//
// property
//
@property CCButton *button;

@end



@implementation CCTableCellButton

#pragma mark - extends
//
// extends
//

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // レイアウト済みの場合
    if ([self isSubLayouted] == YES)
    {
        return;
    }
    
    [[self button] setFrame:CGRectOffset(CGRectInset([self contentFrame], 8, 4), 0, -2)];
    
    // レイアウト済み
    [self setSubLayouted:YES];
}

// テキスト取得
- (NSString *) contentText
{
    return [[self button] title];
}

// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self button] setTitle:stringValue];
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:prefixString content:textString suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // ボタン
        CCButton *_button = [[CCButton alloc] initWithTitle:textString styleKeys:@ {
                                                                                @"font-size"        :@"16",
                                                                                @"font-weight"      :@"bold",
                                                                                @"text-shadow"      :@"0 -1 1 333333",
                                                                                @"background-color" :@"0000FF",
                                                                                @"border-color"     :@"FFFFFF",
                                                                                @"border-width"     :@"1",
                                                                                @"border-radius"    :@"4",
                                                                                @"margin"           :@"4 12 4 12",
                                                                                @"box-shadow"       :@"0 1 4 000000",
                                                                                @"background-image" :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.50) 0.05, rgba(0.50, 0.50, 0.50, 0.50) 0.95, rgba(0.25, 0.25, 0.25, 0.75) 1.00)",
                                                                                }];
        [[_button callStyleHighlighted] addStyleKeys:@{
                                                       @"background-image":@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                       }];
        [[_button callStyleDisabled] addStyleKeys:@{
                                                    @"background-color":@"666666",
                                                    }];
        [[self contentView] addSubview:_button];
        [self setButton:_button];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
