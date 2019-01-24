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
- (UIColor *) callBackgroundColor       { return [CFNVL compare:[self backgroundColor]      replace:[UIColor whiteColor]]; }
- (UIColor *) callHeadBackgroundColor   { return [CFNVL compare:[self headBackgroundColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callCellBackgroundColor   { return [CFNVL compare:[self cellBackgroundColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callFootBackgroundColor   { return [CFNVL compare:[self footBackgroundColor]  replace:[UIColor whiteColor]]; }

// text color
- (UIColor *) callHeadTextColor         { return [CFNVL compare:[self headTextColor]        replace:[UIColor darkTextColor]]; }
- (UIColor *) callCellTextColor         { return [CFNVL compare:[self cellTextColor]        replace:[UIColor darkTextColor]]; }
- (UIColor *) callFootTextColor         { return [CFNVL compare:[self footTextColor]        replace:[UIColor darkTextColor]]; }

// separator color
- (UIColor *) callSeparatorColor        { return [CFNVL compare:[self separatorColor]       replace:[UIColor lightGrayColor]]; }

// init
- (instancetype) initWithBackgroudColor:(UIColor *)bodyColor head:(UIColor *)headColor foot:(UIColor *)footColor
{
    self = [super init];
    if (self)
    {
        [self bindBackgroudColor:bodyColor head:headColor foot:footColor];
    }
    return self;
}

// bind background color
- (void) bindBackgroudColor:(UIColor *)cellColor head:(UIColor *)headColor foot:(UIColor *)footColor
{
    [self setCellBackgroundColor:cellColor];
    [self setHeadBackgroundColor:headColor];
    [self setFootBackgroundColor:footColor];
}

// bind text color
- (void) bindTextColor:(UIColor *)cellColor head:(UIColor *)headColor foot:(UIColor *)footColor
{
    [self setHeadTextColor:headColor];
    [self setCellTextColor:cellColor];
    [self setFootTextColor:footColor];
}

@end
