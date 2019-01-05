//
//  CCBaseTableController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCTableViewContainer;

@interface CCBaseTableController : UITableViewController

//
// property
//
@property (nonatomic, retain) CCTableViewContainer *tableViewContainer;



//
// method
//

// タイトル取得
- (NSString *) callTitle;

@end
