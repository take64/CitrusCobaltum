//
//  CCTableCellTextFieldInnerTextField.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextFieldInnerTextField.h"

@interface CCTableCellTextFieldInnerTextField()

#pragma mark - property
//
// property
//
@property CCTableCellTextFieldInnerTextFieldEditingEndBlock editingEndBlock;

@end



@implementation CCTableCellTextFieldInnerTextField

#pragma mark - synthesize
//
// synthesize
//
@synthesize enableMenu;



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
    }
    return [super canPerformAction:action withSender:sender];
}



#pragma mark - method
//
// method
//

// ボタン押下時ブロック
- (void) setOnEditingEndComplete:(CCTableCellTextFieldInnerTextFieldEditingEndBlock)completeBlock
{
    // 設定
    [self setEditingEndBlock:completeBlock];
    [self addTarget:self action:@selector(onEditingEndTextField:) forControlEvents:UIControlEventEditingDidEnd];
}



#pragma mark - private
//
// private
//

// ボタン押下時
- (void) onEditingEndTextField:(CCTableCellTextFieldInnerTextField *)textFieldValue
{
    if(self.editingEndBlock != nil)
    {
        self.editingEndBlock(textFieldValue);
    }
}

@end
