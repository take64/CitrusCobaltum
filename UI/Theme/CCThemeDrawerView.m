//
//  CCThemeDrawerView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/24.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCThemeDrawerView.h"

#import "CFNVL.h"

@implementation CCThemeDrawerView

#pragma mark - synthesize
//
// synthesize
//

@synthesize panelIconImage;
@synthesize panelBackgroundColor;
@synthesize tableView;



#pragma mark - method
//
// method
//

// panel
- (UIImage *) callPanelIconImage        { return [CFNVL compare:[self panelIconImage]       replace:[[UIImage alloc] init]]; }
- (NSString *) callPanelBackgroundColor { return [CFNVL compare:[self panelBackgroundColor] replace:@"FFFFFF"]; }

// theme table view
- (CCThemeTableView *) callTableView
{
    if ([self tableView] == nil)
    {
        [self setTableView:[[CCThemeTableView alloc] init]];
    }
    return [self tableView];
}

// bind panel
- (void) bindPanelImage:(UIImage *)panelImage backgroundColor:(NSString *)backgroundColor
{
    [self setPanelIconImage:panelImage];
    [self setPanelBackgroundColor:backgroundColor];
}

@end
