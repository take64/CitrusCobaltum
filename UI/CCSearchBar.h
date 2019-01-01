//
//  CCSearchBar.h
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CitrusCobaltumSearchBarBlock)(NSString *keyword);

@interface CCSearchBar : UISearchBar <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//
// property
//

@property (nonatomic, copy) CitrusCobaltumSearchBarBlock suggestBlock;
@property (nonatomic, copy) CitrusCobaltumSearchBarBlock searchBlock;



//
// method
//

// 検索結果表示
- (void) showKeywords:(NSArray<NSString *> *)suggestList;

// 検索結果非表示
- (void) hideKeywords;

@end
