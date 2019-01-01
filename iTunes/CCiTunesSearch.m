//
//  CCiTunesSearch.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCiTunesSearch.h"

#import "CCiTunesSearchResult.h"

#import "CFHttpRequest.h"

static NSString * const kiTunesSearchURL = @"https://itunes.apple.com/search";
static NSString * const kiTunesLookupURL = @"https://itunes.apple.com/lookup";



@implementation CCiTunesSearch

#pragma mark - static method
//
// static method
//

// 音楽検索
+ (void) searchMusicWithKeyword:(NSString *)keyword complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete
{
    [CFHttpRequest getRequest:kiTunesSearchURL parameters:@{ @"term":keyword, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200", @"media":@"music" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [@[] mutableCopy];
        for (NSDictionary *one in list[@"results"])
        {
            if ([[one objectForKey:@"kind"] isEqualToString:@"song"] == YES)
            {
                [results addObject:[[CCiTunesSearchResult alloc] initWithData:one]];
            }
        }
        complete([results copy], error);
    }];
}

// 楽曲取得
+ (void) lookupMusicWithTrackID:(NSString *)trackID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete
{
    [CFHttpRequest getRequest:kiTunesLookupURL parameters:@{ @"id":trackID, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [@[] mutableCopy];
        for (NSDictionary *one in list[@"results"])
        {
            if ([[one objectForKey:@"kind"] isEqualToString:@"song"] == YES)
            {
                [results addObject:[[CCiTunesSearchResult alloc] initWithData:one]];
            }
        }
        if (complete != nil)
        {
            complete([results copy], error);
        }
    }];
}

// アーティストから楽曲検索
+ (void) lookupMusicWithArtistID:(NSString *)artistID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete
{
    [CFHttpRequest getRequest:kiTunesLookupURL parameters:@{ @"id":artistID, @"entity":@"song", @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [@[] mutableCopy];
        for (NSDictionary *one in list[@"results"])
        {
            if ([[one objectForKey:@"kind"] isEqualToString:@"song"] == YES)
            {
                [results addObject:[[CCiTunesSearchResult alloc] initWithData:one]];
            }
        }
        complete([results copy], error);
    }];
}

// アーティストIDからアーティスト取得
+ (void) lookupArtistWithArtistID:(NSString *)artistID complete:(CitrusCobaltumiTunesSearchBlock __nonnull)complete
{
    [CFHttpRequest getRequest:kiTunesLookupURL parameters:@{ @"id":artistID, @"country":@"JP", @"lang":@"ja_jp", @"limit":@"200" } complete:^(id userInfo, NSError *error) {
        NSDictionary *list = [NSJSONSerialization JSONObjectWithData:userInfo options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *results = [@[] mutableCopy];
        for (NSDictionary *one in list[@"results"])
        {
            [results addObject:[[CCiTunesSearchResult alloc] initWithData:one]];
        }
        complete([results copy], error);
    }];
}

@end
