//
//  CCVFirebaseAuthTwitter.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/31.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCVFirebaseAuthTwitter.h"



@interface CCVFirebaseAuthTwitter()

#pragma mark - property
//
// property
//
@property CitrusCobaltumFirebaseAuthBlock signInBlock;
@property CitrusCobaltumFirebaseAuthBlock signOutBlock;

@end



@implementation CCVFirebaseAuthTwitter

#pragma mark - method
//
// method
//

// sign in
- (void) signInWithControllr:(UIViewController *)controller;
{
    [[Twitter sharedInstance] logInWithViewController:controller completion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
        if (session != nil)
        {
            FIRAuthCredential *credential = [FIRTwitterAuthProvider credentialWithToken:[session authToken] secret:[session authTokenSecret]];
            
            if ([[FIRAuth auth] currentUser] && [CCVFirebaseAuthTwitter isSignIn] == NO)
            {
                [[[FIRAuth auth] currentUser] linkAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                    if (self.signInBlock != nil)
                    {
                        self.signInBlock([authResult user], error);
                    }
                }];
            }
            else
            {
                [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                    if (self.signInBlock != nil)
                    {
                        self.signInBlock([authResult user], error);
                    }
                }];
            }
        }
    }];
}

// sign-out
- (void) signOutWithControllr:(UIViewController *)controller
{
    [[[FIRAuth auth] currentUser] unlinkFromProvider:FIRTwitterAuthProviderID completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        self.signOutBlock(user, error);
    }];
}

// bind block
- (void) bindBlockSignIn:(CitrusCobaltumFirebaseAuthBlock)signIn signOut:(CitrusCobaltumFirebaseAuthBlock)signOut
{
    [self setSignInBlock:signIn];
    [self setSignOutBlock:signOut];
}



#pragma mark - static method
//
// static method
//

// is sign-in
+ (BOOL) isSignIn
{
    BOOL result = NO;
    if ([[FIRAuth auth] currentUser])
    {
        NSArray<id<FIRUserInfo>> *providerData = [[[FIRAuth auth] currentUser] providerData];
        for (id<FIRUserInfo> userInfo in providerData)
        {
            if ([[userInfo providerID] isEqualToString:FIRTwitterAuthProviderID] == YES)
            {
                result = YES;
                break;
            }
        }
    }
    return result;
}



#pragma mark - static singleton
//
// static singleton
//

// singleton
+ (instancetype) sharedService
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

@end
