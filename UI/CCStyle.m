//
//  CCStyle.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCStyle.h"

#import "CitrusCobaltumTypedef.h"
#import "CCColor.h"

#import "CFString.h"



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
        [self set_styles:[@{} mutableCopy]];
    }
    return self;
}

// 初期化
- (instancetype) initWithStyleKeys:(NSDictionary *)dictionaryValue
{
    self = [self init];
    if (self)
    {
        [self addStyleKeys:dictionaryValue];
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
- (void) addStyleKeys:(NSDictionary *)keyValues
{
    for (NSString *key in [keyValues allKeys])
    {
        NSString *value = [keyValues objectForKey:key];
        if ([value isEqual:[NSNull null]] == YES)
        {
            [self removeStyleKey:key];
        }
        else
        {
            [self addStyleKey:key value:value];
        }
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

// スタイルの全取得
- (NSMutableDictionary *) allStyles
{
    return [self _styles];
}

// フォント取得
- (UIFont *) callFont
{
    // フォントサイズ
    CGFloat fontSize = [self callFontSize];
    
    // フォントボールド
    NSString *_fontWeight = [self styleForKey:@"font-weight"];
    BOOL isFontBold = NO;
    if (_fontWeight != nil)
    {
        if ([_fontWeight isEqualToString:@"bold"] == YES)
        {
            isFontBold = YES;
        }
    }
    
    // フォント生成
    UIFont *font;
    // ボールド
    if (isFontBold == YES)
    {
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    return font;
}

// フォントサイズ取得
- (CGFloat) callFontSize
{
    return [self floatStyleForKey:@"font-size" defaultValue:12];
}

// フォント要素取得
- (NSMutableDictionary *) callFontAttributes
{
    // 文字列要素
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];
    // ラインブレイク
    NSLineBreakMode lineBreakMode = [self callLineBreak];
    [paragraph setLineBreakMode:lineBreakMode];
    // フォント計算
    UIFont *font = [self callFont];
    [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
    
    return attributes;
}

// サイズ取得
- (CGSize) callSize
{
    CGFloat width = [self floatStyleForKey:@"width" defaultValue:0];
    CGFloat height = [self floatStyleForKey:@"height" defaultValue:0];
    
    return CGSizeMake(width, height);
}

// サイズ設定
- (void) setSize:(CGSize)size
{
    [self addStyleKeys:@{
                         @"width"   :CCStr(size.width),
                         @"height"  :CCStr(size.height),
                         }];
}

// ポイント取得
- (CGPoint) callPoint
{
    CGFloat top = [self floatStyleForKey:@"top" defaultValue:0];
    CGFloat left = [self floatStyleForKey:@"left" defaultValue:0];
    
    return CGPointMake(left, top);
}

// ポイント設定
- (void) setPoint:(CGPoint)point
{
    [self addStyleKeys:@{
                         @"left":CCStr(point.x),
                         @"top" :CCStr(point.y),
                         }];
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

// フレーム設定
- (void) setFrame:(CGRect)frame
{
    [self setSize:frame.size];
    [self setPoint:frame.origin];
}

// マージンの取得
- (CCMargin) callMargin
{
    return [self parseOffsetWithKey:@"margin"];
}

// パッディング取得
- (CCPadding) callPadding
{
    return [self parseOffsetWithKey:@"padding"];
}

// 角丸取得
- (CCRadius) callBorderRadius
{
    // 共通ロジックで一旦分解する
    CCOffset offset = [self parseOffsetWithKey:@"border-radius"];
    
    // 入れ替える
    CCRadius radius;
    radius.top.left = offset.top;
    radius.top.right = offset.right;
    radius.bottom.left = offset.bottom;
    radius.bottom.right = offset.left;
    return radius;
}

// ボックス影取得
- (CCShadow) callBoxShadow
{
    return [self parseShadowWithKey:@"box-shadow"];
}

// 文字色取得
- (CCColorStruct) callColor
{
    return [self parseColorWithKey:@"color"];
}

// テキスト影取得
- (CCShadow) callTextShadow
{
    return [self parseShadowWithKey:@"text-shadow"];
}

// ボーダー幅取得
- (CGFloat) callBorderWidth
{
    return [self floatStyleForKey:@"border-width" defaultValue:0];
}

// ボーダー色取得
- (CCColorStruct) callBorderColor
{
    return [self parseColorWithKey:@"border-color"];
}

// ラインブレイク取得
- (NSLineBreakMode) callLineBreak
{
    NSString *lineBreakString = [self styleForKey:@"line-break"];
    NSLineBreakMode lineBreak = NSLineBreakByWordWrapping;
    if (lineBreakString == nil)
    {
        return lineBreak;
    }
    
    if ([lineBreakString isEqualToString:@"word-wrapping"] == YES)
    {
        lineBreak = NSLineBreakByWordWrapping;// Wrap at word boundaries, default
    }
    else if ([lineBreakString isEqualToString:@"char-wrapping"] == YES)
    {
        lineBreak = NSLineBreakByCharWrapping; // Wrap at character boundaries
    }
    else if ([lineBreakString isEqualToString:@"clipping"] == YES)
    {
        lineBreak = NSLineBreakByClipping; // Simply clip
    }
    else if ([lineBreakString isEqualToString:@"truncating-head"] == YES)
    {
        lineBreak = NSLineBreakByTruncatingHead; // Truncate at head of line: "abcd..."
    }
    else if ([lineBreakString isEqualToString:@"truncating-tail"] == YES)
    {
        lineBreak = NSLineBreakByTruncatingTail; // Truncate at head of line: "...wxyz"
    }
    else if ([lineBreakString isEqualToString:@"truncating-middle"] == YES)
    {
        lineBreak = NSLineBreakByTruncatingMiddle;  // Truncate middle of line:  "ab...yz"
    }
    return lineBreak;
}

// 横文字寄せ取得
- (NSTextAlignment) callTextAlignment
{
    NSString *textAlignString = [self styleForKey:@"text-align"];
    NSTextAlignment textAlign = NSTextAlignmentCenter;
    if (textAlignString == nil)
    {
        return textAlign;
    }
    
    if ([textAlignString isEqualToString:@"left"] == YES)
    {
        textAlign = NSTextAlignmentLeft;
    }
    else if ([textAlignString isEqualToString:@"right"] == YES)
    {
        textAlign = NSTextAlignmentRight;
    }
    return textAlign;
}

// 横文字寄せ設定
- (void) setTextAlignment:(NSTextAlignment)textAlignment
{
    NSString *alignmentString = @"";
    switch (textAlignment)
    {
        case NSTextAlignmentLeft:   alignmentString = @"left";    break;
        case NSTextAlignmentCenter: alignmentString = @"center";  break;
        case NSTextAlignmentRight:  alignmentString = @"right";   break;
        case NSTextAlignmentJustified:
        case NSTextAlignmentNatural:
        default:                    alignmentString = @"left";    break;
    }
    
    [self setStyleKey:@"text-align" value:alignmentString];
}

// 縦文字寄せ取得
- (CCVerticalAlignment) callVerticalAlignment
{
    NSString *verticalAlignString = [self styleForKey:@"vertical-align"];
    CCVerticalAlignment verticalAlignment = CCVerticalAlignmentMiddle;
    if (verticalAlignString == nil)
    {
        return verticalAlignment;
    }
    
    if ([verticalAlignString isEqualToString:@"top"] == YES)
    {
        verticalAlignment = CCVerticalAlignmentTop;
    }
    else if ([verticalAlignString isEqualToString:@"bottom"] == YES)
    {
        verticalAlignment = CCVerticalAlignmentBottom;
    }
    return verticalAlignment;
}

// 背景色取得
- (CCColorStruct) callBackgroundColor
{
    return [self parseColorWithKey:@"background-color"];
}

// ポジション取得
- (CCOffset) callPosition
{
    CCOffset position = {
        [self floatStyleForKey:@"top" defaultValue:-1],
        [self floatStyleForKey:@"right" defaultValue:-1],
        [self floatStyleForKey:@"bottom" defaultValue:-1],
        [self floatStyleForKey:@"left" defaultValue:-1]
    };
    return position;
}

// フォントをアジャストさせる
- (void) fontAdjustmentWithText:(NSString *)textValue rect:(CGRect)rect
{
    NSString *adjustFont = [self styleForKey:@"adjust-font"];
    if (adjustFont == nil)
    {
        return;
    }
    if ([adjustFont isEqualToString:@"true"] == NO)
    {
        return;
    }
    
    UIFont *font;
    CGSize fontBounds;
    BOOL adjust = NO;
    // 指定矩形に収まるまでフォントサイズを下げる
    while (adjust == NO)
    {
        font = [self callFont];
        fontBounds = [CFString sizeWithString:textValue font:font constrainedToSize:CGSizeMake(rect.size.width, CGFLOAT_MAX)];
        fontBounds.width = rect.size.width;
        CGFloat fontSize = [self callFontSize];
        if (fontBounds.height > rect.size.height && fontSize > 1)
        {
            fontBounds.height = rect.size.height;
            [self addStyleKey:@"font-size" value:[@(fontSize - 0.5) stringValue]];
        }
        else
        {
            adjust = YES;
        }
    }
}



#pragma mark - private
//
// private
//

// 設定値か初期値をfloatで取得する
- (CGFloat) floatStyleForKey:(NSString *)keyValue defaultValue:(CGFloat)defaultValue
{
    NSString *styleValue = [self styleForKey:keyValue];
    if (styleValue == nil || [styleValue isEqual:[NSNull null]] == YES)
    {
        return defaultValue;
    }
    return [styleValue floatValue];
}

// オフセット構造体で表現できる要素の分解
- (CCOffset) parseOffsetWithKey:(NSString *)keyValue
{
    NSString *offsetString = [self styleForKey:keyValue];
    CCOffset offset = {0, 0, 0, 0};
    if (offsetString == nil || [offsetString isEqual:[NSNull null]] == YES)
    {
        return offset;
    }
    
    // オフセット分解
    NSArray *offsetComponents = [offsetString componentsSeparatedByString:@" "];
    NSUInteger componentCount = [offsetComponents count];
    if (componentCount == 4)
    {
        offset.top    = [[offsetComponents objectAtIndex:0] floatValue];
        offset.right  = [[offsetComponents objectAtIndex:1] floatValue];
        offset.bottom = [[offsetComponents objectAtIndex:2] floatValue];
        offset.left   = [[offsetComponents objectAtIndex:3] floatValue];
    }
    else if (componentCount == 2)
    {
        offset.top    = [[offsetComponents objectAtIndex:0] floatValue];
        offset.right  = [[offsetComponents objectAtIndex:1] floatValue];
        offset.bottom = offset.top;
        offset.left   = offset.right;
    }
    else if (componentCount == 1)
    {
        offset.top    = [[offsetComponents objectAtIndex:0] floatValue];
        offset.right  = offset.top;
        offset.bottom = offset.top;
        offset.left   = offset.top;
    }
    return offset;
}

// 影構造体で表現できる要素の分解
- (CCShadow) parseShadowWithKey:(NSString *)keyValue
{
    NSString *shadowString = [self styleForKey:keyValue];
    CCShadow shadow = {0, 0, 0, {1, 1, 1, 1}};
    if (shadowString == nil)
    {
        return shadow;
    }
    
    NSArray *shadowComponents = [shadowString componentsSeparatedByString:@" "];
    shadow.horizontal   = [[shadowComponents objectAtIndex:0] floatValue];
    shadow.vertical     = [[shadowComponents objectAtIndex:1] floatValue];
    shadow.shading      = [[shadowComponents objectAtIndex:2] floatValue];
    shadow.color        = [CCColor colorStructWithHEXString:[shadowComponents objectAtIndex:3]];
    
    return shadow;
}

// 色構造体で表現できる要素の分解
- (CCColorStruct) parseColorWithKey:(NSString *)keyValue
{
    NSString *colorString = [self styleForKey:keyValue];
    if (colorString == nil)
    {
        return (CCColorStruct){1, 1, 1, 0};
    }
    return [CCColor colorStructWithHEXString:colorString];
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
        [result set_styles:[[self allStyles] mutableCopyWithZone:zone]];
    }
    return result;
}

@end
