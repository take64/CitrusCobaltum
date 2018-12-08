//
//  CCColor.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/29.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCUIStruct.h"

@interface CCColor : NSObject

//
// method
//

// 16進数カラー から UIColor オブジェクトを取得
+ (UIColor *) colorWithHEXString:(NSString *)hexString;

// 16進数カラー から補色 UIColor オブジェクトを取得
+ (UIColor *) complementaryColorWithHEXString:(NSString *)hexString;

// CCColor(UIColor) から 16進数文字列を取得
+ (NSString *) hexStringWithColor:(UIColor *)colorValue;

// table background color
+ (UIColor *) colorTableBackground;

// 色構造体に変換する
+ (CCColorStruct) colorStructWithHEXString:(NSString *)hexString;

// 色構造体から UIColor オブジェクトを取得
+ (UIColor *) colorWithColorStruct:(CCColorStruct)colorStruct;

@end
