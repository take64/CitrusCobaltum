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

@end
