//
//  CCStyle.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// マージン構造体
typedef struct {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} CCMargin;

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

// サイズ取得
- (CGSize) callSize;

// ポイント取得
- (CGPoint) callPoint;

// フレーム取得
- (CGRect) callFrame;

// マージン取得(右)
- (CGFloat) callMarginRight;

// マージン取得(下)
- (CGFloat) callMarginBottom;

// ボーダー幅取得
- (CGFloat) callBorderWidth;

@end
