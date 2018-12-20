//
//  CCTableGroupedHead.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/18.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCControl.h"

@interface CCTableGroupedHead : CCControl

//
// property
//
@property (nonatomic, retain) CCControl *cellView;



//
// method
//

// テキストの設定
- (void) setText:(NSString *)textString;

// 色の設定
- (void) setTintColor:(NSString *)tintColorString;

@end
