//
//  CCTableCellImage.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/28.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCTableCell.h"

@interface CCTableCellImage : CCTableCell

//
// method
//

// 初期化
- (instancetype) initWithImageFrame:(CGRect)imageFrame reuseIdentifier:(NSString *)reuseIdentifier;

// 画像設定
- (void) bindImageData:(NSData *)dataValue;

@end
