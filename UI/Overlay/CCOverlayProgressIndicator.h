//
//  CCOverlayProgressIndicator.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCControl.h"

@interface CCOverlayProgressIndicator : CCControl

//
// method
//

// 初期化
- (instancetype) initWithParent:(UIView *)view;

// 表示
- (void) show;

// 非表示
- (void) hide;

// タイトル
- (void) setTitle:(NSString *) stringValue;

// メッセージ
- (void) setMessage:(NSString *) stringValue;

// パーセンテージ
- (void) setPercentage:(NSString *) stringValue;

// 分子更新
- (void) updateNumerator:(NSNumber *)numberValue;

// 分母更新
- (void) updateDenominator:(NSNumber *)numberValue;

// 分子分母更新
- (void) updateNumerator:(NSNumber *)numberValue1 denominator:(NSNumber *)numberValue2;

// 分子等更新
- (void) updateWithInfo:(NSDictionary *)infoValue;

@end
