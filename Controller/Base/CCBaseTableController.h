//
//  CCBaseTableController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCTableViewDelegate.h"

@interface CCBaseTableController : UITableViewController <CCTableViewDelegate>

//
// property
//
@property (nonatomic, retain) NSMutableDictionary *headerCaches;
@property (nonatomic, retain) NSMutableDictionary *footerCaches;



//
// method
//

// タイトル取得
- (NSString *) callTitle;

@end
