//
//  CCChartPie.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCChartPie.h"

#import "CCChart.h"
#import "CCColor.h"
#import "CCChartData.h"

#import "CFCollection.h"

@interface CCChartPie()

@end



@implementation CCChartPie

#pragma mark - synthesize
//
// synthesize
//
@synthesize dataList;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame data:(NSArray<CCChartData *> *)dataValues
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadData:dataValues];
    }
    return self;
}

// データ読み込み
- (void)loadData:(NSArray<CCChartData *> *)dataValues
{
    [self setDataList:dataValues];
}

// 描画処理
- (void)drawRect:(CGRect)rect
{
    // データ
    NSMutableArray<CCChartData *> *list = [[self dataList] mutableCopy];
    
    // ソート
    list = [[CFCollection sortWithEntityArray:list sort:@[ @{@"value":@NO} ]] mutableCopy];
    
    // 色リスト
    NSArray<NSString *> *colorList = [CCChart colorList];
    NSInteger colorLimit = [colorList count];
    NSInteger colorCount = 0;
    
    // 色設定
    for (CCChartData *chartData in list)
    {
        [chartData setColor:
         [CCColor colorWithHEXString:[colorList objectAtIndex:(colorCount++ % colorLimit)]]
         ];
    }
    
    // 設定
    [self setDataList:[list copy]];
    
    
    // 最大値の取得
    NSNumber *totalValue = @0;
    for (CCChartData *one in [self dataList])
    {
        totalValue = @([totalValue doubleValue] + [[one value] doubleValue]);
    }
    
    
    // 現在のコンテクストを取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 透明レイヤー開始
    CGContextBeginTransparencyLayer(context, nil);
    
    // パスの描画を開始
    CGContextBeginPath(context);
    
    // 半円の描画
    double nowAngle = (M_PI/180)*-90;
    for (CCChartData *one in [self dataList])
    {
        // 角度
        double angle = [[one value] doubleValue] / [totalValue doubleValue];
        // 開始角度
        double startAngle = nowAngle + (M_PI/180)*360;
        
        // 円グラフの角度
        double endAngle = startAngle + (M_PI/180)*360 * angle;
        
        // 円弧を描画する
        CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/2);
        CGContextAddArc(context, rect.size.width/2, rect.size.height/2, 100.0f, startAngle, endAngle, 0);
        CGContextClosePath(context);
        UIColor *color = [one color];
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextDrawPath(context, kCGPathFill);
        
        // 角度更新
        nowAngle = endAngle;
        
        
        
        // 文字列要素
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        // パラグラフ
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setAlignment:NSTextAlignmentCenter];
        [paragraph setLineBreakMode:NSLineBreakByCharWrapping];
        
        // 要素設定
        [attributes addEntriesFromDictionary:@{NSParagraphStyleAttributeName:paragraph,
                                               NSFontAttributeName:[UIFont systemFontOfSize:14]
                                               }];
        
        double textAngle = startAngle + ((endAngle - startAngle) / 2);
        
        CGPoint point = CGPointMake((160 + 110 * cos(textAngle)), (160 + 110 * sin(textAngle)));
        
        // 文字描画
        NSString *textString = [NSString stringWithFormat:@"%@\n%.1f%%", [one title], ([[one value] doubleValue] / [totalValue doubleValue] * 100)];
        NSInteger offset = 00;
        CGSize textSize = [textString sizeWithAttributes:attributes];
        if (point.x > 160)
        {
            point.x += offset;
        }
        else
        {
            point.x -= (textSize.width + offset);
        }
        if (point.y > 160)
        {
            point.y += offset;
        }
        else
        {
            point.y -= (textSize.height + offset);
        }
        
        [textString drawAtPoint:point withAttributes:attributes];
    }
    
    // 透明レイヤー終了
    CGContextEndTransparencyLayer(context);
}


@end
