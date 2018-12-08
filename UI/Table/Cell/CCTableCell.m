//
//  CCTableCell.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCell.h"

#import "CCControl.h"
#import "CCLabel.h"
#import "CCPlatformDevice.h"
#import "CCStyle.h"


@interface CCTableCell()

#pragma mark - property
//
// property
//
@property CCLabel *prefixLabel;
@property CCLabel *suffixLabel;
//@property CGFloat prefixWidth;
//@property CGFloat suffixWidth;
@property CGRect contentFrame;
@property CCTableCellPartPriority prefixPriority;
@property CCTableCellPartPriority contentPriority;
@property CCTableCellPartPriority suffixPriority;

@end



@implementation CCTableCell

//
// synthesize
//
@synthesize entity;
@synthesize object;
@synthesize prefixLabel;
@synthesize suffixLabel;
@synthesize layouted;
@synthesize subLayouted;
@synthesize bgView;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // parts
        CCLabel *label;
        NSDictionary *commonStyleKeys = @{
                                          @"font-size"  :@"14",
                                          @"color"      :@"333333",
                                          @"text-align" :@"center",
                                          };
        
        // 優先度
        [self priorityPrefix:CCTableCellPartPriorityMiddle content:CCTableCellPartPriorityMiddle suffix:CCTableCellPartPriorityMiddle];
        
        // プレフィックス
        label = [[CCLabel alloc] initWithTitle:prefixString styleKeys:commonStyleKeys];
        [[label callStyle] addStyleKeys:@{
                                          @"text-align" :@"left",
                                          @"font-weight":@"bold",
                                          }];
        [[self contentView] addSubview:label];
        [self setPrefixLabel:label];
        
        // サフィックス
        label = [[CCLabel alloc] initWithTitle:suffixString styleKeys:commonStyleKeys];
        [[self contentView] addSubview:label];
        [self setSuffixLabel:label];
        
        // レイアウト
        [self setLayouted:NO];
        [self setSubLayouted:NO];
        
        // 背景
        [self setBgView:[[CCControl alloc] initWithFrame:[self frame]]];
        [[self bgView] setUserInteractionEnabled:NO];
        [self addSubview:[self bgView]];
    }
    return self;
}

// 優先度設定
- (void) priorityPrefix:(CCTableCellPartPriority)prefix content:(CCTableCellPartPriority)content suffix:(CCTableCellPartPriority)suffix
{
    [self setPrefixPriority:prefix];
    [self setContentPriority:content];
    [self setSuffixPriority:suffix];
}

// レイアウト
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    // レイアウト済みの場合
    if ([self isLayouted] == YES)
    {
        return;
    }
    // コンテンツフレーム
    CGRect contentRect = [[self contentView] frame];
    
    // 背景
    [[self bgView] setFrame:contentRect];
    
    // アクセサリがある場合(アクセサリ分を縮める)
    if ([self accessoryType] != UITableViewCellAccessoryNone)
    {
        contentRect.size.width -= 8;
    }
    
    // プレフィックスサイズ
    CGRect prefixRect = [self calcRectPosition:CCTableCellPartPositionPrefix contentRect:contentRect];
    [[self prefixLabel] setFrame:prefixRect];
    
    // サフィックスサイズ
    CGRect suffixRect = [self calcRectPosition:CCTableCellPartPositionSuffix contentRect:contentRect];
    [[self suffixLabel] setFrame:suffixRect];
    
    // コンテンツサイズ変更
    contentRect.origin.x += prefixRect.size.width;
    contentRect.size.width -= (prefixRect.size.width + suffixRect.size.width);
    [self setContentFrame:contentRect];
    
    // レイアウト済み
    [self setLayouted:YES];
}

// bind entity
- (void) bindEntity:(NSManagedObject *)entityValue
{
    [self setEntity:entityValue];
}

// bind object
- (void) bindObject:(NSObject *)objectValue
{
    [self setObject:objectValue];
}



#pragma mark - private
//
// private
//

// ラベルサイズの計算
- (CGRect) calcRectPosition:(CCTableCellPartPosition)position contentRect:(CGRect)contentRect
{
    CCLabel *label = (position == CCTableCellPartPositionPrefix ? [self prefixLabel] : [self suffixLabel]);
    CCTableCellPartPriority priority = (position == CCTableCellPartPositionPrefix ? [self prefixPriority] : [self suffixPriority]);
    CGFloat width = 0;
    
    // タイトルがある場合のサイズ
    if ([label hasTitle] == YES)
    {
        // フォントサイズ
        CGSize fontSize = [[label title] sizeWithAttributes:@{ NSFontAttributeName :[[label callStyle] callFont] }];
        // prefix
        if (position == CCTableCellPartPositionPrefix)
        {
            // 優先度(高)(デフォルト)
            width = fontSize.width + 16;
            // 優先度(中/低)
            if (priority == CCTableCellPartPriorityMiddle || priority == CCTableCellPartPriorityLow)
            {
                width = ([CCPlatformDevice isIPad] == YES ? 120 : 80);
            }
        }
        // suffix
        else if (position == CCTableCellPartPositionSuffix)
        {
            // 優先度(低)(デフォルト)
            width = fontSize.width;
            // 優先度(高/中)
            if (priority == CCTableCellPartPriorityHigh || priority == CCTableCellPartPriorityMiddle)
            {
                width = fontSize.width + 16;
            }
        }
    }
    
    // 優先度(非表示)
    if (priority == CCTableCellPartPriorityHidden)
    {
        width = 0;
    }
    
    // 返却
    if (position == CCTableCellPartPositionPrefix)
    {
        return CGRectMake(16, 0, width, contentRect.size.height);
    }
    return CGRectMake(contentRect.size.width - width , 0, width, contentRect.size.height);
}

@end
