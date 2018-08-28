//
//  CCStyle.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CTStyle.h"

@interface CCStyle()

#pragma mark - property
//
// property
//
@property NSMutableDictionary *_styles;

@end



@implementation CCStyle

#pragma mark - method
//
// method
//

// init
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self setStyleDictionary:[@{} mutableCopy]];
    }
    return self;
}

// 初期化
- (instancetype) initWithStyleDictionary:(NSDictionary *)dictionaryValue
{
    self = [self init];
    if(self)
    {
        [self setStyleDictionary:dictionaryValue];
    }
    return self;
}

// スタイルの追加
- (void) addStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
    // 既存の値
    NSString *oldValue = [self styleForKey:keyValue];
    
    // キーが存在していない場合
    if (oldValue == nil)
    {
        [[self allStyles] setObject:dataValue forKey:keyValue];
        return;
    }
    
    // キーが存在し、同じ場合
    if ([oldValue isEqualToString:dataValue] == YES)
    {
        return;
    }
    
    // キーが存在し、変更があった場合
    [[self allStyles] willChangeValueForKey:keyValue];
    [[self allStyles] setObject:dataValue forKey:keyValue];
    [[self allStyles] didChangeValueForKey:keyValue];
}

// スタイルの一括追加
- (void) addStyleDictionary:(NSDictionary *)dictionaryValue
{
    for (NSString *keyValue in [dictionaryValue allKeys])
    {
        [self addStyleKey:keyValue value:[dictionaryValue objectForKey:keyValue]];
    }
}

// キーの削除
- (void) removeStyleKey:(NSString *)keyValue
{
    // キーが存在しない場合
    if ([self styleForKey:keyValue] == nil)
    {
        return;
    }
    
    // キーが存在する場合
    [[self allStyles] willChangeValueForKey:keyValue];
    [[self allStyles] removeObjectForKey:keyValue];
    [[self allStyles] didChangeValueForKey:keyValue];
}

// スタイル値の取得
- (NSString *) styleForKey:(NSString *)keyValue
{
    return [[self allStyles] objectForKey:keyValue];
}

// スタイル値の設定
- (void) setStyleKey:(NSString *)keyValue value:(NSString *)dataValue
{
    [self addStyleKey:keyValue value:dataValue];
}

// スタイルの一括設定
- (void) setStyleDictionary:(NSDictionary *)dictionaryValue
{
    [self addStyleDictionary:dictionaryValue];
}

// スタイルの全取得
- (NSMutableDictionary *) allStyles
{
    return [self _styles];
}

// フォント取得
- (UIFont *) callFont
{
    // フォントサイズ
    CGFloat fontSize = [self floatStyleForKey:@"font-size" defaultValue:12];
    
    // フォントボールド
    NSString *_fontWeight = [self styleForKey:@"font-weight"];
    BOOL isFontBold = NO;
    if(_fontWeight != nil)
    {
        if([_fontWeight isEqualToString:@"bold"] == YES)
        {
            isFontBold = YES;
        }
    }
    
    // フォント生成
    UIFont *font;
    // ボールド
    if(isFontBold == YES)
    {
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

// サイズ取得
- (CGSize) callSize
{
    CGFloat width = [self floatStyleForKey:@"width" defaultValue:0];
    CGFloat height = [self floatStyleForKey:@"height" defaultValue:0];
    
    return CGSizeMake(width, height);
}

// ポイント取得
- (CGPoint) callPoint
{
    CGFloat top = [self floatStyleForKey:@"top" defaultValue:0];
    CGFloat left = [self floatStyleForKey:@"left" defaultValue:0];
    
    return CGPointMake(left, top);
}

// フレーム取得
- (CGRect) callFrame
{
    CGPoint point = [self callPoint];
    CGSize size = [self callSize];
    
    CGRect rect = CGRectZero;
    rect.origin = point;
    rect.size = size;
    return rect;
}

// マージンの取得
- (CCMargin) callMargin
{
    NSString *marginString = [self styleForKey:@"margin"];
    CCMargin margin = {0, 0, 0, 0};
    if (marginString == nil)
    {
        return margin;
    }
    
    // マージン分解
    NSArray *marginComponents = [marginString componentsSeparatedByString:@" "];
    NSUInteger componentCount = [marginComponents count];
    if (componentCount == 4)
    {
        margin.top    = [[marginComponents objectAtIndex:0] floatValue];
        margin.right  = [[marginComponents objectAtIndex:1] floatValue];
        margin.bottom = [[marginComponents objectAtIndex:2] floatValue];
        margin.left   = [[marginComponents objectAtIndex:3] floatValue];
    }
    else if (componentCount == 2)
    {
        margin.top    = [[marginComponents objectAtIndex:0] floatValue];
        margin.right  = [[marginComponents objectAtIndex:1] floatValue];
        margin.bottom = margin.top;
        margin.left   = margin.right;
    }
    else if (componentCount == 1)
    {
        margin.top    = [[marginComponents objectAtIndex:0] floatValue];
        margin.right  = margin.top;
        margin.bottom = margin.top;
        margin.left   = margin.top;
    }
    return margin;
}

// ボーダー幅取得
- (CGFloat) callBorderWidth
{
    return [self floatStyleForKey:@"border-width" defaultValue:0];
}



#pragma mark - private
//
// private
//

// 設定値か初期値をfloatで取得する
- (CGFloat) floatStyleForKey:(NSString *)keyValue defaultValue:(CGFloat)defaultValue
{
    NSString *styleValue = [self styleForKey:keyValue];
    if (styleValue != nil)
    {
        return [styleValue floatValue];
    }
    return defaultValue;
}



#pragma mark - NSCopying
//
// NSCopying
//
- (id) copyWithZone:(NSZone *)zone
{
    CCStyle *result = [[self class] allocWithZone:zone];
    if (result)
    {
        [result setStyleDictionary:[[self allStyles] mutableCopyWithZone:zone]];
    }
    return result;
}

@end
