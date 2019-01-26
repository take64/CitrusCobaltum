//
//  CCAlert.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAlert : UIAlertController

//
// static method
//

// OKアラート取得
+ (CCAlert *) callOkAlertWithTitle:(NSString *)title messages:(id)messages handler:(void (^)(UIAlertAction *action))handler;

// OKアラート表示
+ (void) okAlertWithTitle:(NSString *)title messages:(id)messages parent:(UIViewController *)parentController handler:(void (^)(UIAlertAction *action))handler;

// アクションシート取得
+ (CCAlert *) callActionSheetWithTitle:(NSString *)title messages:(id)messages actions:(NSArray<UIAlertAction *> *)actions;

@end
