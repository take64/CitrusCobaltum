//
//  CCFetchListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseListController.h"

@class CCTableCell;

@interface CCFetchListController : CCBaseListController <NSFetchedResultsControllerDelegate>

//
// property
//
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;



//
// singleton
//

// fetch
- (NSFetchedResultsController *) callFetchedResultsController;

@end
