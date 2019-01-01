//
//  CCTableViewTrait.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableViewTrait.h"

#import "CitrusCobaltumTypedef.h"
#import "CCTableViewDelegate.h"
#import "CCTableHeaderView.h"
#import "CCTableFooterView.h"
#import "CCUIStruct.h"

static NSString * const kCCTableHeaderViewName = @"CCTableHeaderView";
static NSString * const kCCTableFooterViewName = @"CCTableFooterView";

@implementation CCTableViewTrait

#pragma mark - static method
//
// static method
//

// ヘッダビュー取得
+ (UIView *) callTableHeaderViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    return [self generateHeaderFooterType:[CCTableHeaderView class] tableDelegate:tableDelegate tableView:tableView section:section];
}

// フッタビュー取得
+ (UIView *) callTableFooterViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    return [self generateHeaderFooterType:[CCTableFooterView class] tableDelegate:tableDelegate tableView:tableView section:section];
}

// ヘッダ/フッタ セクションマージン取得
+ (CGFloat) callTableSectionMarginSizeWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView
{
    CCTableViewMode mode = CCTableViewModeList;
    if ([tableDelegate respondsToSelector:@selector(callTableViewMode)] == YES)
    {
        mode = [tableDelegate callTableViewMode];
    }
    
    CGFloat result = .0f;
    if (mode == CCTableViewModeEdit)
    {
        result = CC8(1);
        if ([tableView style] == UITableViewStyleGrouped)
        {
            result += CC8(1);
        }
    }
    
    return result;
}



#pragma mark - static private
//
// static private
//

// ヘッダフッタビューの生成
+ (CCTableHeaderFooterView *) generateHeaderFooterType:(Class)viewClass tableDelegate:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    // タイトル/ビュー
    NSString *titleString = @"";
    UIView *titleView = nil;
    
    // ヘッダ
    if ([viewClass isKindOfClass:[CCTableHeaderView class]] == YES)
    {
        if ([tableDelegate respondsToSelector:@selector(callHeaderTitleWithSection:)] == YES)
        {
            titleString = [tableDelegate callHeaderTitleWithSection:section];
        }
        if ([tableDelegate respondsToSelector:@selector(callHeaderViewWithSection:)] == YES)
        {
            titleView = [tableDelegate callHeaderViewWithSection:section];
        }
    }
    // フッタ
    else if ([viewClass isKindOfClass:[CCTableFooterView class]] == YES)
    {
        if ([tableDelegate respondsToSelector:@selector(callFooterTitleWithSection:)] == YES)
        {
            titleString = [tableDelegate callFooterTitleWithSection:section];
        }
        if ([tableDelegate respondsToSelector:@selector(callFooterViewWithSection:)] == YES)
        {
            titleView = [tableDelegate callFooterViewWithSection:section];
        }
        
    }
    
    // キューID
    NSString *queueID = [viewClass reuseIdentifierWithSection:section];
    
    // デキュー
    CCTableHeaderFooterView *headerFooterView = (CCTableHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:queueID];
    
    // データある場合
    if ([titleString length] > 0 || titleView != nil)
    {
        // 生成
        if (headerFooterView == nil)
        {
            headerFooterView = [[viewClass alloc] initWithReuseIdentifier:queueID];
            [headerFooterView setMargin:[self callTableSectionMarginSizeWithController:(id)tableDelegate tableView:tableView]];
        }
        
        // タイトル文字列がある場合
        if ([titleString length] > 0)
        {
            [headerFooterView bindTitle:titleString];
        }
        
        // タイトルビューがある場合
        if (titleView != nil)
        {
            [headerFooterView bindView:titleView];
        }
    }
    return headerFooterView;
}

@end
