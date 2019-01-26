//
//  CCChartPie.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCChartData;

@interface CCChartPie : UIView

//
// property
//
@property (nonatomic, retain) NSArray<CCChartData *> *dataList;

//
// method
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame data:(NSArray<CCChartData *> *)dataValues;

// データ読み込み
- (void) loadData:(NSArray<CCChartData *> *)dataValues;

@end
