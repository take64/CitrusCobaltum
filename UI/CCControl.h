//
//  CCControl.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
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
    NSString *title;
}

//
// property
//
@property (nonatomic, retain) NSString *title;



//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue;

// スタイル取得(normalのエイリアス)
- (CCStyle *) callStyle;

// スタイル設定(normalのエイリアス)
- (void) setStyle:(CCStyle *)styleValue;

// スタイル取得(normal)
- (CCStyle *) callStyleNormal;

// スタイル設定(normal)
- (void) setStyleNormal:(CCStyle *)styleValue;

// スタイル取得(highlighted)
- (CCStyle *) callStyleHighlighted;

// スタイル設定(highlighted)
- (void) setStyleHighlighted:(CCStyle *)styleValue;

// スタイル取得(disabled)
- (CCStyle *) callStyleDisabled;

// スタイル設定(disabled)
- (void) setStyleDisabled:(CCStyle *)styleValue;

@end
