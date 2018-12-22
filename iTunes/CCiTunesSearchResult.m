//
//  CCiTunesSearchResult.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCiTunesSearchResult.h"



@implementation CCiTunesSearchResult

#pragma mark - synthesize
//
// synthesize
//
@synthesize artistId;
@synthesize artistName;
@synthesize artistType;
@synthesize artistViewUrl;
@synthesize artworkUrl100;
@synthesize artworkUrl30;
@synthesize artworkUrl60;
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
        for (NSString *key in [dataValue allKeys])
        {
            id val = [dataValue objectForKey:key];
            
            if ([key isEqualToString:@"releaseDate"] == YES)
            {
                [self setValue:[CTDate dateWithString:val] forKey:key];
            }
            else if ([key isEqualToString:@"artistLinkUrl"] == YES)
            {
                [self setValue:val forKey:@"artistViewUrl"];
            }
            else
            {
                [self setValue:val forKey:key];
            }
        }
    }
    return self;
}

@end
