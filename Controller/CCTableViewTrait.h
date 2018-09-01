//
//  CCTableViewTrait.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCTableViewTrait : NSObject

//
// static method
//

// ヘッダビュー取得
+ (UIView *) callTableHeaderViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// フッタビュー取得
+ (UIView *) callTableFooterViewWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView section:(NSInteger)section;

// ヘッダ/フッタ セクションマージン取得
+ (CGFloat) callTableSectionMarginSizeWithController:(id<CTTableViewDelegate>)tableDelegate tableView:(UITableView *)tableView;

@end
