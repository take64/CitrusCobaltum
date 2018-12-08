//
//  CCTableViewTrait.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CCTableViewDelegate.h"

@interface CCTableViewTrait : NSObject

//
// static method
//

// ヘッダビュー取得
+ (UIView *) callTableHeaderViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// フッタビュー取得
+ (UIView *) callTableFooterViewWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// ヘッダ/フッタ セクションマージン取得
+ (CGFloat) callTableSectionMarginSizeWithController:(id<CCTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView;

@end
