//
//  CCTableCellDatePicker.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/10.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCellTextField.h"


@interface CCTableCellDatePicker : CCTableCellTextField

//
// propery
//
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;



//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString content:(NSDate *)dateValue suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 設定(ピッカーモード)
- (void) changePickerMode:(CCTableCellDatePickerMode)_pickerModeValue;

// 取得(日付)
- (NSDate *) date;

// 設定(日付)
- (void) setDate:(NSDate *)dateValue;

@end
