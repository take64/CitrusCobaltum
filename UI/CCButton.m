//
//  CCButton.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/09/02.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCButton.h"

#import "CCMediaSound.h"



@interface CCButton()

#pragma mark - property
//
// property
//
@property (nonatomic) CCButtonTappedBlock tappedBlock;

@end



@implementation CCButton

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setExclusiveTouch:YES];
        
        // 基本のボタンON
        [self addTarget:self action:@selector(onTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// ボタン押下時ブロック
- (void) setOnTappedComplete:(CCButtonTappedBlock)completeBlock
{
    // 設定
    [self setTappedBlock:completeBlock];
}

// ボタン押下時
- (void) onTapButton:(CCButton *)buttonValue
{
    // ボタン音
    [CCMediaSound playButtonSound];
    
    if (self.tappedBlock != nil)
    {
        self.tappedBlock(buttonValue);
    }
}

@end
