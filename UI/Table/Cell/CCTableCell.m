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
@property CGFloat prefixWidth;
@property CGFloat suffixWidth;
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
        
        // 優先度
        [self priorityPrefix:CCTableCellPartPriorityMiddle content:CCTableCellPartPriorityMiddle suffix:CCTableCellPartPriorityMiddle];
        
        // プレフィックス
        label = [[CCLabel alloc] initWithTitle:prefixString];
        [[label callStyle] addStyleKeys:@{
                                          @"font-size"  :@"14",
                                          @"color"      :@"333333",
                                          @"text-align" :@"left",
                                          @"font-weight":@"bold",
                                          }];
        [[self contentView] addSubview:label];
        [self setPrefixLabel:label];
        
        // サフィックス
        label = [[CCLabel alloc] initWithTitle:suffixString];
        [[label callStyle] addStyleKeys:@{
                                          @"font-size"  :@"14",
                                          @"color"      :@"333333",
                                          @"text-align" :@"center",
                                          }];
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
    
    // 未レイアウトの場合
    if ([self isLayouted] == NO)
    {
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
        if (([[self prefixLabel] title] != nil && [[[self prefixLabel] title] length] > 0) || [self prefixWidth] > 0)
        {
            // prefix優先度(非表示)
            if ([self prefixPriority] == CCTableCellPartPriorityHidden)
            {
                [self setPrefixWidth:0];
            }
            // prefix優先度(高)
            else if ([self prefixPriority] == CCTableCellPartPriorityHigh)
            {
                CGSize prefixFontSize = [[[self prefixLabel] title] sizeWithAttributes:@{ NSFontAttributeName :[[[self prefixLabel] callStyle] callFont] }];
                [self setPrefixWidth:prefixFontSize.width + 16];
            }
            // prefix優先度(中/低)
            else if ([self prefixPriority] == CCTableCellPartPriorityMiddle || [self prefixPriority] == CCTableCellPartPriorityLow)
            {
                [self setPrefixWidth:8];
                if ([CCPlatformDevice isIPad] == YES)
                {
                    [self setPrefixWidth:120];
                }
                else
                {
                    [self setPrefixWidth:80];
                }
            }
        }
        CGRect prefixRect = CGRectMake(16, 0, [self prefixWidth], contentRect.size.height);
        [[self prefixLabel] setFrame:prefixRect];
        
        
        // サフィックスサイズ
        //        CGFloat suffixWidth = 16;
        if (([[self suffixLabel] title] != nil && [[[self suffixLabel] title] length] > 0) || [self suffixWidth] > 0)
        {
            // suffix優先度(高/中)
            if ([self suffixPriority] == CCTableCellPartPriorityHigh || [self suffixPriority] == CCTableCellPartPriorityMiddle)
            {
                CGSize suffixFontSize = [[[self suffixLabel] title] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont] }];
                [self setSuffixWidth:suffixFontSize.width + 16];
            }
            // suffix優先度(低)
            else if ([self suffixPriority] == CCTableCellPartPriorityLow)
            {
                CGSize suffixFontSize = [[[self suffixLabel] title] sizeWithAttributes:@{ NSFontAttributeName:[[[self suffixLabel] callStyle] callFont]}];
                [self setSuffixWidth:suffixFontSize.width];
            }
            // suffix優先度(非表示)
            else if ([self suffixPriority] == CCTableCellPartPriorityHidden)
            {
                [self setSuffixWidth:0];
            }
        }
        CGRect suffixRect = CGRectMake(contentRect.size.width - [self suffixWidth] , 0, [self suffixWidth], contentRect.size.height);
        [[self suffixLabel] setFrame:suffixRect];
        
        // コンテンツサイズ変更
        contentRect.origin.x += [self prefixWidth];
        contentRect.size.width -= [self prefixWidth];
        contentRect.size.width -= [self suffixWidth];
        [self setContentFrame:contentRect];
        
        // レイアウト済み
        [self setLayouted:YES];
    }
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

@end
