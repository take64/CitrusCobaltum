//
//  CCColor.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/29.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

// 色構造体
typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} CCColorStruct;

@interface CCColor : NSObject

//
// method
//

// 16進数カラー からCCColor(UIColor) オブジェクトを取得
+ (UIColor *) colorWithHEXString:(NSString *)hexString;

// 16進数カラー から補色CCColor(UIColor) オブジェクトを取得
+ (UIColor *) complementaryColorWithHEXString:(NSString *)hexString;

// CCColor(UIColor) から 16進数文字列を取得
+ (NSString *) hexStringWithColor:(UIColor *)colorValue;

// table background color
+ (UIColor *) colorTableBackground;

@end
