//
//  CCTableCellFavorite.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/20.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellFavorite.h"

#import "CCUIStruct.h"
#import "CCLabel.h"
#import "CCStyle.h"



@interface CCTableCellFavorite()

#pragma mark - property
//
// property
//
@property CitrusCobaltumSwitchBlock switchBlock;

@end



@implementation CCTableCellFavorite

#pragma mark - synthesize
//
// synthesize
//
@synthesize on;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:@"☆" reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // ☆マーク
        [[self suffixLabel] setUserInteractionEnabled:YES];
        [[[self suffixLabel] callStyle] addStyleKeys:@{
                                                       @"color"     :@"FF9933",
                                                       @"font-size" :@"22"
                                                       }];
        [[self suffixLabel] addTarget:self action:@selector(onTapButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



#pragma mark - method
//
// method
//

// スイッチ
- (void)toggleSwitch
{
    [self switchOn:![self isOn]];
}

// スイッチ
- (void)switchOn:(BOOL)onValue
{
    [self setOn:onValue];
    
    // 描画
    [self drawSwitch];
}

// 描画
- (void)drawSwitch
{
    NSString *starMark = ([self isOn] == YES ? @"★" : @"☆");
    [[self suffixLabel] setTitle:starMark];
    [[self suffixLabel] setNeedsLayout];
}



#pragma mark - private
//
// private
//

// ボタン押下時
- (void)onTapButton
{
    [self toggleSwitch];
    
    if (self.switchBlock != nil)
    {
        self.switchBlock(@([self isOn]));
    }
}

@end
