//
//  CCSectionSelectionListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/29.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCSectionListController.h"

@class CCSectionItem;

// 汎用ブロック
typedef void (^CitrusCobaltumSectionSelectionBlock)(CCSectionItem *item);

@interface CCSectionSelectionListController : CCSectionListController

//
// property
//
@property (nonatomic, copy)   CitrusCobaltumSectionSelectionBlock selectionBlock;
@property (nonatomic, retain) CCSectionItem *selectionItem;



//
// method
//

// 選択設定
- (void) selectionItemkey:(NSString *)selectionItemKey;

@end
