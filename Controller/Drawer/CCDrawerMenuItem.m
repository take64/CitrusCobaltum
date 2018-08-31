//
//  CCDrawerMenuItem.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCDrawerMenuItem.h"

@interface CCDrawerMenuItem()

@end



@implementation CCDrawerMenuItem

#pragma mark - synthesize
//
// synthesize
//
@synthesize title;
@synthesize controller;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue
{
    self = [super init];
    if (self)
    {
        [self setTitle:titleValue];
        [self setController:controllerValue];
    }
    return self;
}

// 初期化
+ (CCDrawerMenuItem *) menuWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue
{
    return [[CCDrawerMenuItem alloc] initWithTitle:titleValue controller:controllerValue];
}

@end
