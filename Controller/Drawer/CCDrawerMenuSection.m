//
//  CCDrawerMenuSection.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCDrawerMenuSection.h"

@implementation CCDrawerMenuSection

#pragma mark - synthesize
//
// synthesize
//
@synthesize title;
@synthesize menuItems;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue menuItems:(NSArray<CCDrawerMenuItem *> *)menuItemList
{
    self = [super init];
    if (self)
    {
        [self setTitle:titleValue];
        [self setMenuItems:menuItemList];
    }
    return self;
}

// 初期化
+ (CCDrawerMenuSection *) sectionWithTitle:(NSString *)titleValue menuItems:(NSArray<CCDrawerMenuItem *> *)menuItemList
{
    return [[CCDrawerMenuSection alloc] initWithTitle:titleValue menuItems:menuItemList];
}

@end
