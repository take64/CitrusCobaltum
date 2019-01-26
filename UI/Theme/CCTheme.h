//
//  CCTheme.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCThemeTableView.h"
#import "CCThemeDrawerView.h"
#import "CCThemeNavigationBar.h"

@interface CCTheme : NSObject

//
// property
//

// application
@property (nonatomic, retain) UIImage *appIconImage;              // icon image
@property (nonatomic, retain) UIColor *themeColor0;               // theme color 0

@property (nonatomic, retain) CCThemeTableView *tableView;          // theme table view
@property (nonatomic, retain) CCThemeDrawerView *drawerView;        // theme drawer view
@property (nonatomic, retain) CCThemeNavigationBar *navigationBar;  // theme navigation bar


//
// method
//

// application
- (UIImage *) callAppIconImage;              // icon image


// theme color
- (UIColor *) callThemeColor0;               // theme color 0

// theme table view
- (CCThemeTableView *) callTableView;

// theme drawer view
- (CCThemeDrawerView *) callDrawerView;

// theme navigation bar
- (CCThemeNavigationBar *) callNavigationBar;

@end
