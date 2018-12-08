//
//  CCPlatformDevice.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCPlatformDevice.h"

#include <sys/sysctl.h>

@implementation CCPlatformDevice

#pragma mark - method
//
// method
//

// Retinaディスプレイ
+ (BOOL) isRetinaDisplay
{
    if ([UIScreen instanceMethodForSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f)
    {
        return YES;
    }
    return NO;
}

// iPhone?
+ (BOOL) isIPhone
{
    return [self isPlatformModel:@"iPhone"];
}

// iPad?
+ (BOOL) isIPad
{
    return [self isPlatformModel:@"iPad"];
}

// iPod touch?
+ (BOOL) isIPod
{
    return [self isPlatformModel:@"iPod"];
}

// プラットフォームを取得
+ (NSString *) platform
{
    return [[UIDevice currentDevice] model];
}

// モデルを取得
+ (NSString *) model
{
    return [[UIDevice currentDevice] model];
}

// システム情報取得
+ (NSString *) systemInformationByName:(char *)typeSpecifier
{
    // バッファサイズ取得
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);

    // データ格納
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);

    // NSString型に変更
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];

    free(answer);
    return results;
}



#pragma mark - private
//
// private
//

// 指定モデルか？どうか？
+ (BOOL) isPlatformModel:(NSString *)modelName
{
    NSString *platform = [CCPlatformDevice platform];

    if ([platform hasPrefix:modelName] == YES)
    {
        return YES;
    }
    return NO;
}

@end
