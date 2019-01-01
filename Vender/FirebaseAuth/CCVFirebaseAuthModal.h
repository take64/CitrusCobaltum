//
//  CCVFirebaseAuthModal.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/02.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCKeySelectModal.h"

#import <GoogleSignIn/GoogleSignIn.h>

@interface CCVFirebaseAuthModal : CCKeySelectModal <GIDSignInUIDelegate>

@end
