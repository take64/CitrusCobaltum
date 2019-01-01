//
//  CCBaseViewController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseViewController.h"



@interface CCBaseViewController ()

@end



@implementation CCBaseViewController

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // タイトル
        [self setTitle:[self callTitle]];
    }
    return self;
}

// タイトル取得
- (NSString *) callTitle
{
    return @"";
}

@end
