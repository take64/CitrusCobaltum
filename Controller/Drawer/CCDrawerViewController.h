//
//  CCDrawerViewController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCNavigationController.h"

#import "CCDrawerMenuItem.h"
#import "CCDrawerMenuSection.h"

@class CCTableViewContainer;

@interface CCDrawerViewController : CCNavigationController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

//
// property
//
@property (nonatomic, retain) CCTableViewContainer *tableViewContainer;



//
// method
//

// 初期化
- (instancetype) initWithController:(UIViewController *)controllerValue menuSections:(NSArray<CCDrawerMenuSection *> *)menuSectionList;

// 色設定
- (void) bindTintColor:(UIColor *)tintColorValue headColor:(UIColor *)headColorValue cellColor:(UIColor *)cellColorValue;

// ヘッダイメージ
- (void) bindHeadImage:(UIImage *)imageValue;

@end
