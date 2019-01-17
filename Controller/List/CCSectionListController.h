//
//  CCSectionListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseListController.h"

@class CFSectionDatastore;
@class CCTableCell;

@interface CCSectionListController : CCBaseListController

//
// property
//
@property (nonatomic, retain) CFSectionDatastore *sectionDatastore;



//
// singleton
//

// section
- (CFSectionDatastore *) callSectionDatastore;

@end
