//
//  CCBaseTableController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCBaseTableController.h"

#import "CCTableViewTrait.h"
#import "CCUIStruct.h"


@interface CCBaseTableController ()

#pragma mark - property
//
// property
//
@property BOOL cacheEnable;
@property NSMutableDictionary *headerCaches;
@property NSMutableDictionary *footerCaches;

@end



@implementation CCBaseTableController

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
        
        // cache
        [self setCacheEnable:NO];
        [self setHeaderCaches:[@{} mutableCopy]];
        [self setFooterCaches:[@{} mutableCopy]];
        
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
    UIView *headerView = [self callHeaderCacheWithSection:section];
    if (headerView == nil)
    {
        return 0;
    }
    
    return CC8(3);
}

// セルフッタ高さ
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *footerView = [self callFooterCacheWithSection:section];
    if (footerView == nil)
    {
        return 0;
    }
    return [footerView frame].size.height;
}

// セルヘッダを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self callHeaderCacheWithSection:section];
}

// セルフッタを返す
- (nullable UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self callFooterCacheWithSection:section];
}



#pragma mark - private
//
// private
//

// ヘッダキャッシュの取得
- (UIView *) callHeaderCacheWithSection:(NSInteger)section
{
    UIView *cacheView = [[self headerCaches] objectForKey:@(section)];
    if (cacheView == nil)
    {
        cacheView = [CCTableViewTrait callTableHeaderViewWithController:self tableView:[self tableView] section:section];
        [self saveCache:[self headerCaches] section:section view:cacheView];
    }
    return cacheView;
}

// フッタキャッシュの取得
- (UIView *) callFooterCacheWithSection:(NSInteger)section
{
    UIView *cacheView = [[self footerCaches] objectForKey:@(section)];
    if (cacheView == nil)
    {
        cacheView = [CCTableViewTrait callTableFooterViewWithController:self tableView:[self tableView] section:section];
        [self saveCache:[self footerCaches] section:section view:cacheView];
    }
    return cacheView;
}

// ヘッダ/フッタキャッシュの追加
- (void) saveCache:(NSMutableDictionary *)caches section:(NSInteger)section view:(UIView *)viewValue
{
    if (viewValue == nil)
    {
        return;
    }
    [caches setObject:viewValue forKey:@(section)];
}

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
