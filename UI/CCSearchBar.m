//
//  CCSearchBar.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCSearchBar.h"



@interface CCSearchBar()

#pragma mark - property
//
// property
//
@property CitrusCobaltumSearchBarBlock suggestBlock;
@property CitrusCobaltumSearchBarBlock searchBlock;
@property NSArray<NSString *> *_suggestList;
@property UITableView *_tableView;
@property NSNotificationCenter *keydoardNotification;
@property CGFloat keyboardHeight;

@end



@implementation CCSearchBar

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self setDelegate:self];
        
        // キーボード通知
        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
        [notification addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
        [notification addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}



#pragma mark - private
//
// private
//

// 検索結果表示
- (void)showKeywords:(NSArray<NSString *> *)suggestList
{
    // キーワードの設定
    [self set_suggestList:suggestList];
    
    // 基準になるWindow
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    // ビューの貼り付け
    [window addSubview:[self callTableView]];
    
    // 表示位置の修正
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    CGRect searchBarRect = [window convertRect:[self frame] toWindow:window];
    CGRect navigationBarRect = [window convertRect:[[self superview] frame] toWindow:window];
    CGFloat left = searchBarRect.origin.x;
    CGFloat top = statusBarRect.size.height + navigationBarRect.size.height;
    CGFloat width = searchBarRect.size.width;
    CGFloat height = [window frame].size.height - [self keyboardHeight] - top;
    [[self callTableView] setFrame:CGRectMake(left, top, width, height - 20)];
    
    // ビューの読み込み
    [[self callTableView] reloadData];
}

// 検索結果非表示
- (void)hideKeywords
{
    [[self callTableView] removeFromSuperview];
}



#pragma mark - notification
//
// notification
//

// キーボード表示
- (void)showKeyboard:(NSNotification *)notification
{
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self setKeyboardHeight:keyboardRect.size.height];
}
// キーボード非表示
- (void)hideKeyboard:(NSNotification *)notification
{
    [self setKeyboardHeight:0];
}



#pragma mark - singleton
//
// singleton
//

// テーブルビュー
- (UITableView *)callTableView
{
    if ([self _tableView] == nil)
    {
        UITableView *tableView;
        
        // 基準になるWindow
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        // 位置情報の確定
        CGRect rect = [window convertRect:[self bounds] fromWindow:window];
        
        // 初期化
        tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        
        // セルの登録
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        // 見た目調整
        [[tableView layer] setShadowOffset:CGSizeMake(8, 8)];
        [[tableView layer] setShadowColor:[[UIColor blackColor] CGColor]];
        [[tableView layer] setShadowRadius:8];
        [[tableView layer] setShadowOpacity:1];
        [[tableView layer] setShouldRasterize:YES];
        [[tableView layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        [[tableView layer] setMasksToBounds:NO];
        
        // 設定
        [self set_tableView:tableView];
    }
    return [self _tableView];
}



#pragma mark - UISearchBarDelegate
//
// UISearchBarDelegate
//

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
// テキスト変更時
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.suggestBlock != nil)
    {
        self.suggestBlock(searchText);
    }
}
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); // called before text changes
// 検索ボタン押下時
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchBlock != nil)
    {
        self.searchBlock([searchBar text]);
    }
    
    [self hideKeywords];
}
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; // called when bookmark button pressed
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
//- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; // called when search results button pressed
//
//- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0);



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self _suggestList] count];
}
// セルの返却
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    if(cell != nil)
    {
        [[cell textLabel] setText:[[self _suggestList] objectAtIndex:[indexPath row]]];
    }
    
    return cell;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;




#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
// セルタップ時
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyword = [[self _suggestList] objectAtIndex:[indexPath row]];
    
    // 設定
    [self setText:keyword];
    
    // 先に非表示化
    [self hideKeywords];
    
    if (self.searchBlock != nil)
    {
        self.searchBlock(keyword);
    }
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);



#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [self hideKeywords];
}
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0);
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
// xボタン押下時
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self setText:@""];
    [self hideKeywords];
    return NO;
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.

@end
