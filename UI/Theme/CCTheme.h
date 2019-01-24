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

@interface CCTheme : NSObject

//
// property
//

// application
@property (nonatomic, retain) UIImage *appIconImage;              // icon image
// navigation setting
@property (nonatomic, retain) UIColor *navigationBarTintColor;    // tint color
@property (nonatomic, retain) UIColor *navigationBarTextColor;    // text color
//// drawer setting
//@property (nonatomic, retain) UIColor *drawerBackColor;           // back color
//@property (nonatomic, retain) UIImage *drawerPanelIconImage;      // panel icon image
//@property (nonatomic, retain) UIColor *drawerPanelBackColor;      // panel back color
//@property (nonatomic, retain) UIColor *drawerCellHeadBackColor;   // cell head back color
//@property (nonatomic, retain) UIColor *drawerCellHeadTextColor;   // cell head text color
//@property (nonatomic, retain) UIColor *drawerCellBodyBackColor;   // cell body back color
//@property (nonatomic, retain) UIColor *drawerCellBodyTextColor;   // cell body text color
//// table setting
//@property (nonatomic, retain) UIColor *tableCellHeadBackColor;    // table cell head back color
//@property (nonatomic, retain) UIColor *tableCellHeadTextColor;    // table cell head text color
//@property (nonatomic, retain) UIColor *tableCellFootBackColor;    // table cell foot back color
//@property (nonatomic, retain) UIColor *tableCellFootTextColor;    // table cell foot text color
@property (nonatomic, retain) UIColor *themeColor0;               // theme color 0

@property (nonatomic, retain) CCThemeTableView *tableView;      // theme table view
@property (nonatomic, retain) CCThemeDrawerView *drawerView;    // theme drawer view


//
// method
//

// application
- (UIImage *) callAppIconImage;              // icon image

// navigation color
- (UIColor *) callNavigationBarTintColor;    // tint color
- (UIColor *) callNavigationBarTextColor;    // text color

//// drawer setting
//- (UIColor *) callDrawerBackColor;           // back color
//- (UIImage *) callDrawerPanelIconImage;      // panel icon
//- (UIColor *) callDrawerPanelBackColor;      // panel back color
//- (UIColor *) callDrawerCellHeadBackColor;   // cell head back color
//- (UIColor *) callDrawerCellHeadTextColor;   // cell head text color
//- (UIColor *) callDrawerCellBodyBackColor;   // cell body back color
//- (UIColor *) callDrawerCellBodyTextColor;   // cell body text color

//// table setting
//- (UIColor *) callTableCellHeadBackColor;    // table cell head back color
//- (UIColor *) callTableCellHeadTextColor;    // table cell head text color
//- (UIColor *) callTableCellFootBackColor;    // table cell head back color
//- (UIColor *) callTableCellFootTextColor;    // table cell head text color

// theme color
- (UIColor *) callThemeColor0;               // theme color 0

// theme table view
- (CCThemeTableView *) callTableView;

// theme drawer view
- (CCThemeDrawerView *) callDrawerView;

@end
