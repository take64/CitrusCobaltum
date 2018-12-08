//
//  CCDrawerViewController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/08/27.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCDrawerViewController.h"

#import "CCColor.h"
#import "CCDrawerMenuItem.h"
#import "CCDrawerMenuPanel.h"
#import "CCDrawerMenuSection.h"

static const CGFloat CCDrawerViewControllerMenuWidth = 256;
static CGFloat CCDrawerViewControllerMenuHeight()
{
    return CGRectGetHeight([[[[UIApplication sharedApplication] delegate] window] frame]);
}

@interface CCDrawerViewController ()

#pragma mark - property
//
// property
//

@property UIViewController *mainViewController;
@property NSArray<CCDrawerMenuSection *> *menuSections;
@property UIColor *tintColor;
@property UIColor *headColor;
@property UIColor *cellColor;
@property UIBarButtonItem *slideMenuButton;
@property BOOL menuVisible;
@property CCDrawerMenuPanel *menuPanel;


@end

@implementation CCDrawerViewController

#pragma mark - method
//
// method
//

// 初期化
- (instancetype) initWithController:(UIViewController *)controllerValue menuSections:(NSArray<CCDrawerMenuSection *> *)menuSectionList
{
    self = [super initWithRootViewController:controllerValue];
    if (self)
    {
        // メニュー設定
        [self setMenuSections:menuSectionList];
        
        // 初期化
        [self setMainViewController:controllerValue];
        
        // エッジジェスチャー
        [[self view] addGestureRecognizer:[self generateScreenEdgePanGesture]];
        
        // メニューアイコンボタン
        CTBarButtonItem *barButtonItem = [self generateMenuIconBarButton];
        [self setSlideMenuButton:barButtonItem];
        [[[self mainViewController] navigationItem] setLeftBarButtonItem:[self slideMenuButton]];
    }
    return self;
}

// 色設定
- (void)bindTintColor:(UIColor *)tintColorValue headColor:(UIColor *)headColorValue cellColor:(UIColor *)cellColorValue
{
    [self setTintColor:tintColorValue];
    [self setHeadColor:headColorValue];
    [self setCellColor:cellColorValue];
    
    [[self callMenuPanel] bindHeadBackgroundColor:[self callTintColor]];
    [[self callMenuPanel] bindTableViewBackgroundColor:[self callCellColor]];
}

// ヘッダイメージ
- (void)bindHeadImage:(UIImage *)imageValue
{
    [[self callMenuPanel] bindImage:imageValue];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) loadView
{
    [super loadView];
    
    // ビュー
    [[self view] addSubview:[self callMenuPanel]];
    
    // メニューを隠す
    [self setMenuVisible:YES];
    [self closeSlide];
    
    // 再読み込み
    [[self callMenuTableView] reloadData];
}



#pragma mark - UITableViewDataSource
//
// UITableViewDataSource
//

// セクション内セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[self menuSections] objectAtIndex:section] menuItems] count];
}

// セルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CellID";
    
    CTTableCellLabel *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil)
    {
        cell = [[CTTableCellLabel alloc] initWithPrefix:nil reuseIdentifier:CellID];
        [cell setBackgroundColor:[[CitrusTouchApplication callTheme] callDrawerCellBodyBackColor]];
        [[[cell label] callStyle] addStyles:@{
                                              @"font-size"  :@"14",
                                              @"color"      :[CTColor hexStringWithColor:[[CitrusTouchApplication callTheme] callDrawerCellBodyTextColor]],
                                              @"margin"     :@"0 0 0 8",
                                              }];
    }
    if (cell != nil)
    {
        CTDrawerMenuItem *menuItem = [[[[self menuSections] objectAtIndex:[indexPath section]] menuItems] objectAtIndex:[indexPath row]];
        [cell setContentText:[menuItem title]];
    }
    return cell;
}

// セクション数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self menuSections] count];
}

// セクションタイトル
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self menuSections] objectAtIndex:section] title];
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;



#pragma mark - UITableViewDelegate
//
// UITableViewDelegate
//

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    [view setTintColor:[self callHeadColor]];
//    [[(UITableViewHeaderFooterView *)view textLabel] setTextColor:[UIColor whiteColor]];
//}
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section;
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// セルヘッダ高さ
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableHeaderHeightWithController:self tableView:tableView section:section];
}
// セルフッタ高さ
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableFooterHeightWithController:self tableView:tableView section:section];
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section;
// セルヘッダを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableHeaderViewWithController:self tableView:tableView section:section];
}
// セルフッタを返す
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [CTTableViewTrait callTableFooterViewWithController:self tableView:tableView section:section];;
}
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
// セルタップ時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCDrawerMenuItem *menuItem = [[[[self menuSections] objectAtIndex:[indexPath section]] menuItems] objectAtIndex:[indexPath row]];
    [self changeViewController:[menuItem controller]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath;
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath;
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context;
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator;
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView;



#pragma mark - CTTableViewDelegate
//
// CTTableViewDelegate
//

// セルヘッダタイトル取得
- (NSString *)callHeaderTitleWithSection:(NSInteger)section
{
    return [[[self menuSections] objectAtIndex:section] title];
}

// セルフッタタイトル取得
- (NSString *)callFooterTitleWithSection:(NSInteger)section
{
    return @"";
}

// セルヘッダビュー取得
- (UIView *)callHeaderViewWithSection:(NSInteger)section
{
    return nil;
}

// セルフッタビュー取得
- (UIView *)callFooterViewWithSection:(NSInteger)section
{
    return nil;
}



#pragma mark - private
//
// private
//

// 色取得
- (UIColor *) callTintColor
{
    if ([self tintColor] == nil)
    {
        [self setTintColor:[CCColor colorWithHEXString:@"333333"]];
    }
    return [self tintColor];
}

// ヘッダ色取得
- (UIColor *) callHeadColor
{
    if ([self headColor] == nil)
    {
        [self setHeadColor:[CCColor colorWithHEXString:@"333333"]];
    }
    return [self headColor];
}

// セル取得
- (UIColor *) callCellColor
{
    if ([self cellColor] == nil)
    {
        [self setCellColor:[CCColor colorWithHEXString:@"CCCCCC"]];
    }
    return [self cellColor];
}

// メニューアイテム取得
- (CCDrawerMenuItem *) callMenuItemWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    return [[[[self menuSections] objectAtIndex:section] menuItems] objectAtIndex:row];
}

