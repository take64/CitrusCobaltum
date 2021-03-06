//
//  CCBaseEditController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/16.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseEditController.h"

#import "CitrusCobaltumApplication.h"
#import "CCBarButtonItem.h"
#import "CCTableCellTextField.h"
#import "CCTableCellTextView.h"
#import "CCTheme.h"

#import "CFDecimal.h"
#import "CFEmptyVL.h"
#import "CFNVL.h"



@interface CCBaseEditController ()

#pragma mark - property
//
// property
//
@property CCBarButtonItem *saveBarButton;
@property CCBarButtonItem *removeBarButton;
@property UIAlertController *removeAlertController;

@end



@implementation CCBaseEditController

#pragma mark - synthesize
//
// synthesize
//
@synthesize entity;
@synthesize rowOfSection;
@synthesize headTitles;
@synthesize datastore;
@synthesize temporary;
@synthesize relations;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // part
        CCBarButtonItem *barButtonItem;
        
        // テーブル線タイプ
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        // セクション内セル数
        [self setRowOfSection:@[]];
        
        // ヘッダタイトル
        [self setHeadTitles:@[]];
        
        // バーボタン(保存)
        barButtonItem = [[CCBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonSave)];
        [self setSaveBarButton:barButtonItem];
        // バーボタン(削除)
        barButtonItem = [[CCBarButtonItem alloc] initWithTitle:@"削除" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonRemove)];
        [barButtonItem setTintColor:[UIColor redColor]];
        [self setRemoveBarButton:barButtonItem];
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // バーボタン再描画
    [self redrawBarButton];
}



#pragma mark - method
//
// method
//

// 表示(保存ボタン)
- (BOOL) visibleSaveButton
{
    return YES;
}

// 表示(削除ボタン)
- (BOOL) visibleRemoveButton
{
    return ([self entity] != nil);
}

// ボタン押下時(保存)
- (void) onTapBarButtonSave
{
    [self save];
}

// ボタン押下時(削除)
- (void) onTapBarButtonRemove
{
    [self presentViewController:[self callRemoveAlertController] animated:YES completion:nil];
}

// フィールド内容変更時
- (void) onChangeField
{
    
}

// フィールド内容変更処理
- (void) changeFieldWithIndexPath:(NSIndexPath *)indexPath cellClass:(Class)cellClass valueClass:(Class)valueClass
{
    CCTableCell *tableCell = [[self tableView] cellForRowAtIndexPath:indexPath];
    if (tableCell == nil)
    {
        return;
    }
    
    // CCTableCellTextField
    // CCTableCellTextView
    // のいずれか、か？
    if ([@[
           [CCTableCellTextField class],
           [CCTableCellTextView class],
           ] containsObject:cellClass] == NO)
    {
        return;
    }
    
    // 入力値
    NSString *stringValue = [tableCell contentText];
    
    // default
    id defaultValue = [NSNull null];
    id settingValue = [NSNull null];
    // convert class
    if (valueClass == [NSString class])
    {
        defaultValue = @"";
        settingValue = stringValue;
    }
    else if (valueClass == [NSNumber class])
    {
        defaultValue = @0;
        settingValue = @([stringValue integerValue]);
    }
    else if (valueClass == [NSDecimalNumber class])
    {
        defaultValue = [NSDecimalNumber zero];
        settingValue = [CFDecimal decimalWithString:stringValue];
    }
    settingValue = [CFEmptyVL compare:stringValue value1:settingValue value2:defaultValue];
    
    // 設定
    [[self temporary] setObject:settingValue forKey:indexPath];
}

// 保存処理
- (void) save
{
    
}

// 削除処理
- (void) remove
{
    
}

// バーボタン再描画
- (void) redrawBarButton
{
    NSMutableArray<CCBarButtonItem *> *barButtonItems;
    
    // バーボタン表示
    barButtonItems = [@[] mutableCopy];
    if ([self visibleSaveButton] == YES)
    {
        [barButtonItems addObject:[self saveBarButton]];
    }
    [[self navigationItem] setRightBarButtonItems:barButtonItems];
    
    // ツールバーボタン表示
    barButtonItems = [[CFNVL compare:[self toolbarItems] replace:@[]] mutableCopy];
    // entityが無い場合で、ツールバーに削除ボタンがある場合は除去
    if ([self entity] == nil && [barButtonItems indexOfObject:[self removeBarButton]] != NSNotFound)
    {
        [barButtonItems removeObject:[self removeBarButton]];
    }
    if ([self entity] != nil && [self visibleRemoveButton] == YES
        && [barButtonItems indexOfObject:[self removeBarButton]] == NSNotFound)
    {
        [barButtonItems insertObject:[self removeBarButton] atIndex:0];
    }
    [self setToolbarItems:barButtonItems];
    [[self navigationController] setToolbarHidden:([barButtonItems count] == 0)];
}



#pragma mark - singleton
//
// singleton
//

// 削除アラート
- (UIAlertController *) callRemoveAlertController
{
    if ([self removeAlertController] == nil)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"削除してよろしいですか？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"削除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self remove];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // none
        }]];
        [self setRemoveAlertController:alert];
    }
    return [self removeAlertController];
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数を返す
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self rowOfSection] objectAtIndex:section] integerValue];
}

// セルを返す
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// セクション数を返す
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self rowOfSection] count];
}
// ヘッダタイトル
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self headTitles] objectAtIndex:section];
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath:]
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;



#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
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
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);

@end
