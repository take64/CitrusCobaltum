//
//  CCTableCellTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCell.h"

@class CCTableCellTextFieldInnerTextField;

@interface CCTableCellTextField : CCTableCell <UITextFieldDelegate>
{
    // 内包するテキストフィールド
    CCTableCellTextFieldInnerTextField *innerTextField;
}

//
// property
//

@property (nonatomic, retain) CCTableCellTextFieldInnerTextField *innerTextField;



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

// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CCTableCell *)tableCell;

// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CCTableCell *)tableCell;

@end
