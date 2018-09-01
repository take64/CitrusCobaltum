//
//  CCControl.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCControl.h"

#import <objc/runtime.h>

#import "CCColor.h"
#import "CCStyle.h"
#import "CFString.h"

#pragma mark - static variables
//
// static variables
//
static CGFloat const kControlWidth = 64;
static CGFloat const kControlHeight = 48;



@interface CCControl()

#pragma mark - property
//
// property
//

@property (nonatomic) CCStyle *styleNormal;
@property (nonatomic) CCStyle *styleHighlighted;
@property (nonatomic) CCStyle *styleDisabled;
@property (nonatomic) CCControlState controlState;

@end



@implementation CCControl

#pragma mark - synthesize
//
// synthesize
//
@synthesize title;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        // タイトル
        [self setTitle:titleValue];
    }
    return self;
}

// スタイル取得(normalのエイリアス)
- (CCStyle *) callStyle
{
    return [self callStyleNormal];
}

// スタイル設定(normalのエイリアス)
- (void) setStyle:(CCStyle *)styleValue
{
    [self setStyleNormal:styleValue];
}

// スタイル取得(normal)
- (CCStyle *) callStyleNormal
{
    if ([self styleNormal] == nil)
    {
        [self setStyleNormal:[[CCStyle alloc] init]];
    }
    return [self styleNormal];
}

// スタイル設定(normal)
- (void) setStyleNormal:(CCStyle *)styleValue
{
    [[self callStyleNormal] addStyleDictionary:[styleValue allStyles]];
}

// スタイル取得(highlighted)
- (CCStyle *) callStyleHighlighted
{
    if([self styleHighlighted] == nil)
    {
        [self setStyleHighlighted:[[self callStyleNormal] copy]];
    }
    return [self styleHighlighted];
}

// スタイル設定(highlighted)
- (void) setStyleHighlighted:(CCStyle *)styleValue
{
    [[self callStyleHighlighted] addStyleDictionary:[styleValue allStyles]];
}

// スタイル取得(disabled)
- (CCStyle *) callStyleDisabled
{
    if ([self styleDisabled] == nil)
    {
        [self setStyleDisabled:[[self callStyleNormal] copy]];
    }
    return [self styleDisabled];
}

// スタイル設定(disabled)
- (void) setStyleDisabled:(CCStyle *)styleValue
{
    [[self callStyleDisabled] addStyleDictionary:[styleValue allStyles]];
}

