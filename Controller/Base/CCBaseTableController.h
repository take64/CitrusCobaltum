//
//  CCBaseTableController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCControllerStruct.h"

@class CCTableViewContainer;

@interface CCBaseTableController : UITableViewController <UIViewControllerTransitioningDelegate>

//
// property
//
@property (nonatomic, retain) CCTableViewContainer *tableViewContainer;
@property (nonatomic, copy)   CitrusCobaltumModalBlock modalComplete;



//
// method
//

// タイトル取得
- (NSString *) callTitle;

// 表示
- (void) showWithParent:(UIViewController *)parent;

// 表示
- (void) showWithParent:(UIViewController *)parent complete:(CitrusCobaltumModalBlock)completeBlock;

// 非表示
- (void) hide;

@end
