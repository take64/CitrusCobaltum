//
//  CCColor.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/29.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCColor.h"

@implementation CCColor

#pragma mark - method
//
// method
//

// 16進数カラー からCCColor(UIColor) オブジェクトを取得
+ (UIColor *) colorWithHEXString:(NSString *)hexString
{
    NSMutableDictionary *caches = [CCColor callCacheColors];
    UIColor *color = [caches objectForKey:hexString];
    if (color == nil)
    {
        color = [CCColor colorWithHEXString:hexString alpha:1];
        [caches setObject:color forKey:hexString];
    }
    return color;
}

// 16進数カラー からCCColor(UIColor) オブジェクトを取得(透過色付き)
+ (UIColor *) colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // 色文字列長
    long length = [hexString length];
    
    // 16進数値変換( 'FFFFFF' => 0xFFFFFF )
    long long hexcolor = [[self class] hexWithString:hexString];
    
    // 色型に変更
    UIColor *color = [UIColor whiteColor];
    if (length == 6)
    {
        color = [UIColor colorWithRed:((hexcolor>>16)&0xFF)/255.0
                                green:((hexcolor>>8)&0xFF)/255.0
                                 blue:((hexcolor)&0xFF)/255.0
                                alpha:alpha];
    }
    else if (length == 8)
    {
        color = [UIColor colorWithRed:((hexcolor>>24)&0xFF)/255.0
                                green:((hexcolor>>16)&0xFF)/255.0
                                 blue:((hexcolor>>8)&0xFF)/255.0
                                alpha:((hexcolor)&0xFF)/255.0];
    }
    return color;
}

// 16進数カラー から補色CCColor(UIColor) オブジェクトを取得
+ (UIColor *) complementaryColorWithHEXString:(NSString *)hexString
{
    // 色文字列長
    long length = [hexString length];
    
    // 16進数値変換( 'FFFFFF' => 0xFFFFFF )
    long long hexcolor = [[self class] hexWithString:hexString];
    
    // 色型に変更
    int red     = 1.0;
    int green   = 1.0;
    int blue    = 1.0;
    int alpha   = 1.0;
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
    
    int max = MAX(MAX(red, green), blue);
    int min = MIN(MIN(red, green), blue);
    
    int total = max + min;
    if (total == 510)
    {
        total = 0;
    }
    red     = total - red;
    green   = total - green;
    blue    = total - blue;
    
    return [UIColor colorWithRed:red    / 255.0
                           green:green  / 255.0
                            blue:blue   / 255.0
                           alpha:alpha
            ];
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
+ (UIColor *)colorTableBackground
{
    return [CCColor colorWithHEXString:@"EBE9F0"];
}



#pragma mark - static
//
// static
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
+ (long long)hexWithString:(NSString *)hexString
{
    // 16進文字列変換( 'FFFFFF' => '0xFFFFFF' )
    NSString *colorString = [NSString stringWithFormat:@"0x%@", hexString];
    
    // 16進数値変換( '0xFFFFFF' => 0xFFFFFF )
    const char *str = [colorString UTF8String];
    char *endptr;
    return strtoll(str, &endptr, 0);
}

@end
