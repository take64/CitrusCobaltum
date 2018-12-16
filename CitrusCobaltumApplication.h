//
//  CitrusCobaltumApplication.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCTheme;

@interface CitrusCobaltumApplication : NSObject

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
