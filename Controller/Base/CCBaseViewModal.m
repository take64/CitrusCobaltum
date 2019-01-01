//
//  CCBaseViewModal.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBaseViewModal.h"

#import "CCBarButtonItem.h"
#import "CCBasePresentationController.h"
#import "CCNavigationController.h"



@interface CCBaseViewModal ()

#pragma mark - property
//
// property
//
@property CCNavigationController *_navigationController;
@property CitrusCobaltumModalBlock modalComplete;

@end



@implementation CCBaseViewModal

#pragma mark - extends
//
// extends
//

// init
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // modal style
        [self setModalPresentationStyle:UIModalPresentationPageSheet];
        
        // バーボタン(閉じる)
        CCBarButtonItem *barButtonItem = [[CCBarButtonItem alloc] initWithTitle:@"閉じる" style:UIBarButtonItemStyleDone target:self action:@selector(onTapBarButtonClose)];
        [[self navigationItem] setLeftBarButtonItems:@[ barButtonItem ]];
    }
    return self;
}



#pragma mark - method
//
// method
//

// 表示
- (void) showWithParent:(UIViewController *)parent
{
    if (parent == nil)
    {
        return;
    }
    
    CCBasePresentationController *presentation NS_VALID_UNTIL_END_OF_SCOPE;
    presentation = [[CCBasePresentationController alloc] initWithPresentedViewController:[self callNavigationController] presentingViewController:parent];
    [[self callNavigationController] setTransitioningDelegate:presentation];
    [parent presentViewController:[self callNavigationController] animated:YES completion:nil];
}

// 表示
- (void) showWithParent:(UIViewController *)parent complete:(CitrusCobaltumModalBlock)completeBlock
{
    // 画面閉じ完了
    [self setModalComplete:completeBlock];
    // 表示
    [self showWithParent:parent];
}

// 非表示
- (void) hide
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        // 画面閉じ完了がある場合
        if (self.modalComplete != nil)
        {
            self.modalComplete(self);
        }
    }];
}



#pragma mark - private
//
// private
//

// ボタン押下時(閉じる)
- (void)onTapBarButtonClose
{
    [self hide];
}



#pragma mark - singleton
//
// singleton
//

// call navigation controller
- (CCNavigationController *) callNavigationController
{
    if ([self _navigationController] == nil)
    {
        CCNavigationController *navigation = [[CCNavigationController alloc] initWithRootViewController:self];
        [navigation setTransitioningDelegate:self];
        [self set_navigationController:navigation];
    }
    return [self _navigationController];
}



#pragma mark - UIViewControllerTransitioningDelegate
//
// UIViewControllerTransitioningDelegate
//

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CCBasePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
