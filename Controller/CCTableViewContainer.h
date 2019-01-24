//
//  CCTableViewContainer.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/05.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCThemeTableView;

@interface CCTableViewContainer : NSObject

//
// property
//
@property (nonatomic, retain) id<UITableViewDelegate, UITableViewDataSource> tableViewDelegate;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *headerCaches;
@property (nonatomic, retain) NSMutableDictionary *footerCaches;
@property (nonatomic, retain) CCThemeTableView *theme;



//
// method
//

// 初期化
- (instancetype) initWithTableView:(UITableView *)view delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;

// ヘッダキャッシュの取得
- (UIView *) callHeaderCacheWithSection:(NSInteger)section title:(NSString *)title;

// フッタキャッシュの取得
- (UIView *) callFooterCacheWithSection:(NSInteger)section title:(NSString *)title;

// ヘッダ/フッタキャッシュの追加
- (void) saveCache:(NSMutableDictionary *)caches section:(NSInteger)section view:(UIView *)viewValue;



//
// static method
//

// IndexPath配列からCellIDの生成
+ (NSDictionary *) cellIds:(NSArray<NSIndexPath *> *)indexPaths;

@end
