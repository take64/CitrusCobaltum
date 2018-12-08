//
//  CCButtonGroup.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/08.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCControl.h"

#import "CCUIStruct.h"

@class CCButton;
@class CCBarButtonItem;



@interface CCButtonGroup : CCControl

//
// method
//

// ボタングループの生成
+ (instancetype) bottunGroup;

// ボタンの追加
- (void) addButton:(CCButton *)buttonValue;

// ボタンの追加(文字列から)
- (CCButton *) addButtonWithTitle:(NSString *)titleString complete:(CCButtonTappedBlock)completeBlock;

// CTBarButtonItemへ変換
- (CCBarButtonItem *) toBarButtonItem;

@end
