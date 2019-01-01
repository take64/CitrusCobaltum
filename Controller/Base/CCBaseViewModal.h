//
//  CCBaseViewModal.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseViewController.h"

#import "CCControllerStruct.h"

@interface CCBaseViewModal : CCBaseViewController <UIViewControllerTransitioningDelegate>

//
// method
//

// 表示
- (void) showWithParent:(UIViewController *)parent;

// 表示
- (void) showWithParent:(UIViewController *)parent complete:(CitrusCobaltumModalBlock)completeBlock;

// 非表示
- (void) hide;

@end
