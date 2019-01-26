//
//  CCThemeNavigationBar.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCThemeNavigationBar : NSObject

//
// property
//

// background color
@property (nonatomic, retain) NSString *backgroundColor;

// text color
@property (nonatomic, retain) NSString *titleColor;
@property (nonatomic, retain) NSString *itemColor;



//
// method
//

// color
- (NSString *) callBackgroundColor;
- (NSString *) callTitleColor;
- (NSString *) callItemColor;

// bind color
- (void) bindBackgroudColor:(NSString *)backgroundColor title:(NSString *)titleColor item:(NSString *)itemColor;

@end
