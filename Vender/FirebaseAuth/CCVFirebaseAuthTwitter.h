//
//  CCVFirebaseAuthTwitter.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/31.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CitrusCobaltumVenderFirebaseAuth.h"

@interface CCVFirebaseAuthTwitter : NSObject

//
// method
//

// sign-in
- (void) signInWithControllr:(UIViewController *)controller;

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
