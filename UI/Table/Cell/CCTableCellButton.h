//
//  CCTableCellButton.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/12.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCell.h"

@class CCButton;

@interface CCTableCellButton : CCTableCell

//
// property
//
@property (nonatomic, retain) CCButton *button;


//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString reuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

@end
