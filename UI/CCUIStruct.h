//
//  CCUIStruct.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/30.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CCUIStruct_h
#define CCUIStruct_h

// 色構造体
typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} CCColorStruct;

bool CCColorStructIsNull(CCColorStruct value) {
    return (value.red == 1 && value.green == 1 && value.blue == 1 && value.alpha == 1);
}

// オフセット構造体
typedef struct {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} CCOffset;

bool CCOffsetIsNull(CCOffset value) {
    return (value.top == 0 && value.right == 0 && value.bottom == 0 && value.left == 0);
}

// マージン構造体
typedef CCOffset CCMargin;

// パッディング構造体
typedef CCOffset CCPadding;

// 水平構造体
typedef struct {
    CGFloat left;
    CGFloat right;
} CCHorizontal;

bool CCHorizontalIsNull(CCHorizontal value) {
    return (value.left == 0 && value.right == 0);
}

// 角丸構造体
typedef struct {
    CCHorizontal top;
    CCHorizontal bottom;
} CCRadius;

bool CCRadiusIsNull(CCRadius value) {
    return (CCHorizontalIsNull(value.top) == true && CCHorizontalIsNull(value.bottom) == true);
}

// 影構造体
typedef struct {
    CGFloat horizontal;
    CGFloat vertical;
    CGFloat shading;
    CCColorStruct color;
} CCShadow;

bool CCShadowIsNull(CCShadow value) {
    return (value.horizontal == 0 && value.vertical == 0 && value.shading == 0 && CCColorStructIsNull(value.color) == true);
}

// 縦位置
typedef NS_ENUM(NSInteger, CCVerticalAlignment)
{
    CCVerticalAlignmentTop,
    CCVerticalAlignmentMiddle,
    CCVerticalAlignmentBottom
};

// テーブルセルの表示優先順
typedef NS_ENUM(NSInteger, CCTableCellPartPriority) {
    CCTableCellPartPriorityHidden,  // 非表示
    CCTableCellPartPriorityHigh,    // 高
    CCTableCellPartPriorityMiddle,  // 中
    CCTableCellPartPriorityLow      // 低
};

// テーブルセルの表示場所
typedef NS_ENUM(NSInteger, CCTableCellPartPosition) {
    CCTableCellPartPositionPrefix,  // prefix
    CCTableCellPartPositionContent, // content
    CCTableCellPartPositionSuffix,  // suffix
};

// テーブルセル日付ピッカーのモード
typedef NS_ENUM(NSInteger, CCTableCellDatePickerMode) {
    CCTableCellDatePickerModeNone,
    CCTableCellDatePickerModeStandard,
    CCTableCellDatePickerModeDate,
};

// 全部の自動リサイズマスク
UIViewAutoresizing CCViewAutoresizingMaskAll() {
    return (UIViewAutoresizingFlexibleLeftMargin    |
            UIViewAutoresizingFlexibleRightMargin   |
            UIViewAutoresizingFlexibleTopMargin     |
            UIViewAutoresizingFlexibleBottomMargin  |
            UIViewAutoresizingFlexibleWidth         |
            UIViewAutoresizingFlexibleHeight);
}

// スペース用バーボタンアイテム
UIBarButtonItem * CCBarButtonItemSpacer() {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

// 汎用ブロック
typedef void (^CitrusCobaltumBlock)(void);

// ボタンタップ用のブロック
@class CCButton;
typedef void (^CCButtonTappedBlock)(CCButton *buttonValue);

// Switch用ブロック
typedef void (^CitrusCobaltumSwitchBlock)(NSNumber *switchValue);

#endif /* CCUIStruct_h */
