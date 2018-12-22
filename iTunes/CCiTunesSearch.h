//
//  CCiTunesSearch.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCiTunesSearchResult;

typedef void (^CitrusCobaltumiTunesSearchBlock)(NSArray<CCiTunesSearchResult *> *results, NSError *error);

@interface CCiTunesSearch : NSObject

//
// static method
//

// 音楽検索
+ (void) searchMusicWithKeyword:(NSString *)keyword complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete;

// 楽曲IDから楽曲取得
+ (void) lookupMusicWithTrackID:(NSString *)trackID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete;

// アーティストIDから楽曲取得
+ (void) lookupMusicWithArtistID:(NSString *)artistID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete;

// アーティストIDからアーティスト取得
+ (void) lookupArtistWithArtistID:(NSString *)artistID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete;

@end
