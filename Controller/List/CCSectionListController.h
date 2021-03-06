//
//  CCSectionListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseListController.h"

#import "CCSectionDatastore.h"

@interface CCSectionListController : CCBaseListController

//
// property
//
@property (nonatomic, retain) CCSectionDatastore *sectionDatastore;



//
// singleton
//

// section datastore
- (CCSectionDatastore *) callSectionDatastore;

@end
