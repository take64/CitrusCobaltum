//
//  CCVFirebaseAuth.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/31.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCVFirebaseAuth.h"

@implementation CCVFirebaseAuth

#pragma mark - static method
//
// static method
//

// いずれかでサインインしていたか
+ (BOOL) isSignInAny
{
    if ([CCVFirebaseAuthGoogle isSignIn] == YES
       || [CCVFirebaseAuthTwitter isSignIn] == YES)
    {
        return YES;
    }
    
    return NO;
}

// Googleでサインインしていたか
+ (BOOL) isSignInGoogle
{
    return [CCVFirebaseAuthGoogle isSignIn];
}

// Twitterでサインインしていたか
+ (BOOL) isSignInTwitter
{
    return [CCVFirebaseAuthTwitter isSignIn];
}

// サインインアカウント一覧取得
+ (NSArray<NSString *> *) signInList
{
    NSMutableArray *list = [@[] mutableCopy];
    
    if ([self isSignInGoogle] == YES)
    {
        [list addObject:kFirebaseAuthTypeGoogle];
    }
    if ([self isSignInTwitter] == YES)
    {
        [list addObject:kFirebaseAuthTypeTwitter];
    }
    return [list copy];
}

// サインインアカウント名称一覧
+ (NSArray<NSString *> *) signInNameList
{
    NSMutableArray *list = [@[] mutableCopy];
    
    if ([self isSignInGoogle] == YES)
    {
        [list addObject:kFirebaseAuthNameGoogle];
    }
    if ([self isSignInTwitter] == YES)
    {
        [list addObject:kFirebaseAuthNameTwitter];
    }
    return [list copy];
}

@end
