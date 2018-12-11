//
//  CCTableCellButtonTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/11.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextField.h"

@interface CCTableCellButtonTextField : CCTableCellTextField <UITextFieldDelegate>

//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// テキスト取得
- (NSString *) contentText;

// テキスト設定
- (void) setContentText:(NSString *)stringValue;

@end
