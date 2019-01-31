//
//  CCSectionItem.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/29.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCSectionItem.h"

@implementation CCSectionItem

#pragma mark - static method
//
// static method
//

// 初期化して取得
+ (instancetype) itemWithKey:(NSString *)key label:(NSString *)label value:(NSString *)value
{
    CCSectionItem *item = [[CCSectionItem alloc] init];
    [item setKey:key];
    [item setLabel:label];
    [item setValue:value];
    return item;
}

@end
