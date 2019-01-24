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
#import "CCThemeTableView.h"
#import "CCUIStruct.h"

#import "CFString.h"



@implementation CCTableViewContainer

#pragma mark - synthesize
//
// synthesize
//
@synthesize tableViewDelegate;
@synthesize tableView;
@synthesize headerCaches;
@synthesize footerCaches;
@synthesize theme;



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
        
        [self setHeaderCaches:[@{} mutableCopy]];
        [self setFooterCaches:[@{} mutableCopy]];
    }
    return self;
}

// ヘッダキャッシュの取得
- (UIView *) callHeaderCacheWithSection:(NSInteger)section title:(NSString *)title
{
    UIView *cacheView = [[self headerCaches] objectForKey:@(section)];
    if (cacheView == nil)
    {
        // タイトル文字列がある場合
        if (title != nil && [title length] > 0)
        {
            cacheView = [[CCTableHeaderView alloc] initWithReuseIdentifierWithSection:section];
            [(CCTableHeaderView *)cacheView setTheme:[self theme]];
            [(CCTableHeaderView *)cacheView bindTitle:title];
            [(CCTableHeaderView *)cacheView bindTheme];
        }
        
        [self saveCache:[self headerCaches] section:section view:cacheView];
    }
    return cacheView;
}

// フッタキャッシュの取得
- (UIView *) callFooterCacheWithSection:(NSInteger)section title:(NSString *)title
{
    UIView *cacheView = [[self footerCaches] objectForKey:@(section)];
    if (cacheView == nil)
    {
        // タイトル文字列がある場合
        if (title != nil && [title length] > 0)
        {
            cacheView = [[CCTableFooterView alloc] initWithReuseIdentifierWithSection:section];
            [(CCTableFooterView *)cacheView setTheme:[self theme]];
            [(CCTableFooterView *)cacheView bindTitle:title];
            [(CCTableFooterView *)cacheView bindTheme];
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



#pragma mark - static method
//
// static method
//

// IndexPath配列からCellIDの生成
+ (NSDictionary *) cellIds:(NSArray<NSIndexPath *> *)indexPaths
{
    NSMutableDictionary<NSIndexPath *, NSString *> *cellIds = [@{} mutableCopy];
    for (NSIndexPath *indexPath in indexPaths)
    {
        [cellIds addEntriesFromDictionary:@{ indexPath: CFStringf(@"CellID%ld_%ld", (long)[indexPath section], (long)[indexPath row]) }];
    }
    return [cellIds copy];
}

@end
