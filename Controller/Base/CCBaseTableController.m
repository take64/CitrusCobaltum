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
#import "CCTableHeaderView.h"
#import "CCTableFooterView.h"
#import "CCTableViewContainer.h"

#import "CFNVL.h"



@interface CCBaseTableController ()

@end



@implementation CCBaseTableController

#pragma mark - synthesize
//
// synthesize
//
@synthesize tableViewContainer;



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



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セルヘッダ高さ
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView *view = [[self tableViewContainer] callHeaderCacheWithSection:section];
    NSNumber *height = [CFNVL compare:view value1:@([view frame].size.height) value2:@(0)];
    return [height floatValue];
}

// セルフッタ高さ
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *view = [[self tableViewContainer] callFooterCacheWithSection:section];
    NSNumber *height = [CFNVL compare:view value1:@([view frame].size.height) value2:@(0)];
    return [height floatValue];
}

// セルヘッダを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[self tableViewContainer] callHeaderCacheWithSection:section];
}

// セルフッタを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[self tableViewContainer] callFooterCacheWithSection:section];
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
- (void) longTapCell:(UITableViewCell *)cellValue indexPath:(NSIndexPath *)indexPath
{
    
}

@end
