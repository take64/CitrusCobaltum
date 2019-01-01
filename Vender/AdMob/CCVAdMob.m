//
//  CCVAdMob.m
//  CitrusCobaltum Vender Wrapper
//
//  Created by kouhei.takemoto on 2018/12/24.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCVAdMob.h"

#import "CFString.h"



@interface CCVAdMob()

#pragma mark - property
//
// property
//
@property NSString *adUnitID;
@property NSMutableDictionary *bannerStacks;

@end



@implementation CCVAdMob



//
// synthesize
//
@synthesize adUnitID;
@synthesize bannerStacks;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self setBannerStacks:[@{} mutableCopy]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// バナー広告生成
- (GADBannerView *) addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController
{
    // 取得
    GADBannerView *bannerView = [self callBannerID:bannerID];
    if (bannerView == nil)
    {
        // 生成
        bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, bannerSize.width, bannerSize.height)];
        [bannerView setAdUnitID:[self adUnitID]];
        [[self bannerStacks] setObject:bannerView forKey:bannerID];

        // コントローラー設定
        [bannerView setRootViewController:rootController];
    }
    return bannerView;
}

// バナー広告取得
- (GADBannerView *) callBannerID:(NSString *)bannerID
{
    return [[self bannerStacks] objectForKey:bannerID];
}

// バナー広告生成・取得
- (GADBannerView *) callBannerWithSection:(NSInteger)section rootController:(UIViewController<GADBannerViewDelegate> *)rootController
{
    // バナーIDの生成
    NSString *bannerID = CFStringf(@"%@_banner_%@_%ld", NSStringFromClass([rootController class]), @"320x50", (long)section);
    
    // ビュー取得
    GADBannerView *bannerView = [self callBannerID:bannerID];
    if (bannerView == nil)
    {
        // 生成
        bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        [bannerView setAdUnitID:[self adUnitID]];
        [bannerView setDelegate:rootController];
        [bannerView setRootViewController:rootController];
        
        GADRequest *request = [GADRequest request];
        [request setTestDevices:@[ kGADSimulatorID ]];
        [bannerView loadRequest:request];

        // スタック
        [[self bannerStacks] setObject:bannerView forKey:bannerID];
    }
    
    return bannerView;
}

// setup
- (void) setupAdUnitID:(NSString *)_adUnitID;
{
    [[CCVAdMob sharedService] setAdUnitID:_adUnitID];
}



#pragma mark - static singleton
//
// static singleton
//

// shared singleton
+ (instancetype) sharedService
{
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

@end
