//
//  CCBaseTableController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseTableController.h"

#import "CitrusCobaltumApplication.h"
#import "CCTheme.h"

#import "CitrusCobaltumTypedef.h"
#import "CCNavigationController.h"
#import "CCBarButtonItem.h"
#import "CCBasePresentationController.h"
#import "CCTableHeaderView.h"
#import "CCTableFooterView.h"
#import "CCTableViewContainer.h"

#import "CFNVL.h"



@interface CCBaseTableController ()

#pragma mark - property
//
// property
//

@property CCNavigationController *_navigationController;

@end



@implementation CCBaseTableController

#pragma mark - synthesize
//
// synthesize
//
@synthesize tableViewContainer;
@synthesize modalComplete;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // タイトル
        [self setTitle:[self callTitle]];

        // テーブルビューコンテナ
        [self setTableViewContainer:[[CCTableViewContainer alloc] initWithTableView:[self tableView] delegate:self]];

        // 長押し
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongTapCell:)];
        [[self tableView] addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

// タイトル取得
- (NSString *) callTitle
{
    return @"";
}

// 表示
- (void) showWithParent:(UIViewController *)parent
{
    if (parent == nil)
    {
        return;
    }
    
    // modal style
    [self setModalPresentationStyle:UIModalPresentationPageSheet];
    
    // バーボタン(閉じる)
    CCBarButtonItem *barButtonItem = [[CCBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonClose)];
    [[self navigationItem] setLeftBarButtonItems:@[ barButtonItem ]];
    
    CCBasePresentationController *presentation NS_VALID_UNTIL_END_OF_SCOPE;
    presentation = [[CCBasePresentationController alloc] initWithPresentedViewController:[self callNavigationController] presentingViewController:parent];
    [[self callNavigationController] setTransitioningDelegate:presentation];
    [parent presentViewController:[self callNavigationController] animated:YES completion:nil];
}

// 表示
- (void) showWithParent:(UIViewController *)parent complete:(CitrusCobaltumModalBlock)completeBlock
{
    // 画面閉じ完了
    [self setModalComplete:completeBlock];
    // 表示
    [self showWithParent:parent];
}

// 非表示
- (void) hide
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        // 画面閉じ完了がある場合
        if (self.modalComplete != nil)
        {
            self.modalComplete(self);
        }
    }];
}



#pragma mark - private
//
// private
//

// セルの長押し
- (void) onLongTapCell:(UILongPressGestureRecognizer*)gestureRecognizer
{
    // 長押しの開始以外はreturn
    if ([gestureRecognizer state] != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    // 位置特定
    CGPoint point = [gestureRecognizer locationInView:[self tableView]];
    NSIndexPath *indexPath = [[self tableView] indexPathForRowAtPoint:point];
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    // 処理を呼ぶ
    [self longTapCell:cell indexPath:indexPath];
}

// セルの長押し処理
- (void) longTapCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
}

// ボタン押下時(閉じる)
- (void) onTapBarButtonClose
{
    [self hide];
}



#pragma mark - singleton
//
// singleton
//

// call navigation controller
- (CCNavigationController *) callNavigationController
{
    if ([self _navigationController] == nil)
    {
        CCNavigationController *navigation = [[CCNavigationController alloc] initWithRootViewController:self];
        [navigation setTransitioningDelegate:self];
        [self set_navigationController:navigation];
    }
    return [self _navigationController];
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セルヘッダ高さ
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView *view = [[self tableViewContainer] callHeaderCacheWithSection:section title:nil];
    NSNumber *height = [CFNVL compare:view value1:@([view frame].size.height) value2:@(0)];
    return [height floatValue];
}

// セルフッタ高さ
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *view = [[self tableViewContainer] callFooterCacheWithSection:section title:nil];
    NSNumber *height = [CFNVL compare:view value1:@([view frame].size.height) value2:@(0)];
    return [height floatValue];
}

// セルヘッダを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[self tableViewContainer] callHeaderCacheWithSection:section title:nil];
}

// セルフッタを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[self tableViewContainer] callFooterCacheWithSection:section title:nil];
}



#pragma mark - UIViewControllerTransitioningDelegate
//
// UIViewControllerTransitioningDelegate
//

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

- (nullable UIPresentationController *) presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CCBasePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
