//
//  CCTheme.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTheme.h"

#import "CFNVL.h"

@implementation CCTheme

#pragma mark - synthesize
//
// synthesize
//

@synthesize appIconImage;

@synthesize tableView;
@synthesize drawerView;
@synthesize navigationBar;

@synthesize themeColor0;



#pragma mark - method
//
// method
//

// application
- (UIImage *) callAppIconImage           { return [CFNVL compare:[self appIconImage]             replace:[[UIImage alloc] init]]; }

// theme color
- (UIColor *) callThemeColor0            { return [CFNVL compare:[self themeColor0]              replace:[UIColor whiteColor]]; }

// theme table view
- (CCThemeTableView *) callTableView
{
    if ([self tableView] == nil)
    {
        [self setTableView:[[CCThemeTableView alloc] init]];
    }
    return [self tableView];
}

// theme drawer view
- (CCThemeDrawerView *) callDrawerView
{
    if ([self drawerView] == nil)
    {
        [self setDrawerView:[[CCThemeDrawerView alloc] init]];
    }
    return [self drawerView];
}

// theme navigation bar
- (CCThemeNavigationBar *) callNavigationBar
{
    if ([self navigationBar] == nil)
    {
        [self setNavigationBar:[[CCThemeNavigationBar alloc] init]];
    }
    return [self navigationBar];
}

@end
