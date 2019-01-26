//
//  CCGraphics.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCGraphics : NSObject

//
// static method
//

// 線分
+ (void) drawLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;

// 丸
+ (void) drawCircle:(CGContextRef)context point:(CGPoint)point size:(CGFloat)size;

@end
