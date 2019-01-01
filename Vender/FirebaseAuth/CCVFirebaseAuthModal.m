//
//  CCVFirebaseAuthModal.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/02.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCVFirebaseAuthModal.h"

#import "CitrusCobaltumVenderFirebaseAuth.h"
#import "CCColor.h"
#import "CCLabel.h"
#import "CCTableCellLabel.h"
#import "CCStyle.h"



@interface CCVFirebaseAuthModal ()

#pragma mark - property
//
// property
//
@property NSDictionary *colors;

@end



@implementation CCVFirebaseAuthModal

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
        [self setKeys:[@[
                         [@[ kFirebaseAuthTypeGoogle, kFirebaseAuthTypeTwitter, ] mutableCopy]
                         ] mutableCopy]];
        [self setValues:[@{
                           kFirebaseAuthTypeGoogle  :kFirebaseAuthNameGoogle,
                           kFirebaseAuthTypeTwitter :kFirebaseAuthNameTwitter,
                           } mutableCopy]];
        [self setColors:@{
                          kFirebaseAuthTypeGoogle   :@"db4a39",
                          kFirebaseAuthTypeTwitter  :@"305097",
                          }];

        // Google
        [[CCVFirebaseAuthGoogle sharedService] bindBlockSignIn:^(FIRUser *user, NSError *error) {
            // access_deniedの時はGoogle画面が残るので1回余計にhideする
            if ([error code] == -5)
            {
                [self hide];
            }
            [self hide];
        } signOut:^(FIRUser *user, NSError *error) {
            [self hide];
        }];
        
        // Twitter
        [[CCVFirebaseAuthTwitter sharedService] bindBlockSignIn:^(FIRUser *user, NSError *error) {
            [self hide];
        } signOut:^(FIRUser *user, NSError *error) {
            [self hide];
        }];
    }
    return self;
}




#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
// セルを返却する
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";

    CCTableCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil)
    {
        cell = [[CCTableCellLabel alloc] initWithPrefix:nil reuseIdentifier:CellId];
        [[[cell prefixLabel] callStyle] addStyleKey:@"color" value:@"FFFFFF"];
        [[[cell label] callStyle] addStyleKey:@"text-align" value:@"center"];
    }
    if (cell != nil)
    {
        NSInteger section   = [indexPath section];
        NSInteger row       = [indexPath row];
        NSString *authType  = [[[self keys] objectAtIndex:section] objectAtIndex:row];

        NSString *valString = [[self values] objectForKey:authType];
        [[cell prefixLabel] setTitle:valString];

        // 接続情報
        NSString *connectionString = @"(未接続)";

        // Google
        if ([authType isEqualToString:kFirebaseAuthTypeGoogle] == YES && [CCVFirebaseAuth isSignInGoogle] == YES)
        {
            connectionString = @"接続済";
        }
        // Twitter
        else if ([authType isEqualToString:kFirebaseAuthTypeTwitter] == YES && [CCVFirebaseAuth isSignInTwitter] == YES)
        {
            connectionString = @"接続済";
        }

        [cell setContentText:connectionString];

        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if ([[[self values] allValues] containsObject:authType] == YES)
        {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    return cell;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;





#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    NSString *_selectedKey = [[[self keys] objectAtIndex:section] objectAtIndex:row];
    NSString *colorCode = [[self colors] objectForKey:_selectedKey];

    [(CCTableCellLabel *)cell setBackgroundColor:[CCColor colorWithHEXString:colorCode]];
    [[[(CCTableCellLabel *)cell label] callStyle] addStyleKey:@"color" value:@"FFFFFF"];
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section;
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section   = [indexPath section];
    NSInteger row       = [indexPath row];
    NSString *authType  = [[[self keys] objectAtIndex:section] objectAtIndex:row];
    if ([authType isEqualToString:kFirebaseAuthTypeGoogle] == YES)
    {
        if ([CCVFirebaseAuthGoogle isSignIn] == YES)
        {
            [[CCVFirebaseAuthGoogle sharedService] signOutWithControllr:self];
        }
        else
        {
            [[CCVFirebaseAuthGoogle sharedService] signInWithControllr:self];
        }
    }
    else if ([authType isEqualToString:kFirebaseAuthTypeTwitter] == YES)
    {
        if ([CCVFirebaseAuthTwitter isSignIn] == YES)
        {
            [[CCVFirebaseAuthTwitter sharedService] signOutWithControllr:self];
        }
        else
        {
            [[CCVFirebaseAuthTwitter sharedService] signInWithControllr:self];
        }
    }
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context;
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator;
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView;


#pragma mark - GIDSignInUIDelegate
//
// GIDSignInUIDelegate
//

@end
