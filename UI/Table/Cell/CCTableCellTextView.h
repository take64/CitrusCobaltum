//
//  CCTableCellTextView.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCell.h"

#import "CitrusCobaltumTypedef.h"

@interface CCTableCellTextView : CCTableCell <UITextViewDelegate>

//
// property
//
@property (nonatomic, copy) CitrusCobaltumBlock didEndEditingBlock;



//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier;

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

@end
