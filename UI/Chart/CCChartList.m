//
//  CCChartList.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCChartList.h"

#import "CCChartData.h"



@interface CCChartList()

@end



@implementation CCChartList

#pragma mark - synthesize
//
// synthesize
//
@synthesize maxValue;
@synthesize minValue;
@synthesize color;
@synthesize dataList;
@synthesize title;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)title values:(NSArray<CCChartData *> *)dataValues
{
    self = [super init];
    if (self)
    {
        [self setTitle:title];
        [self setDataList:dataValues];
    }
    return self;
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"title = %@; data = %@",
//            [self title] ,
//            [self dataList]
//            ];
//}

@end
