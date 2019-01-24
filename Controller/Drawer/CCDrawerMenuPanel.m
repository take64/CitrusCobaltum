//
//  CCDrawerMenuPanel.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCDrawerMenuPanel.h"

#import "CitrusCobaltumApplication.h"
#import "CCColor.h"
#import "CCStyle.h"
#import "CCTheme.h"
#import "CCView.h"

#import "CFNVL.h"

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
        [self setUserInteractionEnabled:YES];
        
        // パネルサイズ
        CGFloat panelWidth = frame.size.width;
        CGFloat panelHeight = frame.size.height;
        // テーマ
        CCThemeDrawerView *themeDrawerView = [[CitrusCobaltumApplication callTheme] callDrawerView];
        CCThemeTableView *themeTableView = [themeDrawerView callTableView];
        
        // ヘッダビュー
        CCView *view;
        view = [[CCView alloc] initWithFrame:CGRectMake(0, 0, panelWidth, panelWidth)];
        [[view callStyle] addStyleKey:@"background-color" value:[themeDrawerView callPanelBackgroundColor]];
        [self addSubview:view];
        [self setHeadView:view];
        
        // テーブルビュー
        UITableView *tableView;
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, panelWidth, panelWidth, (panelHeight - panelWidth)) style:UITableViewStylePlain];
        [tableView setBackgroundColor:[CCColor colorWithHEXString:[themeTableView callBackgroundColor]]];
        [tableView setSeparatorColor:[CCColor colorWithHEXString:[themeTableView callSeparatorColor]]];
        [self addSubview:tableView];
        [self setMenuTableView:tableView];
        
        // 初期画像設定
        [self bindImage:nil];
    }
    return self;
}

// 画像設定
- (void) bindImage:(UIImage *)imageValue
{
    // テーマ
    CCThemeDrawerView *themeDrawerView = [[CitrusCobaltumApplication callTheme] callDrawerView];
    imageValue = [CFNVL compare:imageValue replace:[themeDrawerView callPanelIconImage]];
    
    // 未生成なら生成
    if ([self headImageView] == nil)
    {
        // 画像ビュー
        UIImageView *imageView;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageSizeOneSide, kImageSizeOneSide)];
        [imageView setCenter:[[self headView] center]];
        [imageView setClipsToBounds:YES];
        [[imageView layer] setCornerRadius:8];
        [[self headView] addSubview:imageView];
        [self setHeadImageView:imageView];
    }
    
    // 画像設定
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
