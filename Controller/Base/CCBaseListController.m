//
//  CCBaseListController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseListController.h"

#import "CCButton.h"
#import "CCButtonGroup.h"
#import "CCBarButtonItem.h"



@interface CCBaseListController ()

#pragma mark - property
//
// property
//
@property CCButtonGroup *buttonGroup;
@property CCButton *addButton;
@property CCButton *editStartButton;
@property CCButton *editEndButton;
@property CCButton *selectButton;

@end



@implementation CCBaseListController

#pragma mark - synthesize
//
// synthesize
//
@synthesize selectionData;



#pragma mark - method
//
// method
//

// init
- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // ボタンとグループ
        CCButton *button;
        CCButtonGroup *buttonGroup = [[CCButtonGroup alloc] initWithFrame:CGRectZero];
        button = [buttonGroup addButtonWithTitle:@"追加" complete:^(CCButton *buttonValue) {
            [self onTapBarButtonAdd];
        }];
        [self setAddButton:button];
        button = [buttonGroup addButtonWithTitle:@"編集" complete:^(CCButton *buttonValue) {
            [self onTapBarButtonEditStart];
        }];
        [self setEditStartButton:button];
        button = [buttonGroup addButtonWithTitle:@"完了" complete:^(CCButton *buttonValue) {
            [self onTapBarButtonEditEnd];
        }];
        [self setEditEndButton:button];
        button = [buttonGroup addButtonWithTitle:@"選択" complete:^(CCButton *buttonValue) {
            [self onTapBarButtonSelect];
        }];
        [self setSelectButton:button];
        [self setButtonGroup:buttonGroup];
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // バーボタン再描画
    [self redrawBarButton];
    
    [[self tableView] reloadData];
}

// セルデータ設定
- (void) bindCell:(CCTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

// 表示(追加ボタン)
- (BOOL) visibleAddButton
{
    return NO;
}

// 表示(編集ボタン)
- (BOOL) visibleEditButton
{
    return NO;
}

// 表示(選択ボタン)
- (BOOL) visibleSelectButton
{
    return NO;
}

// 編集時(移動可能)
- (BOOL) canMoveEditing
{
    return YES;
}

// 編集時(移動の際にセクションを変えても良い)
- (BOOL) allowMoveSectionModify
{
    return NO;
}

// ボタン押下時(追加)
- (void) onTapBarButtonAdd
{
}

// ボタン押下時(編集開始)
- (void) onTapBarButtonEditStart
{
    [[self tableView] setEditing:YES animated:YES];
    
    // ボーボタン再描画
    [self redrawBarButton];
}

// ボタン押下時(編集終了)
- (void) onTapBarButtonEditEnd
{
    [[self tableView] setEditing:NO animated:YES];
    
    // ボーボタン再描画
    [self redrawBarButton];
}

// ボタン押下時(選択)
- (void) onTapBarButtonSelect
{
}



#pragma mark - private
//
// private
//

// バーボタン再描画
- (void) redrawBarButton
{
    // 追加ボタン
    [[self addButton] setHidden:(([self visibleAddButton] == YES && [[self tableView] isEditing] == NO) == NO)];
    // 編集(平常時)ボタン
    [[self editStartButton] setHidden:(([self visibleEditButton] == YES && [[self tableView] isEditing] == NO) == NO)];
    // 編集(編集中)ボタン
    [[self editEndButton] setHidden:(([self visibleEditButton] == YES && [[self tableView] isEditing] == YES) == NO)];
    // 選択ボタン
    [[self selectButton] setHidden:(([self visibleSelectButton] == YES && [[self tableView] isEditing] == NO) == NO)];
    
    // ボタン設定
    [[self buttonGroup] setNeedsLayout];
    [[self navigationItem] setRightBarButtonItem:[[self buttonGroup] toBarButtonItem]];
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// 編集時移動可能
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self canMoveEditing];
}
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // ソート編集を可能にする為、このメソッドはコメント化してはいけない
}



#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (nullable UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (nullable UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED; // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED;

// セクション変更時のセル設定
- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    // セクションを変更してはいけない
    if ([self allowMoveSectionModify] == NO)
    {
        if ([sourceIndexPath section] != [proposedDestinationIndexPath section])
        {
            return sourceIndexPath;
        }
    }
    return proposedDestinationIndexPath;
}
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);

@end
