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
@property (nonatomic, retain) UIColor *headBackgroundColor;
@property (nonatomic, retain) UIColor *bodyBackgroundColor;
@property (nonatomic, retain) UIColor *footBackgroundColor;

// text color
@property (nonatomic, retain) UIColor *headTextColor;
@property (nonatomic, retain) UIColor *footTextColor;

// separator color
@property (nonatomic, retain) UIColor *separatorColor;



//
// method
//

// background color
- (UIColor *) callHeadBackgroundColor;
- (UIColor *) callBodyBackgroundColor;
- (UIColor *) callFootBackgroundColor;

// text color
- (UIColor *) callHeadTextColor;
- (UIColor *) callFootTextColor;

// separator color
- (UIColor *) callSeparatorColor;

// init
- (instancetype) initWithBackgroudColor:(UIColor *)bodyColor head:(UIColor *)headColor foot:(UIColor *)footColor;

// bind background color
- (void) bindBackgroudColor:(UIColor *)bodyColor head:(UIColor *)headColor foot:(UIColor *)footColor;

// bind text color
- (void) bindTextColorHead:(UIColor *)headColor foot:(UIColor *)footColor;

@end
