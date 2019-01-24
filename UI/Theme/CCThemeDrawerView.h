//
//  CCThemeDrawerView.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/23.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CCThemeTableView.h"

@interface CCThemeDrawerView : NSObject

//
// property
//

// panel
@property (nonatomic, retain) UIImage *panelIconImage;
@property (nonatomic, retain) NSString *panelBackgroundColor;

// table view
@property (nonatomic, retain) CCThemeTableView *tableView;



//
// method
//

// panel
- (UIImage *) callPanelIconImage;
- (NSString *) callPanelBackgroundColor;

// theme table view
- (CCThemeTableView *) callTableView;

// bind panel
- (void) bindPanelImage:(UIImage *)panelImage backgroundColor:(NSString *)backgroundColor;

@end
