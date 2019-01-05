//
//  CCTableHeaderFooterView.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableHeaderFooterView.h"

#import "CCStyle.h"
#import "CCColor.h"
#import "CCTableFooterView.h"

@implementation CCTableHeaderFooterView

#pragma mark - synthesize
//
// synthesize
//
@synthesize label;
@synthesize labelColor;
@synthesize labelBackgroundColor;
@synthesize control;
@synthesize margin;



#pragma mark - method

//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier;
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        // parts
        CCLabel *_label;
        
        // label
        _label = [[CCLabel alloc] initWithTitle:@""];
        [[_label callStyle] addStyleKeys:@{
                                           @"width"         :@"320",
                                           @"font-size"     :@"14",
                                           @"text-align"    :@"left",
                                           @"vertical-align":@"top",
                                           @"padding"       :@"2 8",
                                           }];
        [self setLabel:_label];
        
        // view
        [self setControl:[[UIView alloc] initWithFrame:CGRectZero]];
        
        // テーマ適用
        [self bindTheme];
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[[self label] callStyle] setFrame:rect];
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithReuseIdentifierWithSection:(NSInteger)section
{
    return [self initWithReuseIdentifier:[[self class] reuseIdentifierWithSection:section]];
}

// タイトル or ビュー設定
- (void) bindTitle:(NSString *)titleString orView:(UIView *)viewValue
{
    // タイトル設定
    if ([titleString length] > 0)
    {
        [self bindTitle:titleString];
    }
    
    // ビュー設定
    if (viewValue != nil)
    {
        [self bindView:viewValue];
    }
}

// タイトル設定
- (void) bindTitle:(NSString *)titleValue
{
    [[self label] setTitle:titleValue];
    
    // remove
    [[self control] removeFromSuperview];
    
    // add
    [[self contentView] addSubview:[self label]];
    
    // サイズ調整
    CGRect rect = [self frame];
    rect.size.height = [[self label] frame].origin.y
                    + [[self label] calcTextAutoSizeWithPadding].height
                    + [[self label] frame].origin.y
                    + [self margin];
    [self setFrame:rect];
    [[self contentView] setFrame:rect];
}

// ビュー設定
- (void) bindView:(UIControl *)viewValue
{
    [[self label] setTitle:@""];
    
    // remove
    [[self label] removeFromSuperview];
    
    // add
    [self setControl:viewValue];
    [[self contentView] addSubview:[self control]];
    
    // サイズ調整
    CGRect rect = [self frame];
    rect.size.height = [viewValue frame].size.height;
    // margin
    if ([self isKindOfClass:[CCTableFooterView class]] == YES)
    {
        rect.size.height += [self margin];
    }
    [self setFrame:rect];
}

// テーマ設定
- (void) bindTheme
{
    [[[self label] callStyle] addStyleKeys:@{
                                             @"color"           :[CCColor hexStringWithColor:[self labelColor]],
                                             @"background-color":[CCColor hexStringWithColor:[self labelBackgroundColor]]
                                             }];
    
    [[self contentView] setBackgroundColor:[CCColor colorTableBackground]];
}



#pragma mark - static method
//
// static method
//

// リサイクルID取得
+ (NSString *) reuseIdentifierWithSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"CCTableHeaderFooterView_%03ld", (long)section];
}

@end
