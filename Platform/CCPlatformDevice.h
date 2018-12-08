//
//  CCPlatformDevice.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPlatformDevice : NSObject

// Retinaディスプレイ
+ (BOOL) isRetinaDisplay;

// iPhone?
+ (BOOL) isIPhone;

// iPad?
+ (BOOL) isIPad;

// iPod touch?
+ (BOOL) isIPod;

// プラットフォームを取得
+ (NSString *) platform;

// モデルを取得
+ (NSString *) model;

// システム情報取得
+ (NSString *) systemInformationByName:(char *)typeSpecifier;

@end
