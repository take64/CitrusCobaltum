//
//  CCDrawerMenuItem.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDrawerMenuItem : NSObject
{
    NSString *title;
    UIViewController *controller;
}

//
// property
//
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIViewController *controller;



//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue;

// 初期化
+ (CCDrawerMenuItem *) menuWithTitle:(NSString *)titleValue controller:(UIViewController *)controllerValue;

@end
