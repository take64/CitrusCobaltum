//
//  CCButton.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/02.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCControl.h"

@class CCButton;

typedef void (^CCButtonTappedBlock)(CCButton *buttonValue);

@interface CCButton : CCControl

//
// method
//

// ボタン押下時ブロック
- (void) setOnTappedComplete:(CCButtonTappedBlock)completeBLock;

// ボタン押下時
- (void) onTapButton:(CCButton *)buttonValue;

@end
