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
    NSString *_fontSizeString = [self styleForKey:@"font-size"];
    CGFloat _fontSize = 12;
    if(_fontSizeString != nil)
    {
        _fontSize = [_fontSizeString floatValue];
    }
    
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
    UIFont *_font;
    // ボールド
    if(isFontBold == YES)
    {
        _font = [UIFont boldSystemFontOfSize:_fontSize];
    }
    else
    {
        _font = [UIFont systemFontOfSize:_fontSize];
    }
    
    return _font;
}

// サイズ取得
- (CGSize) callSize
{
    NSString *_widthString = [self styleForKey:@"width"];
    NSString *_heightString = [self styleForKey:@"height"];
    
    CGFloat _width = 0;
    CGFloat _height = 0;
    if(_widthString != nil)
    {
        _width = [_widthString floatValue];
    }
    if(_heightString != nil)
    {
        _height = [_heightString floatValue];
    }
    
    return CGSizeMake(_width, _height);
}

// ポイント取得
- (CGPoint) callPoint
{
    NSString *_topString = [self styleForKey:@"top"];
    NSString *_leftString = [self styleForKey:@"left"];
    
    CGFloat _top = 0;
    CGFloat _left = 0;
    if(_topString != nil)
    {
        _top = [_topString floatValue];
    }
    if(_leftString != nil)
    {
        _left = [_leftString floatValue];
    }
    
    return CGPointMake(_left, _top);
}

// フレーム取得
- (CGRect) callFrame
{
    CGPoint _point = [self callPoint];
    CGSize _size = [self callSize];
    
    CGRect _rect = CGRectZero;
    _rect.origin = _point;
    _rect.size = _size;
    return _rect;
}

// マージン取得(右)
- (CGFloat) callMarginRight
{
    // マージン
    NSString *_marginString = [self styleForKey:@"margin"];
    CGFloat _margins[4] = {0, 0, 0, 0};
    if(_marginString != nil)
    {
        NSArray *_marginsComponents = [_marginString componentsSeparatedByString:@" "];
        
        if([_marginsComponents count] == 4)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = [[_marginsComponents objectAtIndex:2] floatValue];
            _margins[3] = [[_marginsComponents objectAtIndex:3] floatValue];
        }
        else if([_marginsComponents count] == 2)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = _margins[0];
            _margins[3] = _margins[1];
        }
        else if([_marginsComponents count] == 1)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = _margins[0];
            _margins[2] = _margins[0];
            _margins[3] = _margins[0];
        }
    }
    return _margins[1];
}

// マージン取得(下)
- (CGFloat) callMarginBottom
{
    // マージン
    NSString *_marginString = [self styleForKey:@"margin"];
    CGFloat _margins[4] = {0, 0, 0, 0};
    if(_marginString != nil)
    {
        NSArray *_marginsComponents = [_marginString componentsSeparatedByString:@" "];
        
        if([_marginsComponents count] == 4)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = [[_marginsComponents objectAtIndex:2] floatValue];
            _margins[3] = [[_marginsComponents objectAtIndex:3] floatValue];
        }
        else if([_marginsComponents count] == 2)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = [[_marginsComponents objectAtIndex:1] floatValue];
            _margins[2] = _margins[0];
            _margins[3] = _margins[1];
        }
        else if([_marginsComponents count] == 1)
        {
            _margins[0] = [[_marginsComponents objectAtIndex:0] floatValue];
            _margins[1] = _margins[0];
            _margins[2] = _margins[0];
            _margins[3] = _margins[0];
        }
    }
    return _margins[2];
}

// ボーダー幅取得
- (CGFloat) callBorderWidth
{
    NSString *_borderWidthString = [self styleForKey:@"border-width"];
    CGFloat _borderWidth = 0;
    if(_borderWidthString != nil)
    {
        // 枠線幅
        _borderWidth = [_borderWidthString floatValue];
    }
    return _borderWidth;
}



#pragma mark - NSCopying
//
// NSCopying
//
- (id)copyWithZone:(NSZone *)zone
{
    CCStyle *result = [[self class] allocWithZone:zone];
    if (result)
    {
        [result setStyleDictionary:[[self allStyles] mutableCopyWithZone:zone]];
    }
    return result;
}

@end
