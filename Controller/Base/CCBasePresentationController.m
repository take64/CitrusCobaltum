//
//  CTBasePresentationController.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2018/12/16.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCBasePresentationController.h"

@interface CCBasePresentationController()

#pragma mark - property
//
// property
//
@property UIView *shadowView;
@property UIView *wrappingView;

@end



@implementation CCBasePresentationController

#pragma mark - extends
//
// extends
//

// init
- (instancetype) initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self)
    {
        // style
        [presentedViewController setModalPresentationStyle:UIModalPresentationCustom];
    }
    return self;
}

- (void) presentationTransitionWillBegin
{
    // ラッピングビュー
    [self callWrapperView];
    
    // 背景(影)ビュー
    [[self containerView] addSubview:[self callShadowView]];
}

// 画面閉じ時(閉じる前)
- (void) dismissalTransitionWillBegin
{
    [[[self presentingViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
        [[self callShadowView] setAlpha:0];
    } completion:nil];
}

- (void) preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == [self presentedViewController])
    {
        [[self containerView] setNeedsLayout];
    }
}

// コンテナサイズ
- (CGSize) sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
    {
        return [((UIViewController*)container) preferredContentSize];
    }
    else
    {
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }
}

// モーダルビューサイズ
- (CGRect) frameOfPresentedViewInContainerView
{
    CGFloat insetHeight = 40;
    CGRect rect = CGRectInset([[self containerView] bounds], 0, insetHeight);
    rect.size.height += insetHeight;
    
    return rect;
}

// コンテナレイアウト
- (void) containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    [[self callWrapperView] setFrame:[self frameOfPresentedViewInContainerView]];
}



#pragma mark - private
//
// private
//

// 背景(影)ビュー
- (UIView *)callShadowView
{
    if ([self shadowView] == nil)
    {
        UIView *_view = [[UIView alloc] initWithFrame:[[self containerView] bounds]];
        [_view setBackgroundColor:[UIColor blackColor]];
        [_view setOpaque:NO];
        [_view setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [_view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapViewShadow)]];
        [_view setAlpha:0];
        [self setShadowView:_view];
        
        // animation
        [[[self presentingViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            [[self callShadowView] setAlpha:0.5];
        } completion:nil];
    }
    return [self shadowView];
}

// ラッピングビュー
- (UIView *) callWrapperView
{
    if ([self wrappingView] == nil)
    {
        UIView *presentedViewControllerView = [super presentedView];
        [[presentedViewControllerView layer] setCornerRadius:4];
        [[presentedViewControllerView layer] setMasksToBounds:YES];
        
        UIView *_view = [[UIView alloc] initWithFrame:[self frameOfPresentedViewInContainerView]];
        [[_view layer] setShadowOpacity:0.5];
        [[_view layer] setShadowRadius:2];
        [[_view layer] setShadowOffset:CGSizeMake(0, -2)];
        [_view addSubview:presentedViewControllerView];
        [self setWrappingView:_view];
    }
    return [self wrappingView];
}

// ビュー押下時(影ビュー)
- (void) onTapViewShadow
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UIViewControllerAnimatedTransitioning
//
// UIViewControllerAnimatedTransitioning
//

// アニメーション時間
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ([transitionContext isAnimated] == YES) ? 0.25 : 0;
}

// アニメーション処理
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    BOOL isPresenting = (fromViewController == [self presentingViewController]);
    
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toView];
    
    if (isPresenting == YES)
    {
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX([containerView bounds]), CGRectGetMaxY([containerView bounds]));
        toViewInitialFrame.size = toViewFinalFrame.size;
        [toView setFrame:toViewInitialFrame];
    }
    else
    {
        fromViewFinalFrame = CGRectOffset([fromView frame], 0, CGRectGetHeight(fromView.frame));
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        if (isPresenting == YES)
        {
            [toView setFrame:toViewFinalFrame];
        }
        else
        {
            [fromView setFrame:fromViewFinalFrame];
        }
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:(wasCancelled == NO)];
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate
//
// UIViewControllerTransitioningDelegate
//

// 提示されたView ControllerのmodalPresentationStyleが UIModalPresentationCustomでは、プレゼンテーションを管理するプレゼンテーションコントローラを取得するために、提示されたView ControllerのtransitioningDelegateでこのメソッドが呼び出されます。 実装がnilを返す場合は、UIPresentationControllerのインスタンスが使用されます。
- (UIPresentationController*) presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}

// 提示されたView ControllerのtransitioningDelegateでこのメソッドを呼び出し、受信View Controllerのプレゼンテーションのアニメートに使用されるアニメータオブジェクトを取得します。 実装では、UIViewControllerAnimatedTransitioningプロトコルに準拠するオブジェクトが返されます。デフォルトのプレゼンテーションアニメーションを使用する必要がある場合は、nilが返されます。
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;

// The system calls this method on the presented view controller's transitioningDelegate to retrieve the animator object used for animating the dismissal of the presented view controller.  Your implementation is expected to return an object that conforms to the UIViewControllerAnimatedTransitioning protocol, or nil if the default dismissal animation should be used.
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

@end
