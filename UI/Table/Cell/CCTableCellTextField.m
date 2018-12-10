//
//  CCTableCellTextField.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextField.h"

#import "CCTableCellTextFieldInnerTextField.h"
#import "CCTableCellTextView.h"
#import "CCTableCellDatePicker.h"

@interface CCTableCellTextField()

#pragma mark - property
//
// property
//
@property UIToolbar *toolbar;
@property UISegmentedControl *prevNextSegmented;
@property CCTableCellTextField *prevCell;
@property CCTableCellTextField *nextCell;
@property UIResponder *responder;

@end



@implementation CCTableCellTextField

#pragma mark - synthesize
//
// synthesize
//
@synthesize innerTextField;



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
        // テキストフィールド
        CCTableCellTextFieldInnerTextField *textField = [[CCTableCellTextFieldInnerTextField alloc] initWithFrame:CGRectZero];
        [textField setFont:[UIFont systemFontOfSize:14.0]];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [textField setReturnKeyType:UIReturnKeyDone];
        [textField setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin    |
                                        UIViewAutoresizingFlexibleRightMargin   |
                                        UIViewAutoresizingFlexibleTopMargin     |
                                        UIViewAutoresizingFlexibleBottomMargin  |
                                        UIViewAutoresizingFlexibleWidth         |
                                        UIViewAutoresizingFlexibleHeight
                                        )];
        [textField setDelegate:self];
        [[self contentView] addSubview:textField];
        [self setInnerTextField:textField];
        [self setResponder:textField];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        // ツールバー
        [self setToolbar:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)]];
        [[self toolbar] setBarStyle:UIBarStyleBlackOpaque];
        [[self toolbar] setTranslucent:YES];
        [self setPrevNextSegmented:[[UISegmentedControl alloc] initWithItems:@[@"前へ", @"次へ"]]];
        //        [[self prevNextSegmented] setSegmentedControlStyle:UISegmentedControlStyleBar];
        [[self prevNextSegmented] addTarget:self action:@selector(onChangePrevNextSegmented:) forControlEvents:UIControlEventValueChanged];
        [[self prevNextSegmented] setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *barButtonPrevNext = [[UIBarButtonItem alloc] initWithCustomView:[self prevNextSegmented]];
        
        // ツールバーパーツ
        UIBarButtonItem *barSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapBarButtonDone)];
        [barButtonDone setTintColor:[UIColor whiteColor]];
        [[self toolbar] setItems:[NSArray arrayWithObjects:barButtonPrevNext, barSpacer, barButtonDone, nil]];
        
        // ツールバー(配置)
        [[self innerTextField] setInputAccessoryView:[self toolbar]];
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
    textFieldRect.size.width -= 8;
    textFieldRect.origin.x += 8;
    [[self innerTextField] setFrame:textFieldRect];
    
    // レイアウト済み
    [self setSubLayouted:YES];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected == NO)
    {
        return;
    }
    
    if ([[self innerTextField] canBecomeFirstResponder] == YES)
    {
        [[self innerTextField] becomeFirstResponder];
    }
}



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
    if (self)
    {
        [self setContentText:textString];
    }
    return self;
}

// テキスト取得
- (NSString *) contentText
{
    if ([[self innerTextField] text] == nil)
    {
        return @"";
    }
    return [[self innerTextField] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self innerTextField] setText:stringValue];
}

// レスポンダ設定(前へ)
- (void) setPrevCellResponder:(CCTableCellTextField *)tableCell
{
    if ([self isTargetOfTableCellClass:tableCell] == NO)
    {
        return;
    }
    // 後ポインタの設定
    [tableCell setNextCellResponder:self];
    
    // 前ポインタの設定
    [self setPrevCell:tableCell];
    
    // リフレッシュ
    [self refreshPrevNextSegmented];
 }

// レスポンダ設定(次へ)
- (void) setNextCellResponder:(CCTableCellTextField *)tableCell
{
    if ([self isTargetOfTableCellClass:tableCell] == NO)
    {
        return;
    }
    // 後ポインタの設定
    [self setNextCell:tableCell];
    
    // リフレッシュ
    [self refreshPrevNextSegmented];
}



#pragma mark - private
//
// private
//

// 対象のTableCellクラスかどうか
- (BOOL) isTargetOfTableCellClass:(CCTableCellTextField *)tableCell
{
    return ([tableCell isKindOfClass:[CCTableCellTextField class]] == YES
            || [tableCell isKindOfClass:[CCTableCellDatePicker class]] == YES
            || [tableCell isKindOfClass:[CCTableCellTextView class]] == YES);
}

// ボタン押下時(キーボードDONE)
- (void) onTapBarButtonDone
{
    if ([[self responder] canResignFirstResponder] == YES)
    {
        [[self responder] resignFirstResponder];
    }
}

// 値変更時(前後ボタン)
- (void) onChangePrevNextSegmented:(UISegmentedControl *)segmentedControl
{
    // デフォルトは前へ
    CCTableCellTextField *tableCellTextField = [self prevCell];
    if ([segmentedControl selectedSegmentIndex] == 1)
    {
        // 次へ
        tableCellTextField = [self nextCell];
    }
    
    if (tableCellTextField != nil && [tableCellTextField responder] != nil && [[tableCellTextField responder] canBecomeFirstResponder] == YES)
    {
        [[tableCellTextField responder] becomeFirstResponder];
    }
    
    // リフレッシュ
    [self refreshPrevNextSegmented];
}

// リフレッシュ(前後ボタン)
- (void) refreshPrevNextSegmented
{
    // 前ボタン
    [[self prevNextSegmented] setEnabled:([self prevCell] != nil && [[self prevCell] responder] != nil) forSegmentAtIndex:0];
    // 後ボタン
    [[self prevNextSegmented] setEnabled:([self nextCell] != nil && [[self nextCell] responder] != nil) forSegmentAtIndex:1];
    // 選択状態を表示するかどうか
    [[self prevNextSegmented] setMomentary:YES];
}



#pragma mark - UITextFieldDelegate
//
// UITextFieldDelegate
//

//// 編集開始前
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textFieldValue
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//// 編集終了後
//- (void)textFieldDidEndEditing:(UITextField *)textFieldValue
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//- (BOOL)textFieldShouldReturn:(UITextField *)textField

// 編集開始時
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self refreshPrevNextSegmented];
    return YES;
}

// Return押し時
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
