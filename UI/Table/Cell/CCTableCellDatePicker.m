//
//  CCTableCellDatePicker.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellDatePicker.h"

#import "CCButton.h"
#import "CCColor.h"
#import "CCPlatformDevice.h"
#import "CCStyle.h"
#import "CCTableCellTextFieldInnerTextField.h"
#import "CFDate.h"



@interface CCTableCellDatePicker()

#pragma mark - property
//
// property
//
@property CCTableCellDatePickerMode pickerMode;
@property UIView *inputPackingView;

@end



@implementation CCTableCellDatePicker

#pragma mark - synthesize
//
// synthesize
//
@synthesize datePicker;
@synthesize dateFormatter;



#pragma mark - extends
//
// extends
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGFloat datePickerHeight = 216;
        
        // ピッカー
        [self setDatePicker:[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, datePickerHeight)]];
        [[self datePicker] addTarget:self action:@selector(onChangeDate:) forControlEvents:UIControlEventValueChanged];
        
        // フォーマッター
        [self setDateFormatter:[[NSDateFormatter alloc] init]];
        [[self dateFormatter] setLocale:[NSLocale currentLocale]];
        
        // テキストフィールド
        [[self innerTextField] setEnableMenu:NO];
        [[self innerTextField] setClearButtonMode:UITextFieldViewModeNever];
        
        // パッキングビュー
        CGFloat width = ([CCPlatformDevice isIPad] == YES ? 1024 : 320);
        [self setInputPackingView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, datePickerHeight)]];
        [[self inputPackingView] setBackgroundColor:[CCColor colorWithHEXString:@"999999"]];
        
        // ピッカーモード
        [self changePickerMode:CCTableCellDatePickerModeNone];
        
        // 配置
        [[self innerTextField] setInputView:[self inputPackingView]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSDate *)dateValue suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithPrefix:prefixString suffix:suffixString reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [[self datePicker] setDate:dateValue];
    }
    return self;
}

// 変更(ピッカーモード)
- (void) changePickerMode:(CCTableCellDatePickerMode)pickerModeValue
{
    // 設定
    [self setPickerMode:pickerModeValue];
    
    // ヘッダがある
    BOOL hasHeader = NO;
    
    // ピッカーモードなし
    if (pickerModeValue == CCTableCellDatePickerModeNone)
    {
        [self changePickerModeNone];
    }
    // ピッカーモードスタンダード
    else if (pickerModeValue == CCTableCellDatePickerModeStandard)
    {
        [self changePickerModeStandard];
        hasHeader = YES;
    }
    // ピッカーモード日付
    else if (pickerModeValue == CCTableCellDatePickerModeDate)
    {
        [self changePickerModeDate];
        hasHeader = YES;
    }
    
    // オフセット
    CGFloat offsetY = 0;
    CGFloat heightPicker = 216;
    CGFloat heightPackingView = 216;
    if (hasHeader == YES)
    {
        offsetY = 32;
        heightPackingView = heightPicker + offsetY;
    }
    
    // 位置変更
    [[self datePicker] setFrame:CGRectMake(0, offsetY, 320, heightPicker)];
    CGPoint center = [[self inputPackingView] center];
    center.y += offsetY;
    [[self datePicker] setCenter:[[self inputPackingView] center]];
    
    // パッキングビュー
    [[self inputPackingView] setFrame:CGRectMake(0, 0, 320, heightPackingView)];
    [[self inputPackingView] addSubview:[self datePicker]];
}

// 取得(日付)
- (NSDate *) date
{
    // 日付
    NSDate *result = [[self datePicker] date];
    
    // 日付モードの時は時間を切る
    if ([self pickerMode] == CCTableCellDatePickerModeDate)
    {
        result = [CFDate dateRemoveHHIISSWithDate:result];
    }
    
    return result;
}

// 設定(日付)
- (void) setDate:(NSDate *)dateValue
{
    if ([dateValue isEqual:[NSNull null]] == YES)
    {
        [self setContentText:@""];
        return ;
    }
    
    [[self datePicker] setDate:dateValue];
    
    if ([self dateFormatter] != nil)
    {
        [self setContentText:[[self dateFormatter] stringFromDate:dateValue]];
    }
    else
    {
        [self setContentText:[dateValue description]];
    }
}



#pragma mark - private
//
// private
//

// 値変更
- (void) onChangeDate:(UIDatePicker *)datePickerValue
{
    [self setDate:[datePickerValue date]];
}

