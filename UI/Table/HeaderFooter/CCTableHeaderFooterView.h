//
//  CCTableHeaderFooterView.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCLabel.h"
#import "CCThemeTableView.h"

@interface CCTableHeaderFooterView : UITableViewHeaderFooterView

//
// property
//
@property (nonatomic, retain) CCLabel *label;
@property (nonatomic, retain) UIColor *labelColor;
@property (nonatomic, retain) UIColor *labelBackgroundColor;
@property (nonatomic, retain) UIView *control;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, retain) CCThemeTableView *theme;



//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifierWithSection:(NSInteger)section;

// タイトル or ビュー設定
- (void) bindTitle:(NSString *)titleString orView:(UIView *)viewValue;

// タイトル設定
- (void) bindTitle:(NSString *)titleValue;

// ビュー設定
- (void) bindView:(UIView *)viewValue;

// テーマ設定
- (void) bindTheme;



//
// static method
//

// リサイクルID取得
+ (NSString *) reuseIdentifierWithSection:(NSInteger)section;

@end
