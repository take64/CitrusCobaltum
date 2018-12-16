//
//  CCBaseEditModal.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/17.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseEditController.h"

#import "CCControllerStruct.h"

@interface CCBaseEditModal : CCBaseEditController <UIViewControllerTransitioningDelegate>

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
