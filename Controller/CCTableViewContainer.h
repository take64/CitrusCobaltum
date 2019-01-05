//
//  CCTableViewContainer.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/05.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCTableViewContainer : NSObject

//
// property
//
@property (nonatomic, retain) id<UITableViewDelegate, UITableViewDataSource> tableViewDelegate;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableDictionary *headerCaches;
@property (nonatomic, retain) NSMutableDictionary *footerCaches;



//
// method
//

// 初期化
- (instancetype) initWithTableView:(UITableView *)view delegate:(id<UITableViewDelegate, UITableViewDataSource>)delegate;

// ヘッダキャッシュの取得
- (UIView *) callHeaderCacheWithSection:(NSInteger)section;

// フッタキャッシュの取得
- (UIView *) callFooterCacheWithSection:(NSInteger)section;

// ヘッダ/フッタキャッシュの追加
- (void) saveCache:(NSMutableDictionary *)caches section:(NSInteger)section view:(UIView *)viewValue;

@end
