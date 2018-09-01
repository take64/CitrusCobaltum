//
//  CCTableViewTrait.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCTableViewTrait.h"

#import "CCTableViewDelegate.h"
#import "CCTableHeaderView.h"
#import "CCTableFooterView.h"
#import "CCUIStruct.h"

@implementation CCTableViewTrait

#pragma mark - static method
//
// static method
//

// ヘッダビュー取得
+ (UIView *) callTableHeaderViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    // head title
    NSString *titleString = @"";
    if([tableDelegate respondsToSelector:@selector(callHeaderTitleWithSection:)] == YES)
    {
        titleString = [tableDelegate callHeaderTitleWithSection:section];
    }
    
    // head view
    UIView *titleView = nil;
    if([tableDelegate respondsToSelector:@selector(callHeaderViewWithSection:)] == YES)
    {
        titleView = [tableDelegate callHeaderViewWithSection:section];
    }
    
    // title id
    NSString *queueID = [CCTableHeaderView reuseIdentifierWithSection:section];
    
    // dequeue
    CCTableHeaderView *headerFooterView = (CCTableHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:queueID];
    
    // data exists
    if([titleString length] > 0 || titleView != nil)
    {
        // generate
        if(headerFooterView == nil)
        {
            headerFooterView = [[CCTableHeaderView alloc] initWithReuseIdentifier:queueID];
            [headerFooterView setMargin:[self callTableSectionMarginSizeWithController:(id)tableDelegate tableView:tableView]];
        }
    }
    
    // bind
    if(headerFooterView != nil)
    {
        // title string exist
        if([titleString length] > 0)
        {
            [headerFooterView bindTitle:titleString];
        }
        
        // title view exist
        if(titleView != nil)
        {
            [headerFooterView bindView:titleView];
        }
    }
    
    return headerFooterView;
}

// フッタビュー取得
+ (UIView *) callTableFooterViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section
{
    // head title
    NSString *titleString = @"";
    if([tableDelegate respondsToSelector:@selector(callFooterTitleWithSection:)] == YES)
    {
        titleString = [tableDelegate callFooterTitleWithSection:section];
    }
    
    // head view
    UIView *titleView = nil;
    if([tableDelegate respondsToSelector:@selector(callFooterViewWithSection:)] == YES)
    {
        titleView = [tableDelegate callFooterViewWithSection:section];
    }
    
    // queue id
    NSString *queueID = [CCTableFooterView reuseIdentifierWithSection:section];
    
    // dequeue
    CCTableFooterView *headerFooterView = (CCTableFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:queueID];
    
    // data exists
    if([titleString length] > 0 || titleView != nil)
    {
        // generate
        if(headerFooterView == nil)
        {
            headerFooterView = [[CCTableFooterView alloc] initWithReuseIdentifier:queueID];
            [headerFooterView setMargin:[self callTableSectionMarginSizeWithController:(id)tableDelegate tableView:tableView]];
        }
    }
    
    // bind
    if(headerFooterView != nil)
    {
        // title string exist
        if([titleString length] > 0)
        {
            [headerFooterView bindTitle:titleString];
        }
        
        // title view exist
        if(titleView != nil)
        {
            [headerFooterView bindView:titleView];
        }
    }
    
    return headerFooterView;
}

// ヘッダ/フッタ セクションマージン取得
+ (CGFloat) callTableSectionMarginSizeWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView
{
    CCTableViewMode mode = CCTableViewModeList;
    if([tableDelegate respondsToSelector:@selector(callTableViewMode)] == YES)
    {
        mode = [tableDelegate callTableViewMode];
    }
    
    CGFloat result = .0f;
    if(mode == CCTableViewModeEdit)
    {
        result = CC8(1);
        if([tableView style] == UITableViewStyleGrouped)
        {
            result += CC8(1);
        }
    }
    
    return result;
}

@end
