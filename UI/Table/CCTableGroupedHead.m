//
//  CCTableGroupedHead.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/18.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableGroupedHead.h"

#import "CitrusCobaltumTypedef.h"
#import "CCStyle.h"



@interface CCTableGroupedHead()

@end



@implementation CCTableGroupedHead

#pragma mark - synthesize
//
// synthesize
//
@synthesize cellView;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // ヘッダビュー
        [self setCellView:[[CCControl alloc] initWithTitle:@"" styleKeys:@{
                                                                           @"width"             :@"320",
                                                                           @"height"            :@"24",
                                                                           @"text-align"        :@"left",
                                                                           @"text-shadow"       :@"0 -1 1 666666",
                                                                           @"font-weight"       :@"bold",
                                                                           @"font-size"         :@"16",
                                                                           @"color"             :@"FFFFFF",
                                                                           @"padding"           :@"0 0 0 16",
                                                                           @"background-color"  :@"008080",
                                                                           }]];
        [self addSubview:[self cellView]];
    }
    return self;
}

- (void) layoutSubviews
{
    // 自動で高さ調節しておく
    CGRect rect = [self frame];
    CGFloat height = rect.size.height;
    [[[self cellView] callStyle] addStyleKey:@"height" value:CCStr(height)];
}



#pragma mark - method
//
// method
//

// テキストの設定
- (void) setText:(NSString *)textString
{
    [[self cellView] setTitle:textString];
}

// 色の設定
- (void) setTintColor:(NSString *)tintColorString
{
    [[[self cellView] callStyle] addStyleKey:@"background-color" value:tintColorString];
}

@end
