//
//  CCMark.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCMark.h"

@implementation CCMark

#pragma mark - static method
//
// static method
//

// マーク(クリア)
+ (UIImageView *) markClearWithSize:(CGSize)size
{
    return [CCMark markWithName:@"mark-clear" size:size];
}



#pragma mark - static private
//
// static private
//

// マーク(クリア)の生成
+ (UIImageView *) markWithName:(NSString *)filename size:(CGSize)size
{
    UIImage *image = [UIImage imageNamed:filename];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    return imageView;
}

@end
