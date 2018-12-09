//
//  CCTableCellLabel.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellLabel.h"

#import "CCLabel.h"
#import "CCStyle.h"

@interface CCTableCellLabel()

#pragma mark - property
//
// property
//
@property CCLabel *label;

@end



@implementation CCTableCellLabel

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
    
    [[self label] setFrame:[[self contentView] frame]];
    
    CGRect labelRect = [[self label] frame];
    labelRect.size.width -= 16;
    labelRect.origin.x += 8;
    [[self label] setFrame:labelRect];
    
    // レイアウト済み
    [self setSubLayouted:YES];
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:nil reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString content:nil suffix:nil reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

// 初期化

- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // part
        CCLabel *_Label;
        
        // ラベル
        _Label = [[CCLabel alloc] initWithTitle:textString styleKeys:@{
                                                                       @"font-size"    :@"14",
                                                                       @"color"        :@"000000",
                                                                       @"text-align"   :@"left",
                                                                       @"line-break"   :@"clipping",
                                                                       }];
        [_Label setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin |
                                     UIViewAutoresizingFlexibleWidth |
                                     UIViewAutoresizingFlexibleHeight)];
        [[self contentView] addSubview:_Label];
        [self setLabel:_Label];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // タッチイベントは透過
        [[self label] setUserInteractionEnabled:NO];
    }
    return self;
}

// テキスト取得
- (NSString *) labelText
{
    return [[self label] title];
}

// テキスト設定
- (void) setLabelText:(NSString *)stringValue
{
    [[self label] setTitle:stringValue];
}

// 文字寄せ
- (void) setTextAlignment:(NSTextAlignment)textAlignment
{
    [[[self label] callStyle] setTextAlignment:textAlignment];
}

@end