// 自動テキストサイズ計算
- (CGSize)calcTextAutoSize
{
    CGSize bounds = CGSizeZero;
    CCStyle *stylesheet = [self callStyle];
    CGFloat width = [stylesheet callSize].width;
    
    // フォント要素
    NSMutableDictionary *attributes = [stylesheet callFontAttributes];
    
    // サイズ計算
    CGSize fontBounds = [[self title] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size;
    bounds.width = ceil(fontBounds.width);
    bounds.height = ceil(fontBounds.height);
    
    return bounds;
}

// 自動テキストサイズ計算(パディング込み)
- (CGSize)calcTextAutoSizeWithPadding
{
    CGSize bounds = [self calcTextAutoSize];
    CCStyle *stylesheet = [self callStyle];
    
    // パディング追加
    CCPadding padding = [stylesheet callPadding];
    bounds.width += (padding.left + padding.right);
    bounds.height += (padding.top + padding.bottom);
    
    return bounds;
}

// 初期化
- (id)initWithFrame:(CGRect)frame
{
    // デフォルトサイズ処理
    if(CGRectIsEmpty(frame) == YES)
    {
        frame = CGRectMake(0, 0, kControlWidth, kControlHeight);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        // ビュー自体の背景
        [self setBackgroundColor:[UIColor clearColor]];
        // 初期設定
        [[self callStyleNormal] addStyleDictionary:@{
                                                     @"background-color"    :@"00000000",
                                                     @"left"                :@"0",
                                                     @"top"                 :@"0",
                                                     @"width"               :[@(frame.size.width) stringValue],
                                                     @"height"              :[@(frame.size.height) stringValue],
                                                     }];
        
        // 値監視
        [[[self callStyleNormal] allStyles] addObserver:self forKeyPath:@"width" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] allStyles] addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] allStyles] addObserver:self forKeyPath:@"top" options:NSKeyValueObservingOptionNew context:NULL];
        [[[self callStyleNormal] allStyles] addObserver:self forKeyPath:@"left" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

// 片付け
- (void) dealloc
{
    [[[self callStyleNormal] allStyles] removeObserver:self forKeyPath:@"left"];
    [[[self callStyleNormal] allStyles] removeObserver:self forKeyPath:@"top"];
    [[[self callStyleNormal] allStyles] removeObserver:self forKeyPath:@"width"];
    [[[self callStyleNormal] allStyles] removeObserver:self forKeyPath:@"height"];
}

// キー値監視
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGRect rect = [self frame];
    CCStyle *stylesheet = [self callStyleNormal];
    
    // width 変更時
    if ([keyPath isEqualToString:@"width"] == YES)
    {
        rect.size.width = [[stylesheet styleForKey:@"width"] floatValue];
    }
    // height 変更時
    else if ([keyPath isEqualToString:@"height"] == YES)
    {
        rect.size.height = [[stylesheet styleForKey:@"height"] floatValue];
    }
    // top 変更時
    else if ([keyPath isEqualToString:@"top"] == YES)
    {
        rect.origin.y = [[stylesheet styleForKey:@"top"] floatValue];
    }
    // left 変更時
    else if ([keyPath isEqualToString:@"left"] == YES)
    {
        rect.origin.x = [[stylesheet styleForKey:@"left"] floatValue];
    }
    [self setFrame:rect];
}

