//
//  CCTableCellTextView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextView.h"

#import "CCUIStruct.h"
#import "CCTextView.h"


@interface CCTableCellTextView()

#pragma mark - property
//
// property
//
@property CCTextView *textView;
@property CitrusCobaltumBlock didEndEditingBlock;

@end



@implementation CCTableCellTextView

#pragma mark - extends
//
// extends
//

// 配下ビューの再配置
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // レイアウト済みの場合
    if ([self isSubLayouted] == YES)
    {
        return;
    }
    
    [[self textView] setFrame:[self contentFrame]];
    
    // レイアウト済み
    [self setSubLayouted:YES];
}

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // part
        CCTextView *_textView;
        
        // テキストフィールド
        _textView = [[CCTextView alloc] initWithFrame:CGRectZero];
        [_textView setFont:[UIFont systemFontOfSize:16.0]];
        [_textView setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_textView setReturnKeyType:UIReturnKeyDone];
        [_textView setAutoresizingMask:CCViewAutoresizingMaskAll()];
        [_textView setDelegate:self];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [[self contentView] addSubview:_textView];
        [self setTextView:_textView];
        
        // セル選択
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

// テキスト取得
- (NSString *) contentText
{
    return [[self textView] text];
}
// テキスト設定
- (void) setContentText:(NSString *)stringValue
{
    [[self textView] setText:stringValue];
}



#pragma mark - UITextViewDelegate
//
// UITextViewDelegate
//

// 編集開始前
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
//- (void)textViewDidBeginEditing:(UITextView *)textView;

// 編集終了後
- (void) textViewDidEndEditing:(UITextView *)textView
{
    // 編集後処理が登録されていて、呼べれば呼ぶ
    if (self.didEndEditingBlock != nil)
    {
        self.didEndEditingBlock();
    }
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
//- (void)textViewDidChange:(UITextView *)textView;
//- (void)textViewDidChangeSelection:(UITextView *)textView;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithPrefix:nil content:nil suffix:nil reuseIdentifier:reuseIdentifier];
}

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSString *)textString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [[self textView] setText:textString];
    }
    return self;
}

@end
