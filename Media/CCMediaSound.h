//
//  CCMediaSound.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/10/23.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMediaSound : NSObject

//
// static method
//

// ボタン押下音の許可
+ (void) enableButtonSound:(BOOL)enable;

// ボタン押下音
+ (void) playButtonSound;

@end
