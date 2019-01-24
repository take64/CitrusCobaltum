//
//  CCThemeTableView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/23.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCThemeTableView.h"

#import "CFNVL.h"

@implementation CCThemeTableView

#pragma mark - synthesize
//
// synthesize
//

@synthesize backgroundColor;
@synthesize headBackgroundColor;
@synthesize cellBackgroundColor;
@synthesize footBackgroundColor;
@synthesize headTextColor;
@synthesize cellTextColor;
@synthesize footTextColor;
@synthesize separatorColor;



#pragma mark - method
//
// method
//

// background color
- (NSString *) callBackgroundColor      { return [CFNVL compare:[self backgroundColor]      replace:@"FFFFFF"]; }
- (NSString *) callHeadBackgroundColor  { return [CFNVL compare:[self headBackgroundColor]  replace:@"FFFFFF"]; }
- (NSString *) callCellBackgroundColor  { return [CFNVL compare:[self cellBackgroundColor]  replace:@"FFFFFF"]; }
- (NSString *) callFootBackgroundColor  { return [CFNVL compare:[self footBackgroundColor]  replace:@"FFFFFF"]; }

// text color
- (NSString *) callHeadTextColor        { return [CFNVL compare:[self headTextColor]        replace:@"333333"]; }
- (NSString *) callCellTextColor        { return [CFNVL compare:[self cellTextColor]        replace:@"333333"]; }
- (NSString *) callFootTextColor        { return [CFNVL compare:[self footTextColor]        replace:@"333333"]; }

// separator color
- (UIColor *) callSeparatorColor        { return [CFNVL compare:[self separatorColor]       replace:@"999999"]; }

// bind background color
- (void) bindBackgroudColor:(NSString *)cellColor head:(NSString *)headColor foot:(NSString *)footColor
{
    [self setCellBackgroundColor:cellColor];
    [self setHeadBackgroundColor:headColor];
    [self setFootBackgroundColor:footColor];
}

// bind text color
- (void) bindTextColor:(NSString *)cellColor head:(NSString *)headColor foot:(NSString *)footColor
{
    [self setHeadTextColor:headColor];
    [self setCellTextColor:cellColor];
    [self setFootTextColor:footColor];
}

@end