// ボタン押下時(ショートカット)
- (void) onTapButtonShortcut:(CCButton *)buttonValue
{
    NSString *timeString = [[buttonValue userInfo] objectForKey:@"time"];
    NSInteger hour = 0;
    NSInteger minute = 0;
    
    if ([timeString isEqual:[NSNull null]] == YES)
    {
        NSDateComponents *workComponents = [CFDate componentsWithDate:[NSDate date]];
        hour = [workComponents hour];
        minute = [workComponents minute];
    }
    else
    {
        NSArray *timeArray = [timeString componentsSeparatedByString:@":"];
        hour = [[timeArray objectAtIndex:0] integerValue];
        minute = [[timeArray objectAtIndex:1] integerValue];
    }
    
    NSDateComponents *components = [CFDate componentsWithDate:[self date]];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:0];
    [self setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
    [[self datePicker] sendActionsForControlEvents:UIControlEventValueChanged];
}

// ピッカーモード変更(指定なし)
- (void) changePickerModeNone
{
    // 一旦外し
    for (UIView *childView in [[self inputPackingView] subviews])
    {
        if ([childView respondsToSelector:@selector(removeFromSuperview)] == YES)
        {
            [childView removeFromSuperview];
        }
    }
}

// ピッカーモード変更(標準)
- (void) changePickerModeStandard
{
    // ボタンスタイル
    NSDictionary *buttonStyleKeys = @{
                                      @"top"                :@"0",
                                      @"height"             :@"32",
                                      @"font-size"          :@"16",
                                      @"color"              :@"333333",
                                      @"background-color"   :@"FFFFFF",
                                      @"background-image"   :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.75) 0.05, rgba(0.80, 0.80, 0.80, 0.80) 1.00)",
                                      };
    NSDictionary *buttonStyleHighlighedKeys = @{
                                                @"background-image" :@"linear-gradient(rgba(1.00, 1.00, 1.00, 0.75) 0.00, rgba(0.75, 0.75, 0.75, 0.75) 0.05, rgba(0.80, 0.80, 0.80, 0.80) 1.00)",
                                                };
    
    NSArray *buttonProperties = @[
                                  @{@"title"    :@"06:00",
                                    @"time"     :@"06:00",
                                    @"width"    :@"51",
                                    @"left"     :@"0",
                                    },
                                  @{@"title"    :@"09:00",
                                    @"time"     :@"09:00",
                                    @"width"    :@"51",
                                    @"left"     :@"52",
                                    },
                                  @{@"title"    :@"12:00",
                                    @"time"     :@"12:00",
                                    @"width"    :@"51",
                                    @"left"     :@"104",
                                    },
                                  @{@"title"    :@"18:00",
                                    @"time"     :@"18:00",
                                    @"width"    :@"51",
                                    @"left"     :@"156",
                                    },
                                  @{@"title"    :@"21:00",
                                    @"time"     :@"21:00",
                                    @"width"    :@"51",
                                    @"left"     :@"208",
                                    },
                                  @{@"title"    :@"現時刻",
                                    @"time"     :[NSNull null],
                                    @"width"    :@"60",
                                    @"left"     :@"260",
                                    },
                                  ];
    
    for (NSDictionary *buttonProperty in buttonProperties)
    {
        CGFloat left = [[buttonProperty objectForKey:@"left"] floatValue];
        if ([CCPlatformDevice isIPad] == YES)
        {
            left += ((1024 - 320) / 2);
        }
        CCButton *buttonTime = [[CCButton alloc] initWithTitle:[buttonProperty objectForKey:@"title"] styleKeys:buttonStyleKeys];
        [[buttonTime callStyle] addStyleKeys:@{
                                               @"left"  :CCStr(left),
                                               @"width" :[buttonProperty objectForKey:@"width"],
                                               }];
        [[buttonTime callStyleHighlighted] addStyleKeys:buttonStyleHighlighedKeys];
        [buttonTime setUserInfo:[ @{ @"time" :[buttonProperty objectForKey:@"time"] } mutableCopy]];
        [buttonTime addTarget:self action:@selector(onTapButtonShortcut:) forControlEvents:UIControlEventTouchUpInside];
        [[self inputPackingView] addSubview:buttonTime];
    }
}

// ピッカーモード変更(日付)
- (void) changePickerModeDate
{
    // 日付モード
    [[self datePicker] setDatePickerMode:UIDatePickerModeDate];
}

@end
