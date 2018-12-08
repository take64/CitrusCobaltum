//
//  CCTableViewDelegate.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCTableViewMode)
{
    CCTableViewModeList,
    CCTableViewModeEdit
};

@protocol CCTableViewDelegate <NSObject>

@optional

// セルヘッダタイトル取得
- (NSString *) callHeaderTitleWithSection:(NSInteger)section;

// セルフッタタイトル取得
- (NSString *) callFooterTitleWithSection:(NSInteger)section;

// セルヘッダビュー取得
- (UIView *) callHeaderViewWithSection:(NSInteger)section;

// セルフッタビュー取得
- (UIView *) callFooterViewWithSection:(NSInteger)section;

// テーブルモード
- (CCTableViewMode) callTableViewMode;

@end
