//
//  CCChartData.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/26.
//  Copyright © 2019 citrus.tk. All rights reserved.
//

#import "CCChartData.h"



@interface CCChartData()

@end



@implementation CCChartData

#pragma mark - synthesize
//
// synthesize
//
@synthesize color;
@synthesize title;
@synthesize value;



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithTitle:(NSString *)title value:(NSNumber *)value
{
    return [self initWithTitle:title value:value color:nil];
}

// 初期化
- (instancetype) initWithTitle:(NSString *)title value:(NSNumber *)value color:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        [self setTitle:title];
        [self setValue:value];
        [self setColor:color];
        
    }
    return self;
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"title = %@; value = %@; color = %@",
//            [self title],
//            [self value],
//            [[self color] st]
//            ];
//}

@end
