//
//  CCThemeNavigationBar.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCThemeNavigationBar.h"

#import "CFNVL.h"

@implementation CCThemeNavigationBar

#pragma mark - synthesize
//
// synthesize
//

@synthesize backgroundColor;
@synthesize titleColor;
@synthesize itemColor;



#pragma mark - method
//
// method
//

- (NSString *) callBackgroundColor  { return [CFNVL compare:[self backgroundColor]  replace:@"FFFFFF"]; }
- (NSString *) callTitleColor       { return [CFNVL compare:[self titleColor]       replace:@"FFFFFF"]; }
- (NSString *) callItemColor        { return [CFNVL compare:[self itemColor]        replace:@"FFFFFF"]; }

// bind color
- (void) bindBackgroudColor:(NSString *)backgroundColor title:(NSString *)titleColor item:(NSString *)itemColor
{
    [self setBackgroundColor:backgroundColor];
    [self setTitleColor:titleColor];
    [self setItemColor:itemColor];
}

@end
