//
//  CCSectionItem.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/29.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCSectionItem : NSObject

//
// property
//

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSString *color;



//
// static method
//

// 初期化して取得
+ (instancetype) itemWithKey:(NSString *)key label:(NSString *)label value:(NSString *)value;

@end
