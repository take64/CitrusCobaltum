//
//  CCTableCellTextFieldInnerTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCTableCellTextFieldInnerTextField;

typedef void (^CCTableCellTextFieldInnerTextFieldEditingEndBlock)(CCTableCellTextFieldInnerTextField *textFieldValue);

@interface CCTableCellTextFieldInnerTextField : UITextField
{
    // メニュー状態
    BOOL enableMenu;
}

//
// property
//
@property (nonatomic, assign) BOOL enableMenu;



//
// method
//

// ボタン押下時ブロック
- (void) setOnEditingEndComplete:(CCTableCellTextFieldInnerTextFieldEditingEndBlock)completeBlock;

@end
