//
//  CCColor.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/29.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCColor.h"

@implementation CCColor

#pragma mark - static
//
// static
//

// 16進数カラー からCCColor(UIColor) オブジェクトを取得
+ (UIColor *) colorWithHEXString:(NSString *)hexString
{
    // キャッシュがあれば返す
    NSMutableDictionary *caches = [CCColor callCacheColors];
    UIColor *color = [caches objectForKey:hexString];
    if (color != nil)
    {
        return color;
    }
    
    // 色構造体の取得
    CCColorStruct colorStruct = [[self class] colorStructWithHEXString:hexString];
    
    // 色生成
    color = [[self class] colorWithColorStruct:colorStruct];
    
    // キャッシュする
    [caches setObject:color forKey:hexString];
    
    return color;
}

// 16進数カラー から補色CCColor(UIColor) オブジェクトを取得
+ (UIColor *) complementaryColorWithHEXString:(NSString *)hexString
{
    // 色構造体の取得
    CCColorStruct colorStruct = [[self class] colorStructWithHEXString:hexString];
    
    int max = MAX(MAX(colorStruct.red, colorStruct.green), colorStruct.blue);
    int min = MIN(MIN(colorStruct.red, colorStruct.green), colorStruct.blue);
    
    int total = max + min;
    if (total == 510)
    {
        total = 0;
    }
    colorStruct.red     = total - colorStruct.red;
    colorStruct.green   = total - colorStruct.green;
    colorStruct.blue    = total - colorStruct.blue;
    
    return [[self class] colorWithColorStruct:colorStruct];
}

// CCColor(UIColor) から 16進数文字列を取得
+ (NSString *) hexStringWithColor:(UIColor *)colorValue
{
    CGColorRef cgcolor = [colorValue CGColor];
    
    // 色を分解
    const CGFloat *colors;
    colors = CGColorGetComponents(cgcolor);
    int red     = colors[0] * 255.0;
    int green   = colors[1] * 255.0;
    int blue    = colors[2] * 255.0;
    int alpha   = colors[3] * 255.0;
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X", red, green, blue, alpha];
}

// table background color
+ (UIColor *) colorTableBackground
{
    return [CCColor colorWithHEXString:@"EBE9F0"];
}



#pragma mark - private
//
// private
//

// カラーキャッシュ
+ (NSMutableDictionary *) callCacheColors
{
    static NSMutableDictionary *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [NSMutableDictionary dictionaryWithCapacity:10];
    });
    return singleton;
}

// 16進数値変換( 'FFFFFF' => 0xFFFFFF )
+ (unsigned long) hexWithString:(NSString *)hexString
{
    // 16進文字列変換( 'FFFFFF' => '0xFFFFFF' )
    NSString *colorString = [NSString stringWithFormat:@"0x%@", hexString];
    
    // 16進数値変換( '0xFFFFFF' => 0xFFFFFF )
    const char *str = [colorString UTF8String];
    char *endptr;
    return strtoll(str, &endptr, 0);
}

// 色構造体に変換する
+ (CCColorStruct) colorStructWithHEXString:(NSString *)hexString
{
    // 色文字列長
    long length = [hexString length];
    
    // 16進数値変換( 'FFFFFF' => 0xFFFFFF )
    unsigned long hexcolor = [[self class] hexWithString:hexString];
    
    // 色型に変更
    int red     = 255.0;
    int green   = 255.0;
    int blue    = 255.0;
    int alpha   = 255.0;
    if (length == 6)
    {
        red     = ((hexcolor>>16)&0xFF);
        green   = ((hexcolor>>8)&0xFF);
        blue    = ((hexcolor)&0xFF);
    }
    else if (length == 8)
    {
        red     = ((hexcolor>>24)&0xFF);
        green   = ((hexcolor>>16)&0xFF);
        blue    = ((hexcolor>>8)&0xFF);
        alpha   = ((hexcolor)&0xFF);
    }
    
    return (CCColorStruct){red, green, blue, alpha};
}

// 色構造体から色を取得
+ (UIColor *) colorWithColorStruct:(CCColorStruct)colorStruct
{
    return [UIColor colorWithRed:(colorStruct.red / 255.0)
                           green:(colorStruct.green / 255.0)
                            blue:(colorStruct.blue / 255.0)
                           alpha:(colorStruct.alpha / 255.0)
            ];
}

@end
