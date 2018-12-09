//
//  CCTextView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTextView.h"

@interface CCTextView()

#pragma mark - property
//
// property
//
@property BOOL enableMenu;

@end



@implementation CCTextView

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // メニュー表示ON
        [self setEnableMenu:YES];
    }
    return self;
}

// コマンドの有効/無効
- (BOOL) canPerformAction:(SEL)action withSender:(id)sender
{
    if ([self enableMenu] == NO)
    {
        [[UIMenuController sharedMenuController] setMenuVisible:NO];
        [self resignFirstResponder];
    }
    return [super canPerformAction:action withSender:sender];
}

@end
