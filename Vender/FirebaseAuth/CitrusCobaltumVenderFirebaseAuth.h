//
//  CitrusCobaltumVenderFirebaseAuth.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CitrusCobaltumVenderFirebaseAuth_h
#define CitrusCobaltumVenderFirebaseAuth_h

static NSString * const kFirebaseAuthTypeTwitter    = @"twitter";   // twitter
static NSString * const kFirebaseAuthTypeGoogle     = @"google";    // google

static NSString * const kFirebaseAuthNameTwitter    = @"Twitter";   // twitter
static NSString * const kFirebaseAuthNameGoogle     = @"Google";    // google


static NSString *CCVFirebaseAuthNotificationKey          = @"action";
static NSString *CCVFirebaseAuthNotificationTypeMessage  = @"message";

#import <FirebaseAuth/FirebaseAuth.h>

//// Firebase
//#import "Firebase.h"
//
// google
#import <GoogleSignIn/GoogleSignIn.h>
//
//// facebook
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBAudienceNetwork/FBAudienceNetwork.h>
//

// twitter
#import <TwitterKit/TWTRKit.h>
//#import <Fabric/Fabric.h>
//#import <TwitterKit/TwitterKit.h>


typedef void (^CitrusCobaltumFirebaseAuthBlock)(FIRUser *user, NSError *error);
//typedef void (^CitrusCobaltumFirebaseDatabaseResultBlock)(NSDictionary *result);


//#import "CTFirebaseSignInTypeModal.h"

// sign-in
#import "CCVFirebaseAuth.h"
#import "CCVFirebaseAuthGoogle.h"
#import "CCVFirebaseAuthTwitter.h"
#import "CCVFirebaseAuthModal.h"

//
//// database
//#import "CTFirebaseDatabase.h"
//
//// notification
//#import "CTFirebaseNotification.h"


#endif /* CitrusCobaltumVenderFirebaseAuth_h */
