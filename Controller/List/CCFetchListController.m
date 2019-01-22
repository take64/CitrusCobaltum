//
//  CCFetchListController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCFetchListController.h"

#import "CCTableCell.h"



@interface CCFetchListController ()

@end



@implementation CCFetchListController

#pragma mark - synthesize
//
// synthesize
//
@synthesize fetchedResultsController;



#pragma mark - method
//
// extends
//

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // フェッチ
    [[self callFetchedResultsController] setDelegate:self];
    [[self callFetchedResultsController] performFetch:nil];
    
    [[self tableView] reloadData];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // フェッチ
    [[self callFetchedResultsController] setDelegate:nil];
    [self setFetchedResultsController:nil];
}



#pragma mark - extends
//
// extends
//

// セルデータ設定
- (void) bindCell:(CCTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell bindEntity:[[self callFetchedResultsController] objectAtIndexPath:indexPath]];
}

// セルヘッダタイトル取得
- (NSString *) callHeaderTitleWithSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self callFetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo name];
}



#pragma mark - singleton
//
// singleton
//

// fetch
- (NSFetchedResultsController *) callFetchedResultsController;
{
    return nil;
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数を返す
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[[self callFetchedResultsController] sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
// セクション数を返す
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self callFetchedResultsController] sections] count];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED;  // tell table which section corresponds to section title/index (e.g. "B",1))
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
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height
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
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);



#pragma mark - NSFetchedResultsControllerDelegate
//
// NSFetchedResultsControllerDelegate
//

// セルデータ変更後
- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self bindCell:(CCTableCell *)[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [[self tableView] reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

// セクション変更後
- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

// 変更前
- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}

// 変更語
- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}
//- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName;

@end
