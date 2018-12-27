//
//  CCTableCellImage.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/28.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellImage.h"

@interface CCTableCellImage()

#pragma mark - property
//
// property
//
@property NSData *imageData;
@property UIImage *image;
@property UIImageView *imageView;

@end



@implementation CCTableCellImage

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // イメージ
        [self setImageView:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)]];
        [self setImage:[[UIImage alloc] init]];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // レイアウト済みの場合
    if ([self isSubLayouted] == YES)
    {
        return;
    }
    
    CGPoint centerPoint = [[self contentView] center];
    [[self imageView] setCenter:centerPoint];

    // レイアウト済み
    [self setSubLayouted:YES];
}



#pragma mark - method
//
// method
//

// 画像設定
- (void) setImageData:(NSData *)dataValue
{
    [self setImageData:dataValue];
    [self setImage:[UIImage imageWithData:dataValue]];
    [[self imageView] setImage:[self image]];
    [[self imageView] layoutIfNeeded];
    [[self contentView] addSubview:[self imageView]];
}

@end
