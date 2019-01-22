//
//  CCVFirebaseDatabase.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCVFirebaseDatabase.h"

#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>



@implementation CCVFirebaseDatabase

#pragma mark - static method
//
// static method
//

// データ保存
+ (void) saveWithPath:(NSString *)path key:(NSString *)keyValue data:(NSDictionary *)dicValue
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    // 保存
    [[[[reference child:[user uid]] child:path] child:keyValue] setValue:dicValue];
}

// データ保存(一括)
+ (void) saveWithPath:(NSString *)path keyPath:(NSString *)keyPath data:(NSArray<NSDictionary *> *)dicValues
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    // 全て保存
    for (NSDictionary *dicValue in dicValues)
    {
        // 保存用キー
        NSString *keyValue = dicValue[keyPath];
        if ([keyValue isKindOfClass:[NSNumber class]] == YES)
        {
            keyValue = [(NSNumber *)keyValue stringValue];
        }
        
        // 保存
        [[[[reference child:[user uid]] child:path] child:keyValue] setValue:dicValue];
    }
}

// データ読込
+ (void) loadWithPath:(NSString *)path result:(CitrusCobaltumFirebaseDatabaseBlock)completeBlock
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    // 読込
    [[[reference child:[user uid]] child:path] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completeBlock([snapshot value]);
    }];
}

@end
