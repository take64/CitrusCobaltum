//
//  CCStyle.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CCUIStruct.h"

@interface CCStyle : NSObject <NSCopying>

//
// method
//

// 初期化
- (instancetype) initWithStyleDictionary:(NSDictionary *)dictionaryValue;

// スタイルの追加
- (void) addStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// スタイルの一括追加
- (void) addStyleDictionary:(NSDictionary *)dictionaryValue;

// キーの削除
- (void) removeStyleKey:(NSString *)keyValue;

// スタイル値の取得
- (NSString *) styleForKey:(NSString *)keyValue;

// スタイル値の設定
- (void) setStyleKey:(NSString *)keyValue value:(NSString *)dataValue;

// スタイルの一括設定
- (void) setStyleDictionary:(NSDictionary *)dictionaryValue;

// スタイルの全取得
- (NSMutableDictionary *) allStyles;

// フォント取得
- (UIFont *) callFont;

// フォントサイズ取得
- (CGFloat) callFontSize;

// サイズ取得
- (CGSize) callSize;

// ポイント取得
- (CGPoint) callPoint;

// フレーム取得
- (CGRect) callFrame;

// マージン取得
- (CCMargin) callMargin;

// パッディング取得
- (CCPadding) callPadding;

// 角丸取得
- (CCRadius) callBorderRadius;

// ボックス影取得
- (CCShadow) callBoxShadow;

// 文字色取得
- (CCColorStruct) callColor;

// テキスト影取得
- (CCShadow) callTextShadow;

// ボーダー幅取得
- (CGFloat) callBorderWidth;

// ボーダー色取得
- (CCColorStruct) callBorderColor;

// ラインブレイク取得
- (NSLineBreakMode) callLineBreak;

// 文字寄せ取得
- (NSTextAlignment) callTextAlign;

// 背景色取得
- (CCColorStruct) callBackgroundColor;

// フォントをアジャストさせる
- (void) fontAdjustmentWithText:(NSString *)textValue rect:(CGRect)rect;

@end
