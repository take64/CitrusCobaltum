//
//  CCDrawerMenuSection.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCDrawerMenuItem;

@interface CCDrawerMenuSection : NSObject
{
    // title
    NSString *title;
    // menu items
    NSArray<CCDrawerMenuItem *> *menuItems;
}



//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray<CCDrawerMenuItem *> *menuItems;



//
// method
//

// init
- (instancetype) initWithTitle:(NSString *)titleValue menuItems:(NSArray<CCDrawerMenuItem *> *)menuItemList;

// init
+ (CCDrawerMenuSection *) sectionWithTitle:(NSString *)titleValue menuItems:(NSArray<CCDrawerMenuItem *> *)menuItemList;

@end
