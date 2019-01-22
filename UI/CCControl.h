//
//  CCControl.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// state
typedef enum {
    CCControlStateNormal,
    CCControlStateHighlighted,
    CCControlStateDisabled,
} CCControlState;

@class CCStyle;

@interface CCControl : UIControl
{
    // パーツタイトル
    NSString *title;
    
    // 拡張用情報
    NSMutableDictionary *userInfo;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableDictionary *userInfo;



//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue;

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue styleKeys:(NSDictionary *)styleKeys;

// 初期化
- (instancetype) initWithStyleKeys:(NSDictionary *)styleKeys;

// 初期化
- (instancetype) initWithStyleKeys:(NSDictionary *)styleKeys addStyleKeys:(NSDictionary *)addStyleKeys;

// タイトルが設定されているか
- (BOOL) hasTitle;

// スタイル取得(normalのエイリアス)
- (CCStyle *) callStyle;

// スタイル設定(normalのエイリアス)
- (void) bindStyle:(CCStyle *)styleValue;

// スタイル取得(normal)
- (CCStyle *) callStyleNormal;

// スタイル設定(normal)
- (void) bindStyleNormal:(CCStyle *)styleValue;

// スタイル取得(highlighted)
- (CCStyle *) callStyleHighlighted;

// スタイル設定(highlighted)
- (void) bindStyleHighlighted:(CCStyle *)styleValue;

// スタイル取得(disabled)
- (CCStyle *) callStyleDisabled;

// スタイル設定(disabled)
- (void) bindStyleDisabled:(CCStyle *)styleValue;

// 自動テキストサイズ計算
- (CGSize) calcTextAutoSize;

// 自動テキストサイズ計算(パディング込み)
- (CGSize) calcTextAutoSizeWithPadding;

@end
