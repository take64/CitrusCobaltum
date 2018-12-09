//
//  CCStyle.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
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
- (void) addStyleKeys:(NSDictionary *)keyValues;

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

// フォント要素取得
- (NSMutableDictionary *) callFontAttributes;

// サイズ取得
- (CGSize) callSize;

// サイズ設定
- (void) setSize:(CGSize)size;

// ポイント取得
- (CGPoint) callPoint;

// ポイント設定
- (void) setPoint:(CGPoint)point;

// フレーム取得
- (CGRect) callFrame;

// フレーム設定
- (void) setFrame:(CGRect)frame;

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

// 横文字寄せ取得
- (NSTextAlignment) callTextAlignment;

// 横文字寄せ設定
- (void) setTextAlignment:(NSTextAlignment)textAlignment;

// 縦文字寄せ取得
- (CCVerticalAlignment) callVerticalAlignment;

// 背景色取得
- (CCColorStruct) callBackgroundColor;

// フォントをアジャストさせる
- (void) fontAdjustmentWithText:(NSString *)textValue rect:(CGRect)rect;

@end
