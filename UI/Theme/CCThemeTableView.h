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
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *headBackgroundColor;
@property (nonatomic, retain) UIColor *cellBackgroundColor;
@property (nonatomic, retain) UIColor *footBackgroundColor;

// text color
@property (nonatomic, retain) UIColor *headTextColor;
@property (nonatomic, retain) UIColor *cellTextColor;
@property (nonatomic, retain) UIColor *footTextColor;

// separator color
@property (nonatomic, retain) UIColor *separatorColor;



//
// method
//



// background color
- (UIColor *) callBackgroundColor;
- (UIColor *) callHeadBackgroundColor;
- (UIColor *) callCellBackgroundColor;
- (UIColor *) callFootBackgroundColor;

// text color
- (UIColor *) callHeadTextColor;
- (UIColor *) callCellTextColor;
- (UIColor *) callFootTextColor;

// separator color
- (UIColor *) callSeparatorColor;

// init
- (instancetype) initWithBackgroudColor:(UIColor *)bodyColor head:(UIColor *)headColor foot:(UIColor *)footColor;

// bind background color
- (void) bindBackgroudColor:(UIColor *)cellColor head:(UIColor *)headColor foot:(UIColor *)footColor;

// bind text color
- (void) bindTextColor:(UIColor *)cellColor head:(UIColor *)headColor foot:(UIColor *)footColor;

@end