// 描画
- (void) drawRect:(CGRect)rect
{
    // コンテクスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // スタイルシート
    CCStyle *stylesheet = [self callControlStateStylesheet];
    
    // 文字列要素
    NSMutableDictionary *attributes = [@{} mutableCopy];
    // パラグラフ
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph}];
    
    CGContextSaveGState(context);
    
    CGRect contentRect = rect;
    
    // マージン
    CCMargin margin = [stylesheet callMargin];
    contentRect = CGRectMake((contentRect.origin.x + margin.left),
                             (contentRect.origin.y + margin.top),
                             (contentRect.size.width - (margin.left + margin.right)),
                             (contentRect.size.height - (margin.top + margin.bottom))
                             );
    
    // パッディング
    CCPadding padding = [stylesheet callPadding];
    CGRect paddedRect = contentRect;
    paddedRect = CGRectMake((contentRect.origin.x + padding.left),
                                   (contentRect.origin.y + padding.top),
                                   (contentRect.size.width - (padding.left + padding.right)),
                                   (contentRect.size.height - (padding.top + padding.bottom))
                                   );
    
    // 背景描画
    CCColorStruct backgroundColor = [stylesheet callBackgroundColor];
    if (CCColorStructIsNull(backgroundColor) == false)
    {
        CGContextSetRGBFillColor(context, backgroundColor.red, backgroundColor.green, backgroundColor.blue, backgroundColor.alpha);
    }
    
    // ボーダー角丸
    CCRadius borderRadius = [stylesheet callBorderRadius];
    if (CCRadiusIsNull(borderRadius) == false)
    {
        [self addPathWithRadius:borderRadius rect:contentRect offset:0];
    }
    
    // 描画
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    // 影設定
    CCShadow boxShadow = [stylesheet callBoxShadow];
    if (CCShadowIsNull(boxShadow) == false)
    {
        CGContextSaveGState(context);
        
        // パス描画
        [self addPathWithRadius:borderRadius rect:contentRect offset:0];
        
        // 背景色処理
        if (CCColorStructIsNull(backgroundColor) == false)
        {
            CGContextSetRGBFillColor(context, backgroundColor.red, backgroundColor.green, backgroundColor.blue, backgroundColor.alpha);
        }
        
        // 影描画
        CGContextSetShadowWithColor(context, CGSizeMake(boxShadow.horizontal, boxShadow.vertical), boxShadow.shading, [[CCColor colorWithColorStruct:boxShadow.color] CGColor]);
        CGContextFillPath(context);
        
        CGContextRestoreGState(context);
    }
    
    // グラデーション
    NSString *_backgroundImageString = [stylesheet styleForKey:@"background-image"];
    if([_backgroundImageString hasPrefix:@"linear-gradient"] == YES)
    {
        // 描画範囲
        CGContextSaveGState(context);
        [self addPathWithRadius:borderRadius rect:contentRect offset:0];
        CGContextClip(context);
        
        // トリム
        _backgroundImageString = [_backgroundImageString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // 文字列置換
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"linear-gradient(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@"rgba(" withString:@""];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@")" withString:@","];
        _backgroundImageString = [_backgroundImageString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        // 要素数の取得
        NSArray *component = [_backgroundImageString componentsSeparatedByString:@","];
        NSInteger size = [component count] - 1;
        
        const long locationSize = (size / 5);
        const long componentSize = ((size / 5) * 4);
        
        // 要素
        CGFloat locations[locationSize];
        CGFloat components[componentSize];
        
        // 設定
        NSInteger count = 0;
        NSInteger locationCount = 0;
        NSInteger componentCount = 0;
        for(NSString *column in component)
        {
            if(count >= size)
            {
                break;
            }
            
            if(((count + 1) % 5) == 0)
            {
                locations[locationCount] = [column floatValue];
                locationCount++;
            }
            else
            {
                components[componentCount] = [column floatValue];
                componentCount++;
            }
            count++;
        }
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationSize);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, contentRect.origin.y), CGPointMake(0, contentRect.origin.y + contentRect.size.height), 0);
        
        CGContextRestoreGState(context);
        
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    }
    
    
    // 枠線
    CGFloat borderWidth = [stylesheet callBorderWidth];
    if (borderWidth > 0)
    {
        CGContextSaveGState(context);
        
        // 枠線色
        CCColorStruct borderColor = [stylesheet callBorderColor];
        CGContextSetRGBStrokeColor(context, borderColor.red, borderColor.green, borderColor.blue, borderColor.alpha);
        CGContextSetLineWidth(context, borderWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        
        // 描画範囲
        CGRect _drawRect = CGRectInset(contentRect, (borderWidth / 2), (borderWidth / 2));
        [self addPathWithRadius:borderRadius rect:_drawRect offset:(borderWidth / -1)];
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
    }
    
    // テキストレンダリング
    if([self title] != nil)
    {
        CGContextSaveGState(context);
        
        // テキスト影
        CCShadow textShadow = [stylesheet callTextShadow];
        if (CCShadowIsNull(textShadow) == false)
        {
            CGContextSetShadowWithColor(context, CGSizeMake(textShadow.horizontal, textShadow.vertical), textShadow.shading, [[CCColor colorWithColorStruct:textShadow.color] CGColor]);
        }
        
        // 文字色
        CCColorStruct colorStruct = [stylesheet callColor];
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName:[CCColor colorWithColorStruct:colorStruct]}];
        
        // ラインブレイク
        NSLineBreakMode lineBreakMode = [stylesheet callLineBreak];
        [paragraph setLineBreakMode:lineBreakMode];
        
        // フォントアジャストが効いている場合はフォントサイズを下げる
        [stylesheet fontAdjustmentWithText:[self title] rect:paddedRect];
        
        // フォント計算
        UIFont *font = [stylesheet callFont];
        [attributes addEntriesFromDictionary:@{NSFontAttributeName:font}];
        CGSize fontBounds = [CFString sizeWithString:[self title] font:font constrainedToSize:paddedRect.size];
        fontBounds.width = paddedRect.size.width;
        if(fontBounds.height > paddedRect.size.height)
        {
            fontBounds.height = paddedRect.size.height;
        }
        
        // 文字寄せ
        CGRect titleFrame = CGRectMake(0, 0, (fontBounds.width), (fontBounds.height));
        
        // 横位置
        NSTextAlignment textAlignment = [stylesheet callTextAlignment];
        CGFloat titleFrameX = 0;
        if (textAlignment == NSTextAlignmentLeft)
        {
            // 左寄せ
            titleFrameX = paddedRect.origin.x;
        }
        else if (textAlignment == NSTextAlignmentRight)
        {
            // 右寄せ
            titleFrameX = (paddedRect.origin.x + paddedRect.size.width) - fontBounds.width;
        }
        else
        {
            // 中央寄せ
            titleFrameX = (paddedRect.size.width / 2 - fontBounds.width / 2) + paddedRect.origin.x;
        }
        
        // 縦位置
        CCVerticalAlignment verticalAlignment = [stylesheet callVerticalAlignment];
        CGFloat titleFrameY = 0;
        if (verticalAlignment == CCVerticalAlignmentTop)
        {
            // 上寄せ
            titleFrameY = paddedRect.origin.y;
        }
        else if (verticalAlignment == CCVerticalAlignmentBottom)
        {
            // 下寄せ
            titleFrameY = (paddedRect.size.height - fontBounds.height) + paddedRect.origin.y;
        }
        else
        {
            // 中央寄せ
            titleFrameY = (paddedRect.size.height / 2 - fontBounds.height / 2) + paddedRect.origin.y;
        }
        
        titleFrame.origin = CGPointMake(titleFrameX, titleFrameY);
        
        [paragraph setAlignment:textAlignment];
        
        // 文字列描画
        [[self title] drawInRect:titleFrame withAttributes:attributes];
        
        CGContextRestoreGState(context);
    }
}

