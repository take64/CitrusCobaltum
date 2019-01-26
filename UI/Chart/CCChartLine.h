//
//  CCChartLine.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCChartList;

@interface CCChartLine : UIView

//
// property
//
@property (nonatomic, retain) NSNumberFormatter *ruledTitleFormat;
@property (nonatomic, retain) NSNumber *yMinInit;
@property (nonatomic, retain) NSNumber *yMaxInit;



//
// method
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame data:(NSArray<CCChartList *> *)dataValue;

// データ読み込み
- (void) loadData:(NSArray<CCChartList *> *)dataValue;

@end
