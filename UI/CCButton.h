//
//  CCButton.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/02.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCControl.h"

#import "CCUIStruct.h"

@class CCButton;

@interface CCButton : CCControl

//
// method
//

// ボタン押下時ブロック
- (void) setOnTappedComplete:(CCButtonTappedBlock)completeBLock;

// ボタン押下時
- (void) onTapButton:(CCButton *)buttonValue;

@end
