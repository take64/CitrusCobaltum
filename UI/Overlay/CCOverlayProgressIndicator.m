//
//  CCOverlayProgressIndicator.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCOverlayProgressIndicator.h"

#import "CitrusCobaltumTypedef.h"
#import "CCLabel.h"
#import "CCStyle.h"

#import "CitrusFerrumTypedef.h"
#import "CFString.h"



@interface CCOverlayProgressIndicator()

#pragma mark - property
//
// property
//
@property UIActivityIndicatorView *activityIndicator;
@property UIProgressView *progressBar;
@property CCLabel *titleLabel;
@property CCLabel *messageLabel;
@property CCLabel *percentageLabel;
@property NSNumber *denominator;
@property NSNumber *numerator;
@property UIView *parentView;
@property dispatch_queue_t drawQueue;

@end



@implementation CCOverlayProgressIndicator

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
        // 背景
        [[self callStyle] addStyleKey:@"background-color" value:@"0000007F"];
        
        // パネル
        CCControl *panel = [[CCControl alloc] initWithTitle:@"" styleKeys:@{
                                                                            @"top"              :[CFString stringWithInt:((frame.size.height / 2) - (160 / 2))],
                                                                            @"left"             :[CFString stringWithInt:((frame.size.width / 2) - (240 / 2))],
                                                                            @"width"            :@"240",
                                                                            @"height"           :@"160",
                                                                            @"background-color" :@"0000007F",
                                                                            @"border-radius"    :@"8",
                                                                            }];
        [self addSubview:panel];
        
        // タイトル
        [self setTitleLabel:[[CCLabel alloc] initWithTitle:@"" styleKeys:@{
                                                                           @"top"           :@"0",
                                                                           @"left"          :@"0",
                                                                           @"width"         :@"240",
                                                                           @"height"        :@"32",
                                                                           @"font-size"     :@"16",
                                                                           @"font-weight"   :@"bold",
                                                                           @"color"         :@"FFFFFF",
                                                                           }]];
        [panel addSubview:[self titleLabel]];
        
        // アクティビティインジケーター
        [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithFrame:CGRectZero]];
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [[self activityIndicator] setCenter:CGPointMake(CC8(15), CC8(8))];
        [panel addSubview:[self activityIndicator]];
        
        // パーセント
        [self setPercentageLabel:[[CCLabel alloc] initWithTitle:@"0/100" styleKeys:@{
                                                                                     @"top"         :@"88",
                                                                                     @"left"        :@"0",
                                                                                     @"width"       :@"240",
                                                                                     @"height"      :@"32",
                                                                                     @"font-size"   :@"16",
                                                                                     @"font-weight" :@"bold",
                                                                                     @"color"       :@"FFFFFF",
                                                                                     }]];
        [panel addSubview:[self percentageLabel]];
        
        // プログレスバー
        [self setProgressBar:[[UIProgressView alloc] initWithFrame:CGRectMake(CC8(2), CC8(15), CC8(26), 50)]];
        [[self progressBar] setProgressViewStyle:UIProgressViewStyleBar];
        [[self progressBar] setProgress:0 animated:NO];
        [panel addSubview:[self progressBar]];
        
        // メッセージ
        [self setMessageLabel:[[CCLabel alloc] initWithTitle:@"" styleKeys:@{
                                                                             @"top"         :@"128",
                                                                             @"left"        :@"0",
                                                                             @"width"       :@"240",
                                                                             @"height"      :@"32",
                                                                             @"font-size"   :@"14",
                                                                             @"color"       :@"FFFFFF",
                                                                             }]];
        [panel addSubview:[self messageLabel]];
        
        [self setDrawQueue: dispatch_queue_create("tk.citrus.cobaltum.draw",  DISPATCH_QUEUE_SERIAL)];
    }
    return self;
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithParent:(UIView *)view;
{
    CGRect parentFrame = [view frame];
    CGFloat width;
    CGFloat height;
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait)
    {
        width   = MIN(parentFrame.size.width, parentFrame.size.height);
        height  = MAX(parentFrame.size.width, parentFrame.size.height);
    }
    else
    {
        width   = MAX(parentFrame.size.width, parentFrame.size.height);
        height  = MIN(parentFrame.size.width, parentFrame.size.height);
    }
    if (parentFrame.size.width != width)
    {
        parentFrame.origin.y = 0;
        parentFrame.origin.x = 0;
    }
    
    parentFrame.size.width = width;
    parentFrame.size.height = height;
    
    self = [self initWithFrame:parentFrame];
    if (self)
    {
        // 親ビュー
        [self setParentView:view];
    }
    return self;
}

// 表示
- (void) show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 回転開始
        [[self activityIndicator] startAnimating];
        
        // 表示
        [[self parentView] addSubview:self];
    });
}

// 非表示
- (void) hide
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // プログレス
        [self updateNumerator:@1 denominator:@1];
        
        // 回転停止
        [[self activityIndicator] stopAnimating];
        
        // 非表示
        [self removeFromSuperview];
    });
}

// タイトル
- (void) setTitle:(NSString *) stringValue
{
    [[self titleLabel] setTitle:stringValue];
}

// メッセージ
- (void) setMessage:(NSString *) stringValue
{
    [[self messageLabel] setTitle:stringValue];
}

// パーセンテージ
- (void) setPercentage:(NSString *)stringValue
{
    CFLog(@"CTOverlayProgressIndicator.setPercentage : %@", stringValue);
    [[self percentageLabel] setTitle:stringValue];
}

// 分子更新
- (void) updateNumerator:(NSNumber *)numberValue
{
    // 分子更新
    [self setNumerator:numberValue];
    
    // バー更新
    [self updateProgressBar];
}

// 分母更新
- (void) updateDenominator:(NSNumber *)numberValue
{
    // 分母更新
    [self setDenominator:numberValue];
    
    // バー更新
    [self updateProgressBar];
}

// 分子分母更新
- (void) updateNumerator:(NSNumber *)numberValue1 denominator:(NSNumber *)numberValue2
{
    // メインメソッドじゃなかったら再帰処理
    if ([NSThread isMainThread] == NO)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateNumerator:numberValue1 denominator:numberValue2];
        });
        return;
    }
    
    // 分子更新
    [self setNumerator:numberValue1];
    // 分母更新
    [self setDenominator:numberValue2];
    
    // バー更新
    [self updateProgressBar];
}

// バー更新
- (void) updateProgressBar
{
    // 進捗計算
    CGFloat progress = [[self numerator] floatValue] / [[self denominator] floatValue];
    if (isnan(progress) == TRUE || progress < 0)
    {
        progress = 0;
    }
    
    // バー更新
    BOOL animated = (progress == 0 ? NO : YES);
    [[self progressBar] setProgress:progress animated:animated];
    
    // パーセンテージ更新
    [self setPercentage:[NSString stringWithFormat:@"%.2f %%", (progress * 100)]];
}

// 分子更新
- (void) updateWithInfo:(NSDictionary *)infoValue;
{
    if ([infoValue objectForKey:@"numerator"] != nil)
    {
        [self updateNumerator:[infoValue objectForKey:@"numerator"]];
    }
    if ([infoValue objectForKey:@"denominator"] != nil)
    {
        [self updateDenominator:[infoValue objectForKey:@"denominator"]];
    }
    if ([infoValue objectForKey:@"title"] != nil)
    {
        [self setTitle:[infoValue objectForKey:@"title"]];
    }
    if ([infoValue objectForKey:@"message"] != nil)
    {
        [self setMessage:[infoValue objectForKey:@"message"]];
    }
}

@end
