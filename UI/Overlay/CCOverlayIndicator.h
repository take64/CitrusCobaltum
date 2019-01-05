//
//  CCOverlayIndicator.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCControl.h"

@interface CCOverlayIndicator : CCControl

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

@end
