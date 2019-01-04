//
//  CCDrawerMenuPanel.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCView.h"

@interface CCDrawerMenuPanel : CCView

//
// property
//
@property (nonatomic, retain) CCView *headView;
@property (nonatomic, retain) UITableView *menuTableView;



//
// method
//

// 画像設定
- (void) bindImage:(UIImage *)imageValue;

// ヘッダ背景色設定
- (void) bindHeadBackgroundColor:(UIColor *)colorValue;

// テーブル背景色設定
- (void) bindTableViewBackgroundColor:(UIColor *)colorValue;

@end
