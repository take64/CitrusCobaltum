//
//  CCTableCellFavorite.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellLabel.h"

#import "CCUIStruct.h"

@interface CCTableCellFavorite : CCTableCellLabel

//
// property
//
@property (nonatomic, assign) CitrusCobaltumSwitchBlock switchBlock;
@property (nonatomic, assign, getter=isOn) BOOL on;



//
// method
//

// スイッチ
- (void) switchOn:(BOOL)onValue;

@end
