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

@interface CCTableCell : UITableViewCell
{
    // entity
    NSManagedObject *entity;
    
    // object
    NSObject *object;
    
    // レイアウト済み
    BOOL layouted;
    // サブクラスレイアウト済み
    BOOL subLayouted;
    
    // 背景ビュー
    CCControl *bgView;
}

//
// property
//
@property (nonatomic, retain) NSManagedObject *entity;
@property (nonatomic, retain) NSObject *object;
@property (nonatomic, assign, getter = isLayouted) BOOL layouted;
@property (nonatomic, assign, getter = isSubLayouted) BOOL subLayouted;
@property (nonatomic, retain) CCControl *bgView;


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

@end
