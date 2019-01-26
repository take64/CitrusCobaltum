//
//  CCTableCellButtonTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/11.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextField.h"

@class CCImageButton;

@interface CCTableCellButtonTextField : CCTableCellTextField <UITextFieldDelegate>

//
// property
//
@property (nonatomic, retain) CCImageButton *clearButton;
@property (nonatomic, retain) CCButton *selectButton;



//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

@end
