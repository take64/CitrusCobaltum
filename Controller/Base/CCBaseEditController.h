//
//  CCBaseEditController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/16.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseTableController.h"

@class CCBarButtonItem;

@interface CCBaseEditController : CCBaseTableController

//
// method
//

// 表示(保存ボタン)
- (BOOL) visibleSaveButton;

// 表示(削除ボタン)
- (BOOL) visibleRemoveButton;

// ボタン押下時(保存)
- (void) onTapBarButtonSave;

// ボタン押下時(削除)
- (void) onTapBarButtonRemove;

// フィールド内容変更処理
- (void) changeFieldWithIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass valueClass:(Class)valueClass;

// 保存処理
- (void) save;

// 削除処理
- (void) remove;

@end
