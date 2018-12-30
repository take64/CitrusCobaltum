//
//  CCVFirebaseAuthGoogle.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCVFirebaseAuthGoogle.h"



@interface CCVFirebaseAuthGoogle()

#pragma mark - property
//
// property
//
@property CitrusCobaltumFirebaseAuthBlock signInBlock;
@property CitrusCobaltumFirebaseAuthBlock signOutBlock;

@end



@implementation CCVFirebaseAuthGoogle

//
// synthesize
//
@synthesize signInBlock;
@synthesize signOutBlock;



#pragma mark - method
//
// method
//

// sign in
- (void) signInWithControllr:(UIViewController<GIDSignInUIDelegate> *)controller;
{
    [[GIDSignIn sharedInstance] setUiDelegate:controller];
    [[GIDSignIn sharedInstance] signIn];
}

// sign-out
- (void) signOutWithControllr:(UIViewController *)controller
{
    [[[FIRAuth auth] currentUser] unlinkFromProvider:FIRGoogleAuthProviderID completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        self.signOutBlock(user, error);
    }];
}

// bind block
- (void) bindBlockSignIn:(CitrusCobaltumFirebaseAuthBlock)signIn signOut:(CitrusCobaltumFirebaseAuthBlock)signOut
{
    [self setSignInBlock:signIn];
    [self setSignOutBlock:signOut];
}



#pragma mark - GIDSignInDelegate
//
// GIDSignInDelegate
//

// sign-in
- (void) signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    GIDAuthentication *authentication = [user authentication];
    FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:[authentication idToken] accessToken:[authentication accessToken]];
    
    if (error == nil)
    {
        if ([[FIRAuth auth] currentUser] && [CCVFirebaseAuthGoogle isSignIn] == NO)
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
}

// sign-out
- (void) signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (self.signOutBlock != nil)
    {
        self.signOutBlock(nil, error);
    }
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
            if ([[userInfo providerID] isEqualToString:FIRGoogleAuthProviderID] == YES)
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
