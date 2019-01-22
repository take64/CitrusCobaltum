//
//  CCVFirebaseDatabase.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CitrusCobaltumFirebaseDatabaseBlock)(NSDictionary *result);

@interface CCVFirebaseDatabase : NSObject

//
// static method
//

// データ保存
+ (void) saveWithPath:(NSString *)path key:(NSString *)keyValue data:(NSDictionary *)dicValue;

// データ保存(一括)
+ (void) saveWithPath:(NSString *)path keyPath:(NSString *)keyPath data:(NSArray<NSDictionary *> *)dicValues;

// データ読込
+ (void) loadWithPath:(NSString *)path result:(CitrusCobaltumFirebaseDatabaseBlock)completeBlock;

@end
