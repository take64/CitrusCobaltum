//
//  CCVAdMob.h
//  CitrusCobaltum Vender Wrapper
//
//  Created by kouhei.takemoto on 2018/12/24.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GoogleMobileAds/GoogleMobileAds.h>

@interface CCVAdMob : NSObject

//
// method
//

// バナー広告生成
- (GADBannerView *) addBannerID:(NSString *)bannerID size:(CGSize)bannerSize rootController:(UIViewController *)rootController;

// バナー広告取得
- (GADBannerView *) callBannerID:(NSString *)bannerID;

// バナー広告生成・取得
- (GADBannerView *) callBannerWithSection:(NSInteger)section rootController:(UIViewController<GADBannerViewDelegate> *)rootController;

// setup
- (void) setupAdUnitID:(NSString *)_adUnitID;



//
// static singleton
//

// singleton
+ (instancetype) sharedService;

@end
