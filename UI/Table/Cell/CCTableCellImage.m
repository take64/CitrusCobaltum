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
@property UIImageView *_imageView;

@end



@implementation CCTableCellImage

#pragma mark - extends
//
// extends
//

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

// 初期化
- (instancetype) initWithImageFrame:(CGRect)imageFrame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:nil suffix:nil reuseIdentifier:reuseIdentifier];
    if (self)
    {
        if (CGRectIsNull(imageFrame) == TRUE)
        {
            imageFrame = CGRectMake(0, 0, 100, 100);
        }
            
        // イメージ
        [self set_imageView:[[UIImageView alloc] initWithFrame:imageFrame]];
        [self setImage:[[UIImage alloc] init]];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

// 画像設定
- (void) bindImageData:(NSData *)dataValue
{
    [self setImageData:dataValue];
    [self setImage:[UIImage imageWithData:dataValue]];
    [[self _imageView] setImage:[self image]];
    [[self _imageView] layoutIfNeeded];
    [[self contentView] addSubview:[self _imageView]];
}

@end
