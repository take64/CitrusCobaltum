//
//  CCTableCell.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/09.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "CCUIStruct.h"

@class CCControl;
@class CCLabel;

@interface CCTableCell : UITableViewCell

//
// property
//

@property (nonatomic, assign) CCTableCellPartPriority prefixPriority;
@property (nonatomic, assign) CCTableCellPartPriority contentPriority;
@property (nonatomic, assign) CCTableCellPartPriority suffixPriority;
@property (nonatomic, retain) NSManagedObject *entity;                  // entity
@property (nonatomic, retain) NSObject *object;                         // object
@property (nonatomic, retain) CCLabel *prefixLabel;                     // prefix label
@property (nonatomic, retain) CCLabel *suffixLabel;                     // suffix label
@property (nonatomic, assign, getter = isLayouted) BOOL layouted;       // レイアウト済み
@property (nonatomic, assign, getter = isSubLayouted) BOOL subLayouted; // サブクラスレイアウト済み
@property (nonatomic, retain) CCControl *bgView;                        // 背景ビュー
@property (nonatomic, assign) CGRect contentFrame;                      // コンテンツサイズ



//
// method
//

// 初期化
- (instancetype) initWithPrefix:(NSString *)prefixString suffix:(NSString *)suffixString reuseIdentifier:(NSString *)reuseIdentifier;

// 優先度設定
- (void) priorityPrefix:(CCTableCellPartPriority)prefix content:(CCTableCellPartPriority)content suffix:(CCTableCellPartPriority)suffix;

// bind entity
- (void) bindEntity:(NSManagedObject *)entityValue;

// bind object
- (void) bindObject:(NSObject *)objectValue;

// テキスト取得
- (NSString *) contentText;

// テキスト設定
- (void) setContentText:(NSString *)stringValue;

@end