// スライド処理
- (void) slideMenu
{
    // メニューフレーム
    CGRect menuFrame = [[self callMenuPanel] frame];
    
    // メニュー隠し時
    menuFrame.origin.x = (CCDrawerViewControllerMenuWidth * -1);
    CGSize shadowOffset = CGSizeZero;
    CGFloat shadowRadius = 0;
    CGFloat shadowOpacity = 0;
    
    // メニューが表示されていない時
    if ([self menuVisible] == NO)
    {
        // メニューを表示させる
        menuFrame.origin.x = 0;
        shadowOffset = CGSizeMake(1, 1);
        shadowRadius = 5;
        shadowOpacity = 0.5;
    }
    
    // アニメーション処理
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        // アニメーション内容
        [[[self callMenuPanel] layer] setShadowOffset:shadowOffset];
        [[[self callMenuPanel] layer] setShadowRadius:shadowRadius];
        [[[self callMenuPanel] layer] setShadowOpacity:shadowOpacity];
        [[[self callMenuPanel] layer] setShadowColor:[[UIColor blackColor] CGColor]];
        [[[self callMenuPanel] layer] setShadowPath:[UIBezierPath bezierPathWithRect:[[self callMenuPanel] bounds]].CGPath];
        [[self callMenuPanel] setFrame:menuFrame];
    } completion:nil];
    
    // メニュー表示フラグ切り替え
    [self setMenuVisible:![self menuVisible]];
}

// スライドを開ける
- (void) openSlide
{
    if ([self menuVisible] == NO)
    {
        [self slideMenu];
    }
}
// スライドを閉じる
- (void) closeSlide
{
    if ([self menuVisible] == YES)
    {
        [self slideMenu];
    }
}

// メインビュー変更
- (void) changeViewController:(UIViewController *)viewController
{
    // メニュースライド
    [self slideMenu];
    
    // ビューが変わらなければ処理をしない
    if ([self topViewController] == viewController)
    {
        return;
    }
    
    // コントローラー入れ替え
    [[[self topViewController] view] removeFromSuperview];
    [self setViewControllers:@[ viewController ] animated:NO];
    
    // スライドボタンの移動
    [[[self topViewController] navigationItem] setLeftBarButtonItem:[self slideMenuButton]];
    [self setMenuVisible:NO];
}

// スワイプ処理
- (void) onSwipeMenuPanel:(UISwipeGestureRecognizer*) swipe
{
    UISwipeGestureRecognizerDirection direction = [swipe direction];
    
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if ([self menuVisible] == YES)
            {
                [self slideMenu];
            }
            break;
            
        default:
            break;
    }
}

// エッジジェスチャー処理
- (void)onScreenEdgeMenuPanel:(UIScreenEdgePanGestureRecognizer *) gesture
{
    [self openSlide];
}

// エッジジェスチャーの生成
- (UIScreenEdgePanGestureRecognizer *)generateScreenEdgePanGesture
{
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onScreenEdgeMenuPanel:)];
    [gesture setMinimumNumberOfTouches:1];
    [gesture setEdges:UIRectEdgeLeft];
    [gesture setDelegate:self];
    return gesture;
}

// メニューアイコンボタンの生成
- (CTBarButtonItem *)generateMenuIconBarButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [[[button widthAnchor] constraintEqualToConstant:32] setActive:YES];
    [[[button heightAnchor] constraintEqualToConstant:32] setActive:YES];
    [button setBackgroundImage:[[CitrusTouchApplication callTheme] callAppIconImage] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(slideMenu) forControlEvents:UIControlEventTouchUpInside];
    CTBarButtonItem *barButtonItem = [[CTBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}



#pragma mark - singleton
//
// singleton
//

// メニュービュー
- (UITableView *) callMenuTableView
{
    UITableView *menuTableView = [[self callMenuPanel] menuTableView];
    if ([menuTableView delegate] == nil || [menuTableView dataSource] == nil)
    {
        [menuTableView setDataSource:self];
        [menuTableView setDelegate:self];
    }
    return menuTableView;
}

// メニューヘッダ
- (CCDrawerMenuPanel *) callMenuPanel
{
    if ([self menuPanel] == nil)
    {
        // 生成
        [self setMenuPanel:[[CCDrawerMenuPanel alloc] initWithFrame:CGRectMake((CCDrawerViewControllerMenuWidth * -1), 0, CCDrawerViewControllerMenuWidth, CCDrawerViewControllerMenuHeight())]];
        
        // スワイプイベント
        UISwipeGestureRecognizer *swipe;
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeMenuPanel:)];
        [swipe setNumberOfTouchesRequired:1];
        [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [[[self menuPanel] headView] addGestureRecognizer:swipe];
    }
    return [self menuPanel];
}

@end
