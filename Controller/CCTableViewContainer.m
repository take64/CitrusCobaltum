//
//  CCTableViewContainer.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/05.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCTableViewContainer.h"

#import "CitrusCobaltumTypedef.h"
#import "CCTableHeaderView.h"
#import "CCTableFooterView.h"
#import "CCUIStruct.h"



@implementation CCTableViewContainer

#pragma mark - synthesize
//
// synthesize
//
@synthesize tableViewDelegate;
@synthesize tableView;
@synthesize headerCaches;
@synthesize footerCaches;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTableView:(UITableView *)view delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate
{
    self = [super init];
    if (self)
    {
        [self setTableView:view];
        [self setTableViewDelegate:delegate];
    }
    return self;
}

// ヘッダキャッシュの取得
- (UIView *) callHeaderCacheWithSection:(NSInteger)section
{
    UIView *cacheView = [[self headerCaches] objectForKey:@(section)];
    if (cacheView == nil)
    {
        // delegateから取得
        NSString *titleString = nil;
        if ([[self tableViewDelegate] respondsToSelector:@selector(tableView:titleForHeaderInSection:)] == YES)
        {
            titleString = [[self tableViewDelegate] tableView:[self tableView] titleForHeaderInSection:section];
        }

        // タイトル文字列がある場合
        if (titleString != nil && [titleString length] > 0)
        {
            cacheView = [[CCTableHeaderView alloc] initWithReuseIdentifierWithSection:section];
            [(CCTableHeaderView *)cacheView bindTitle:titleString];
        }
        
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
        // delegateから取得
        NSString *titleString = nil;
        if ([[self tableViewDelegate] respondsToSelector:@selector(tableView:titleForFooterInSection:)] == YES)
        {
            titleString = [[self tableViewDelegate] tableView:[self tableView] titleForFooterInSection:section];
        }
        
        // タイトル文字列がある場合
        if (titleString != nil && [titleString length] > 0)
        {
            cacheView = [[CCTableFooterView alloc] initWithReuseIdentifierWithSection:section];
            [(CCTableFooterView *)cacheView bindTitle:titleString];
        }
        
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

@end
