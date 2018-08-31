//
//  CitrusCobaltumApplication.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCTheme;

@interface CitrusCobaltumApplication : NSObject
{
//    // theme
//    CTTheme *theme;
//
//    // coredata
//    CTCoreDataManager *coreDataManager;
//    NSManagedObjectContext * coreDataContext;
}

//
// property
//
//@property (nonatomic, retain) CTTheme *theme;
//@property (nonatomic, retain) CTCoreDataManager *coreDataManager;
//@property (nonatomic, retain) NSManagedObjectContext * coreDataContext;


//
// static method
//

// テーマ取得
+ (CCTheme *) callTheme;

//// CoreData manager
//+ (CTCoreDataManager *) callCoreDataManager;
//
//// CoreData context
//+ (NSManagedObjectContext *) callCoreDataContext;

// singleton
+ (instancetype) sharedApplication;

@end
