//
//  CCKeySelectModal.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/02.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseSelectModal.h"

@interface CCKeySelectModal : CCBaseSelectModal <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

//
// property
//
@property (nonatomic, retain) NSMutableArray<NSMutableArray *> *keys;
@property (nonatomic, retain) NSMutableDictionary *values;
@property (nonatomic, retain) id selectedKey;



//
// method
//

// データ読み込み
- (void) loadSelectData:(NSMutableArray<NSMutableArray *> *)_keyList keyValue:(NSMutableDictionary *)_keyDict;

@end
