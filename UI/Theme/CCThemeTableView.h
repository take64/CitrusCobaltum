//
//  CCThemeTableView.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/23.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCThemeTableView : NSObject

//
// property
//

// background color
@property (nonatomic, retain) NSString *backgroundColor;
@property (nonatomic, retain) NSString *headBackgroundColor;
@property (nonatomic, retain) NSString *cellBackgroundColor;
@property (nonatomic, retain) NSString *footBackgroundColor;

// text color
@property (nonatomic, retain) NSString *headTextColor;
@property (nonatomic, retain) NSString *cellTextColor;
@property (nonatomic, retain) NSString *footTextColor;

// separator color
@property (nonatomic, retain) NSString *separatorColor;



//
// method
//

// background color
- (NSString *) callBackgroundColor;
- (NSString *) callHeadBackgroundColor;
- (NSString *) callCellBackgroundColor;
- (NSString *) callFootBackgroundColor;

// NSStringlor
- (NSString *) callHeadTextColor;
- (NSString *) callCellTextColor;
- (NSString *) callFootTextColor;

// NSStringor color
- (NSString *) callSeparatorColor;

// bind background color
- (void) bindBackgroudColor:(NSString *)cellColor head:(NSString *)headColor foot:(NSString *)footColor;

// bind text color
- (void) bindTextColor:(NSString *)cellColor head:(NSString *)headColor foot:(NSString *)footColor;

@end
