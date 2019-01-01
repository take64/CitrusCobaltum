//
//  CCWebViewModal.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseViewModal.h"

#import <WebKit/WebKit.h>

@interface CCWebViewModal : CCBaseViewModal <WKNavigationDelegate>

//
// method
//

// URL読み込み
- (void) loadURL:(NSString *)urlString;

@end
