//
//  CCTheme.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTheme.h"

#import "CCColor.h"
#import "CFNVL.h"

@implementation CCTheme

#pragma mark - synthesize
//
// synthesize
//

@synthesize appIconImage;

@synthesize navigationBarTintColor;
@synthesize navigationBarTextColor;

@synthesize drawerBackColor;
@synthesize drawerPanelIconImage;
@synthesize drawerPanelBackColor;
@synthesize drawerCellHeadBackColor;
@synthesize drawerCellHeadTextColor;
@synthesize drawerCellBodyBackColor;
@synthesize drawerCellBodyTextColor;

@synthesize tableCellHeadBackColor;
@synthesize tableCellHeadTextColor;
@synthesize tableCellFootBackColor;
@synthesize tableCellFootTextColor;

@synthesize themeColor0;



#pragma mark - method
//
// method
//

// application
- (UIImage *) callAppIconImage           { return [CFNVL compare:[self appIconImage]             replace:[[UIImage alloc] init]]; }

// navigation setting
- (UIColor *) callNavigationBarTintColor { return [CFNVL compare:[self navigationBarTintColor]   replace:[UIColor whiteColor]]; }
- (UIColor *) callNavigationBarTextColor { return [CFNVL compare:[self navigationBarTextColor]   replace:[UIColor whiteColor]]; }

// drawer setting
- (UIColor *) callDrawerBackColor        { return [CFNVL compare:[self drawerBackColor]          replace:[UIColor whiteColor]]; }
- (UIImage *) callDrawerPanelIconImage   { return [CFNVL compare:[self drawerPanelIconImage]     replace:[[UIImage alloc] init]]; }
- (UIColor *) callDrawerPanelBackColor   { return [CFNVL compare:[self drawerPanelBackColor]     replace:[UIColor whiteColor]]; }
- (UIColor *) callDrawerCellHeadBackColor{ return [CFNVL compare:[self drawerCellHeadBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callDrawerCellHeadTextColor{ return [CFNVL compare:[self drawerCellHeadTextColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callDrawerCellBodyBackColor{ return [CFNVL compare:[self drawerCellBodyBackColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callDrawerCellBodyTextColor{ return [CFNVL compare:[self drawerCellBodyTextColor]  replace:[UIColor whiteColor]]; }

// table setting
- (UIColor *) callTableCellHeadBackColor { return [CFNVL compare:[self tableCellHeadBackColor]   replace:[UIColor whiteColor]]; }
- (UIColor *) callTableCellHeadTextColor { return [CFNVL compare:[self tableCellHeadTextColor]   replace:[UIColor whiteColor]]; }
- (UIColor *) callTableCellFootBackColor { return [CFNVL compare:[self tableCellFootBackColor]   replace:[UIColor whiteColor]]; }
- (UIColor *) callTableCellFootTextColor { return [CFNVL compare:[self tableCellFootTextColor]   replace:[UIColor whiteColor]]; }

// theme color
- (UIColor *) callThemeColor0            { return [CFNVL compare:[self themeColor0]              replace:[UIColor whiteColor]]; }

@end
