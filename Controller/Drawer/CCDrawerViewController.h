//
//  CCDrawerViewController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCNavigationController.h"

#import "CCTableViewTrait.h"

@class CCDrawerMenuSection;

@interface CCDrawerViewController : CCNavigationController<UITableViewDataSource, UITableViewDelegate, CCTableViewDelegate, UIGestureRecognizerDelegate>

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
