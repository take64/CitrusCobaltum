//
//  CCTableCellTextFieldInnerTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CCTableCellTextFieldInnerTextFieldEditingEndBlock)(CCTableCellTextFieldInnerTextField *textFieldValue);

@interface CCTableCellTextFieldInnerTextField : UITextField

//
// method
//

// ボタン押下時ブロック
- (void) setOnEditingEndComplete:(CCTableCellTextFieldInnerTextFieldEditingEndBlock)completeBlock;

@end
