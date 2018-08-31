//
//  CCDrawerMenuPanel.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018年 citrus.tk. All rights reserved.
//

#import "CCDrawerMenuPanel.h"

#import "CCStyle.h"
#import "CCView.h"
#import "CCColor.h"

static CGFloat const kImageSizeOneSide = 64;

@interface CCDrawerMenuPanel()

#pragma mark - property
//
// property
//
@property UIImageView *headImageView;

@end



@implementation CCDrawerMenuPanel

#pragma mark - synthesize
//
// synthesize
//
@synthesize headView;
@synthesize menuTableView;



#pragma mark - method
//
// method
//

// init
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // パネルサイズ
        CGSize panelSize = frame.size;
        // ヘッダサイズ
        CGSize headSize = CGSizeMake(panelSize.width, panelSize.width);
        // 画像サイズ
        CGSize imageSize = CGSizeMake(kImageSizeOneSide, kImageSizeOneSide);
        
        // ヘッダビュー
        CCView *view;
        view = [[CCView alloc] initWithFrame:CGRectMake(0, 0, headSize.width, headSize.height)];
        [view setUserInteractionEnabled:YES];
        [self addSubview:view];
        [self setHeadView:view];
        
        // 画像
        UIImageView *imageView;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        [imageView setCenter:[view center]];
        [imageView setClipsToBounds:YES];
        [[imageView layer] setCornerRadius:8];
        [view addSubview:imageView];
        [self setHeadImageView:imageView];
        
        // テーブルビュー
        UITableView *tableView;
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, panelSize.width, panelSize.width, (panelSize.height - headSize.height)) style:UITableViewStylePlain];
        [self addSubview:tableView];
        [self setMenuTableView:tableView];
    }
    return self;
}

// 画像設定
- (void) bindImage:(UIImage *)imageValue
{
    [[self headImageView] setImage:imageValue];
}

// ヘッダ背景色設定
- (void) bindHeadBackgroundColor:(UIColor *)colorValue
{
    [[[self headView] callStyle] addStyleKey:@"background-color" value:[CCColor hexStringWithColor:colorValue]];
}

// テーブル背景色設定
- (void) bindTableViewBackgroundColor:(UIColor *)colorValue
{
    [[self menuTableView] setBackgroundColor:colorValue];
}

@end
