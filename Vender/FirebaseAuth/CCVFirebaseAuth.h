//
//  CCVFirebaseAuth.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/31.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusCobaltumVenderFirebaseAuth.h"

@interface CCVFirebaseAuth : NSObject

//
// static method
//

// いずれかでサインインしていたか
+ (BOOL) isSignInAny;

// Googleでサインインしていたか
+ (BOOL) isSignInGoogle;

// Twitterでサインインしていたか
+ (BOOL) isSignInTwitter;

// サインインアカウント一覧取得
+ (NSArray<NSString *> *) signInList;

// サインインアカウント名称一覧
+ (NSArray<NSString *> *) signInNameList;

@end
