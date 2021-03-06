//
//  CCBaseListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseTableController.h"
#import <CoreData/CoreData.h>

@class CCTableCell;


@interface CCBaseListController : CCBaseTableController

//
// property
//
@property (nonatomic, retain) id selectionData;



//
// method
//

// セルデータ設定
- (void) bindCell:(CCTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;

// バーボタン再描画
- (void) redrawBarButton;

// 表示(追加ボタン)
- (BOOL) visibleAddButton;

// 表示(編集ボタン)
- (BOOL) visibleEditButton;

// 表示(選択ボタン)
- (BOOL) visibleSelectButton;

// 編集時(移動可能)
- (BOOL) canMoveEditing;

// ボタン押下時(追加)
- (void) onTapBarButtonAdd;

// ボタン押下時(編集開始)
- (void) onTapBarButtonEditStart;

// ボタン押下時(編集終了)
- (void) onTapBarButtonEditEnd;

// ボタン押下時(選択)
- (void) onTapBarButtonSelect;

@end
