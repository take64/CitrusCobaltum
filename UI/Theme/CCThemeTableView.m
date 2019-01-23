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

@synthesize headBackgroundColor;
@synthesize bodyBackgroundColor;
@synthesize footBackgroundColor;
@synthesize headTextColor;
@synthesize footTextColor;
@synthesize separatorColor;



#pragma mark - method
//
// method
//

// background color
- (UIColor *) callHeadBackgroundColor   { return [CFNVL compare:[self headBackgroundColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callBodyBackgroundColor   { return [CFNVL compare:[self bodyBackgroundColor]  replace:[UIColor whiteColor]]; }
- (UIColor *) callFootBackgroundColor   { return [CFNVL compare:[self footBackgroundColor]  replace:[UIColor whiteColor]]; }

// text color
- (UIColor *) callHeadTextColor         { return [CFNVL compare:[self headBackgroundColor]  replace:[UIColor darkTextColor]]; }
- (UIColor *) callFootTextColor         { return [CFNVL compare:[self headBackgroundColor]  replace:[UIColor darkTextColor]]; }

// separator color
- (UIColor *) callSeparatorColor        { return [CFNVL compare:[self headBackgroundColor]  replace:[UIColor lightGrayColor]]; }

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
- (void) bindBackgroudColor:(UIColor *)bodyColor head:(UIColor *)headColor foot:(UIColor *)footColor
{
    [self setBodyBackgroundColor:bodyColor];
    [self setHeadBackgroundColor:headColor];
    [self setFootBackgroundColor:footColor];
}

// bind text color
- (void) bindTextColorHead:(UIColor *)headColor foot:(UIColor *)footColor
{
    [self setHeadTextColor:headColor];
    [self setFootTextColor:footColor];
}
@end
