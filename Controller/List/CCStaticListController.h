//
//  CCStaticListController.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/12.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseListController.h"

@interface CCStaticListController : CCBaseListController

//
// property
//
@property (nonatomic, retain) NSArray *rowOfSection;
@property (nonatomic, retain) NSArray *headTitles;

@end
