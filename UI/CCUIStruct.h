//
//  CCUIStruct.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/30.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#ifndef CCUIStruct_h
#define CCUIStruct_h

#if !defined(CC_INLINE)
# if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
#  define CC_INLINE static inline
# elif defined(__cplusplus)
#  define CC_INLINE static inline
# elif defined(__GNUC__)
#  define CC_INLINE static __inline__
# else
#  define CC_INLINE static
# endif
#endif

// 色構造体
typedef struct {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} CCColorStruct;

CC_INLINE bool CCColorStructIsNull(CCColorStruct value) {
    return (value.red == 0 && value.green == 0 && value.blue == 0 && value.alpha == 0);
}

// オフセット構造体
typedef struct {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
} CCOffset;

CC_INLINE bool CCOffsetIsNull(CCOffset value) {
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

CC_INLINE bool CCHorizontalIsNull(CCHorizontal value) {
    return (value.left == 0 && value.right == 0);
}

// 角丸構造体
typedef struct {
    CCHorizontal top;
    CCHorizontal bottom;
} CCRadius;

CC_INLINE bool CCRadiusIsNull(CCRadius value) {
    return (CCHorizontalIsNull(value.top) == true && CCHorizontalIsNull(value.bottom) == true);
}

// 影構造体
typedef struct {
    CGFloat horizontal;
    CGFloat vertical;
    CGFloat shading;
    CCColorStruct color;
} CCShadow;

CC_INLINE bool CCShadowIsNull(CCShadow value) {
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
CC_INLINE UIViewAutoresizing CCViewAutoresizingMaskAll() {
    return (UIViewAutoresizingFlexibleLeftMargin    |
            UIViewAutoresizingFlexibleRightMargin   |
            UIViewAutoresizingFlexibleTopMargin     |
            UIViewAutoresizingFlexibleBottomMargin  |
            UIViewAutoresizingFlexibleWidth         |
            UIViewAutoresizingFlexibleHeight);
}

// スペース用バーボタンアイテム
CC_INLINE UIBarButtonItem * CCBarButtonItemSpacer() {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}


// ボタンタップ用のブロック
@class CCButton;
typedef void (^CCButtonTappedBlock)(CCButton *buttonValue);

// Switch用ブロック
typedef void (^CitrusCobaltumSwitchBlock)(NSNumber *switchValue);

#endif /* CCUIStruct_h */
