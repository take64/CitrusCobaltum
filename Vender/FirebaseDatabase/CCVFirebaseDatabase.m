//
//  CCVFirebaseDatabase.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCVFirebaseDatabase.h"

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
    [[[[reference child:path] child:[user uid]] child:keyValue] setValue:dicValue];
}

// データ読込
+ (void) loadWithPath:(NSString *)path result:(CitrusCobaltumFirebaseDatabaseBlock)completeBlock
{
    // データベース
    FIRDatabaseReference *reference = [[FIRDatabase database] reference];
    
    // ユーザー
    FIRUser *user = [[FIRAuth auth] currentUser];
    
    // 読込
    [[[reference child:path] child:[user uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completeBlock([snapshot value]);
    }];
}

@end
