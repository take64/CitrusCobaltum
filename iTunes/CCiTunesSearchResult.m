//
//  CCiTunesSearchResult.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCiTunesSearchResult.h"

#import "CFArray.h"
#import "CFDate.h"



@implementation CCiTunesSearchResult

#pragma mark - synthesize
//
// synthesize
//
@synthesize artistId;
@synthesize artistName;
@synthesize artistType;
@synthesize artistViewUrl;
@synthesize artworkUrlFormat;
@synthesize collectionArtistId;
@synthesize collectionArtistName;
@synthesize collectionArtistViewUrl;
@synthesize collectionCensoredName;
@synthesize collectionExplicitness;
@synthesize collectionId;
@synthesize collectionName;
@synthesize collectionPrice;
@synthesize collectionViewUrl;
@synthesize country;
@synthesize currency;
@synthesize discCount;
@synthesize discNumber;
@synthesize isStreamable;
@synthesize kind;
@synthesize previewUrl;
@synthesize primaryGenreId;
@synthesize primaryGenreName;
@synthesize releaseDate;
@synthesize trackCensoredName;
@synthesize trackCount;
@synthesize trackExplicitness;
@synthesize trackId;
@synthesize trackName;
@synthesize trackNumber;
@synthesize trackPrice;
@synthesize trackTimeMillis;
@synthesize trackViewUrl;
@synthesize wrapperType;
@synthesize contentAdvisoryRating;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithData:(NSDictionary *)dataValue
{
    self = [super init];
    if (self)
    {
        for (NSString *_key in [dataValue allKeys])
        {
            NSString *key = [_key copy];
            id val = [dataValue objectForKey:key];
            
            // 発売日をNSDateに
            if ([key isEqualToString:@"releaseDate"] == YES)
            {
                val = [CFDate dateWithString:val];
            }
            // アーティストURL
            else if ([key isEqualToString:@"artistLinkUrl"] == YES)
            {
                key = @"artistViewUrl";
            }
            // パッケージ画像
            else if ([key isEqualToString:@"artworkUrl30"] == YES)
            {
                key = @"artworkUrlFormat";
                val = [(NSString *)val stringByReplacingOccurrencesOfString:@"30x30" withString:@"%@x%@"];
            }
            // パッケージ画像スルー
            else if ([CFArray inString:key array:@[ @"artworkUrl60", @"artworkUrl100" ]] == YES)
            {
                continue;
            }

            // 設定
            [self setValue:val forKey:key];
        }
    }
    return self;
}

@end
