//
//  CCVFirebaseAuthGoogle.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusCobaltumVenderFirebaseAuth.h"

@interface CCVFirebaseAuthGoogle : NSObject <GIDSignInDelegate>

//
// method
//

// sign-in
- (void) signInWithControllr:(UIViewController<GIDSignInUIDelegate> *)controller;

// sign-out
- (void) signOutWithControllr:(UIViewController *)controller;

// bind block
- (void) bindBlockSignIn:(CitrusCobaltumFirebaseAuthBlock)signIn signOut:(CitrusCobaltumFirebaseAuthBlock)signOut;



//
// static method
//

// is sign-in
+ (BOOL) isSignIn;



//
// static singleton
//

// singleton
+ (instancetype) sharedService;

@end
