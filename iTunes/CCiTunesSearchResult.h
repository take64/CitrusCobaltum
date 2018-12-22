//
//  CCiTunesSearchResult.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/22.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CFElement.h"

@interface CCiTunesSearchResult : CFElement

//
// property
//
@property (nonatomic, retain) NSNumber *artistId;
@property (nonatomic, retain) NSString *artistName;
@property (nonatomic, retain) NSString *artistType;
@property (nonatomic, retain) NSString *artistViewUrl;
@property (nonatomic, retain) NSString *artworkUrl100;
@property (nonatomic, retain) NSString *artworkUrl30;
@property (nonatomic, retain) NSString *artworkUrl60;
@property (nonatomic, retain) NSString *collectionArtistId;
@property (nonatomic, retain) NSString *collectionArtistName;
@property (nonatomic, retain) NSString *collectionArtistViewUrl;
@property (nonatomic, retain) NSString *collectionCensoredName;
@property (nonatomic, retain) NSString *collectionExplicitness;
@property (nonatomic, retain) NSNumber *collectionId;
@property (nonatomic, retain) NSString *collectionName;
@property (nonatomic, retain) NSDecimalNumber *collectionPrice;
@property (nonatomic, retain) NSString *collectionViewUrl;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *currency;
@property (nonatomic, retain) NSNumber *discCount;
@property (nonatomic, retain) NSNumber *discNumber;
@property (nonatomic, retain) NSNumber *isStreamable;
@property (nonatomic, retain) NSString *kind;
@property (nonatomic, retain) NSString *previewUrl;
@property (nonatomic, retain) NSNumber *primaryGenreId;
@property (nonatomic, retain) NSString *primaryGenreName;
@property (nonatomic, retain) NSDate *releaseDate;
@property (nonatomic, retain) NSString *trackCensoredName;
@property (nonatomic, retain) NSNumber *trackCount;
@property (nonatomic, retain) NSString *trackExplicitness;
@property (nonatomic, retain) NSNumber *trackId;
@property (nonatomic, retain) NSString *trackName;
@property (nonatomic, retain) NSNumber *trackNumber;
@property (nonatomic, retain) NSDecimalNumber *trackPrice;
@property (nonatomic, retain) NSNumber *trackTimeMillis;
@property (nonatomic, retain) NSString *trackViewUrl;
@property (nonatomic, retain) NSString *wrapperType;
@property (nonatomic, retain) NSString *contentAdvisoryRating;



//
// method
//

// 初期化
- (instancetype) initWithData:(NSDictionary *)dataValue;

@end

