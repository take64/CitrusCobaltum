//
//  CitrusCobaltumApplication.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CitrusCobaltumApplication.h"

#import "CCTheme.h"

@interface CitrusCobaltumApplication()

#pragma mark - property
//
// property
//
@property CCTheme *theme;

@end


@implementation CitrusCobaltumApplication

//
// synthesize
//
//@synthesize theme;
//@synthesize coreDataManager;
//@synthesize coreDataContext;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self setTheme:[[CCTheme alloc] init]];
    }
    return self;
}



#pragma mark - static method
//
// static method
//

// テーマ取得
+ (CCTheme *)callTheme
{
    CCTheme *theme = [[CitrusCobaltumApplication sharedApplication] theme];
    if(theme == nil)
    {
        theme = [[CCTheme alloc] init];
    }
    return theme;
}


//// CoreData manager
//+ (CTCoreDataManager *)callCoreDataManager
//{
//    CTCoreDataManager *_coreDataManager = [[CitrusTouchApplication sharedApplication] coreDataManager];
//    if(_coreDataManager == nil)
//    {
//        CTLog(@"error : CitrusCobaltumApplication.callCoreDataManager");
//    }
//    return _coreDataManager;
//}
//
//// CoreData context
//+ (NSManagedObjectContext *)callCoreDataContext
//{
//    NSManagedObjectContext *_coreDataContext = [[CitrusTouchApplication sharedApplication] coreDataContext];
//    if(_coreDataContext == nil)
//    {
//        CTLog(@"error : CitrusCobaltumApplication.callCoreDataContext");
//    }
//    return _coreDataContext;
//}



#pragma mark - singleton
//
// singleton
//
+ (instancetype) sharedApplication
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CitrusCobaltumApplication alloc] init];
    });
    return singleton;
}
@end
