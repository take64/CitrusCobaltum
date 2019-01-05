//
//  CCOverlayIndicator.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/03.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCOverlayIndicator.h"

#import "CitrusCobaltumTypedef.h"
#import "CCLabel.h"
#import "CCStyle.h"

#import "CFString.h"



@interface CCOverlayIndicator()

#pragma mark - property
//
// property
//
@property UIActivityIndicatorView *activityIndicator;
@property CCLabel *titleLabel;
@property CCLabel *messageLabel;
@property UIView *parentView;

@end



@implementation CCOverlayIndicator

#pragma mark - extends
//
// exnteds
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
        CCControl *panel = [[CCControl alloc] initWithStyleKeys:@{
                                                                  @"top"                :CCStr((frame.size.height / 2) - (160 / 2)),
                                                                  @"left"               :CCStr((frame.size.width / 2) - (240 / 2)),
                                                                  @"width"              :@"240",
                                                                  @"height"             :@"160",
                                                                  @"background-color"   :@"0000007F",
                                                                  @"border-radius"      :@"8",
                                                                  }];
        [self addSubview:panel];
        
        // タイトル
        [self setTitleLabel:[[CCLabel alloc] initWithStyleKeys:@{
                                                                 @"top"         :@"0",
                                                                 @"left"        :@"0",
                                                                 @"width"       :@"240",
                                                                 @"height"      :@"32",
                                                                 @"font-size"   :@"16",
                                                                 @"font-weight" :@"bold",
                                                                 }]];
        [panel addSubview:[self titleLabel]];
        
        // アクティビティインジケーター
        [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithFrame:CGRectZero]];
        [[self activityIndicator] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [[self activityIndicator] setCenter:CGPointMake(CC8(15), CC8(10))];
        [panel addSubview:[self activityIndicator]];
        
        // メッセージ
        [self setMessageLabel:[[CCLabel alloc] initWithStyleKeys:@{
                                                                   @"top"       :@"128",
                                                                   @"left"      :@"0",
                                                                   @"width"     :@"240",
                                                                   @"height"    :@"32",
                                                                   @"font-size" :@"14",
                                                                   }]];
        [panel addSubview:[self messageLabel]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithParent:(UIView *)view
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
    // 回転開始
    [[self activityIndicator] startAnimating];
    
    // 表示
    [[self parentView] addSubview:self];
}

// 非表示
- (void) hide
{
    // 回転停止
    [[self activityIndicator] stopAnimating];
    
    // 非表示
    [self removeFromSuperview];
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

@end
