//
//  CCChartLine.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCChartLine.h"

#import "CCChart.h"
#import "CCChartList.h"
#import "CCChartData.h"
#import "CCColor.h"
#import "CCGraphics.h"

#import "CFCollection.h"



@interface CCChartLine()

#pragma mark - property
//
// property
//
@property NSArray<CCChartList *> *dataList;

@end



@implementation CCChartLine

#pragma mark - synthesize
//
// synthesize
//
@synthesize ruledTitleFormat;
@synthesize yMaxInit;
@synthesize yMinInit;



#pragma mark - extends UIView
//
// extends UIView
//

// 描画
- (void) drawRect:(CGRect)rect
{
    // データ
    NSArray<CCChartList *> *list = [self dataList];
    
    // 最小値・最大値
    NSNumber *min = [self yMinInit];
    NSNumber *max = [self yMaxInit];
    for (CCChartList *chartList in list)
    {
        min = @(MIN([min doubleValue], [[chartList minValue] doubleValue]));
        max = @(MAX([max doubleValue], [[chartList maxValue] doubleValue]));
    }
    
    // ソート
    list = [CFCollection sortWithEntityArray:list sort:@[ @{@"maxValue":@NO} ]];
    
    // 色リスト
    NSArray<NSString *> *colorList = [CCChart colorList];
    NSInteger colorLimit = [colorList count];
    NSInteger colorCount = 0;
    
    // 色設定
    for (CCChartList *chartList in list)
    {
        [chartList setColor:
         [CCColor colorWithHEXString:[colorList objectAtIndex:(colorCount++ % colorLimit)]]
         ];
    }
    
    // PADDING
    CGFloat padding = 20;
    
    
    // コンテクスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 透明レイヤー開始
    CGContextBeginTransparencyLayer(context, nil);
    
    // パスの描画を開始
    CGContextBeginPath(context);
    
    // 罫線描画
    int ruledCount = MIN(10, (int)rect.size.height / 32);
    CGFloat ruledYOffset = (rect.size.height - padding * 2) / ([max doubleValue] - [min doubleValue]);
    CGFloat diff = ([max doubleValue] - [min doubleValue]);
    for (int i = 0; i < ruledCount; i++)
    {
        CGFloat yOffset = (rect.size.height - padding) - (ruledYOffset / ruledCount) * (i * diff);
        
        CGColorRef cgcolor = [[CCColor colorWithHEXString:@"999999"] CGColor];
        const CGFloat *colors;
        colors = CGColorGetComponents(cgcolor);
        CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
        CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
        
        CGPoint fromPoint = CGPointMake(padding, yOffset);
        CGPoint toPoint = CGPointMake((rect.size.width - padding), yOffset);
        
        [CCGraphics drawLine:context fromPoint:fromPoint toPoint:toPoint];
        
        
        
        // 文字列要素
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        // パラグラフ
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setAlignment:NSTextAlignmentRight];
        [paragraph setLineBreakMode:NSLineBreakByCharWrapping];
        
        // 要素設定
        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph,
                                               NSFontAttributeName:[UIFont systemFontOfSize:14]
                                               }];
        
        CGPoint point = CGPointMake((rect.size.width - padding), yOffset);
        // 文字描画
        NSString *textString = [[self ruledTitleFormat] stringFromNumber:@([min doubleValue] + (diff / ruledCount * i))];
        
        //        [CTFormat formatMoneyWithDecimal:[CFDecimal decimalRoundPlainWithDecimal:[CFDecimal decimalWithDouble:[min doubleValue] + (diff / 10 * i)]]];
        CGSize textSize = [textString sizeWithAttributes:attributes];
        point.x -= textSize.width;
        point.y -= textSize.height;
        [textString drawAtPoint:point withAttributes:attributes];
        
    }
    
    // 描画
    for (CCChartList *chartList in list)
    {
        // 描画色設定
        CGColorRef cgcolor = [[chartList color] CGColor];
        const CGFloat *colors;
        colors = CGColorGetComponents(cgcolor);
        CGContextSetRGBFillColor(context, colors[0], colors[1], colors[2], colors[3]);
        CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
        
        CGFloat xOffset = (rect.size.width - padding * 2) / [[chartList dataList] count];
        CGFloat yOffset = (rect.size.height - padding * 2) / ([max doubleValue] - [min doubleValue]);
        CGFloat count = 0;
        CGPoint fromPoint = CGPointZero;
        for (CCChartData *chartData in [chartList dataList])
        {
            CGPoint point = CGPointMake(
                                        (xOffset * count) + padding,
                                        rect.size.height - ((yOffset * ([[chartData value] doubleValue] - [min doubleValue])) + padding)
                                        );
            
            // 線描画
            if (CGPointEqualToPoint(fromPoint, CGPointZero) == NO)
            {
                [CCGraphics drawLine:context fromPoint:fromPoint toPoint:point];
            }
            
            // 丸描画
            [CCGraphics drawCircle:context point:point size:4];
            
            fromPoint = point;
            
            count++;
        }
    }
    
    // 透明レイヤー終了
    CGContextEndTransparencyLayer(context);
}




#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 項目タイトルフォーマット
        NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc] init];
        [numberFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormat setGroupingSeparator:@","];
        [numberFormat setGroupingSize:3];
        [numberFormat setMinimumFractionDigits:2];
        [numberFormat setMaximumFractionDigits:2];
        [self setRuledTitleFormat:numberFormat];
        
        // min & max 初期値
        [self setYMinInit:@(NSUIntegerMax)];
        [self setYMaxInit:@0];
    }
    return self;
}

// 初期化
- (instancetype) initWithFrame:(CGRect)frame data:(NSArray<CCChartList *> *)dataValue
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self loadData:dataValue];
    }
    return self;
}

// データ読み込み
- (void) loadData:(NSArray<CCChartList *> *)dataValue
{
    [self setDataList:dataValue];
}

@end
