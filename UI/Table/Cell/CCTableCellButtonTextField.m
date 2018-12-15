//
//  CCTableCellButtonTextField.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/11.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellButtonTextField.h"

#import "CCButton.h"
#import "CCImageButton.h"
#import "CCMark.h"
#import "CCStyle.h"
#import "CCTableCellTextFieldInnerTextField.h"
#import "CFNVL.h"



@interface CCTableCellButtonTextField()

#pragma mark - property
//
// property
//
@property CCImageButton *clearButton;
@property CCButton *selectButton;

@end



@implementation CCTableCellButtonTextField

#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:nil suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 削除ボタン
        CCImageButton *imageButton = [[CCImageButton alloc] initWithImageView:[CCMark markClearWithSize:CGSizeMake(24, 24)]];
        [[imageButton callStyle] addStyleKeys:@{
                                                @"width"    :@"44",
                                                @"height"   :@"44",
                                                }];
        [self addSubview:imageButton];
        [self setClearButton:imageButton];
        
        // 選択ボタン
        CCButton *button = [[CCButton alloc] initWithTitle:@"..." styleKeys:@{
                                                                              @"left"               :@"40",
                                                                              @"width"              :@"80",
                                                                              @"font-size"          :@"14",
                                                                              @"font-weight"        :@"bold",
                                                                              @"color"              :@"333333",
                                                                              @"background-color"   :@"FFFFFF",
                                                                              @"border-color"       :@"CCCCCC",
                                                                              @"border-width"       :@"1",
                                                                              @"border-radius"      :@"4",
                                                                              @"margin"             :@"4 4 8 4",
                                                                              }];
        [[button callStyleHighlighted] addStyleKeys:@{
                                                      @"background-image" :@"linear-gradient(rgba(0.10, 0.10, 0.10, 0.90) 0.00, rgba(0.10, 0.10, 0.10, 0.50) 0.05, rgba(0.10, 0.10, 0.10, 0.50) 0.95, rgba(0.10, 0.10, 0.10, 0.90) 1.00)",
                                                      }];
        [[button callStyleDisabled] addStyleKeys:@{
                                                   @"background-color"    :@"666666",
                                                   }];
        [self addSubview:button];
        [self setSelectButton:button];
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
    
    CGRect textFieldRect = [self contentFrame];
    textFieldRect.size.width -= 88;
    textFieldRect.origin.x += 88;
    [[self innerTextField] setFrame:textFieldRect];
    
    // レイアウト済み
    [self setSubLayouted:YES];
}

// CCTableCellTextField で実装
//- (void) setSelected:(BOOL)selected animated:(BOOL)animated



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:nil suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [[self innerTextField] setText:textString];
    }
    return self;
}



#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

// 編集開始前
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textFieldValue
{
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