// 強制描画
- (void) setNeedsDisplay
{
    [super setNeedsDisplay];
    
    for(id childView in [self subviews])
    {
        if([childView isKindOfClass:[CCControl class]] == YES)
        {
            [(CCControl *)childView setNeedsDisplay];
        }
    }
}

// ステート変更
- (void) setControlState:(CCControlState)state
{
    [self setControlState:state];
    [self setNeedsDisplay];
}

// ステート変更(enable)
- (void) setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setControlState:(enabled == YES ? CCControlStateNormal : CCControlStateDisabled)];
}

// ステート変更(highlighted)
- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setControlState:(highlighted == YES ? CCControlStateHighlighted : CCControlStateNormal)];
}



#pragma mark - private
//
// private
//

// 角丸のパスを生成
- (void) addPathWithRadius:(CCRadius)radius rect:(CGRect)rect offset:(CGFloat)offset
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 角丸rect
    CGRect cornerCircleRect  = rect;
    
    // get points
    CGFloat minx = CGRectGetMinX(cornerCircleRect);
    CGFloat midx = CGRectGetMidX(cornerCircleRect);
    CGFloat maxx = CGRectGetMaxX(cornerCircleRect);
    CGFloat miny = CGRectGetMinY(cornerCircleRect);
    CGFloat midy = CGRectGetMidY(cornerCircleRect);
    CGFloat maxy = CGRectGetMaxY(cornerCircleRect);
    
    // 黒下地
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius.top.left + offset);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius.top.right + offset);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius.bottom.left + offset);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius.bottom.right + offset);
    CGContextClosePath(context);
}

// コントロールステートに基づくスタイルシートの取得
- (CCStyle *)callControlStateStylesheet
{
    CCStyle *stylesheet = [self callStyleNormal];
    switch ([self controlState])
    {
        case CCControlStateHighlighted:
            stylesheet = [self callStyleHighlighted];
            break;
        case CCControlStateDisabled:
            stylesheet = [self callStyleDisabled];
            break;
        default:
            break;
    }
    return [stylesheet copy];
}

@end
