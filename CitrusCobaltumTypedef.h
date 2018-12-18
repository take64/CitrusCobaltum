//
//  CitrusCobaltumTypedef.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/18.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CitrusCobaltumTypedef_h
#define CitrusCobaltumTypedef_h

__attribute__((unused)) static CGFloat CC8(CGFloat oct)
{
    return oct * 8;
}
__attribute__((unused)) static NSString * CC8Str(CGFloat oct)
{
    return [@(CC8(oct)) stringValue];
}
__attribute__((unused)) static NSString * CCStr(CGFloat floatValue)
{
    return [@(floatValue) stringValue];
}

#endif /* CitrusCobaltumTypedef_h */
