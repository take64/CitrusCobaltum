//
//  CCChartList.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCChartData;

@interface CCChartList : NSObject

//
// property
//
@property (nonatomic, retain) NSNumber *minValue;
@property (nonatomic, retain) NSNumber *maxValue;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSArray<CCChartData *> *dataList;
@property (nonatomic, retain) NSString *title;


//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)title values:(NSArray<CCChartData *> *)dataValues;

@end
