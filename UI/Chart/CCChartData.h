//
//  CCChartData.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCChartData : NSObject

//
// property
//
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *value;



//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)title value:(NSNumber *)value;

// 初期化
- (instancetype) initWithTitle:(NSString *)title value:(NSNumber *)value color:(UIColor *)color;

@end
