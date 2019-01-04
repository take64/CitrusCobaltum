//
//  CCWebViewModal.m
//  CitrusCobaltum
//
//  Created by kouhei.takemoto on 2019/01/01.
//  Copyright © 2018 citrus.tk. All rights reserved.
//

#import "CCWebViewModal.h"

#import "CitrusFerrumTypedef.h"
#import "CCMediaSound.h"



@interface CCWebViewModal ()

#pragma mark - property
//
// property
//
@property UIViewController *_viewController;
@property WKWebView *_webView;
@property NSMutableURLRequest *_request;
@property UIProgressView *progressView;
@property UIBarButtonItem *prevButton;
@property UIBarButtonItem *nextButton;
@property UIBarButtonItem *reloadButton;

@end



@implementation CCWebViewModal

// 初期化
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UINavigationBar *navigationBar = [[self navigationController] navigationBar];
        
        // インジケーター
        [self setProgressView:[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar]];
        [[self progressView] setFrame:CGRectMake(0, [[[self navigationController] navigationBar] frame].size.height - 2.5, [[[self navigationController] navigationBar] frame].size.width, 2.5)];
        [navigationBar addSubview:[self progressView]];
        
        // ナヴィゲーション表示
        [[self navigationController] setNavigationBarHidden:NO];
        
        // ツールバー非表示
        [[self navigationController] setToolbarHidden:NO];
        
        // ボタン
        UIBarButtonItem *button;
        
        // ボタン(スペーサー)
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        // ボタン(閉じる)
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(hide)];
        [[[self _viewController] navigationItem] setRightBarButtonItem:button];
        
        // ボタン(戻る)
        button = [[UIBarButtonItem alloc] initWithTitle:@"◀︎" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBarButtonPrev)];
        [self setPrevButton:button];
        
        // ボタン(進む)
        button = [[UIBarButtonItem alloc] initWithTitle:@"▶︎" style:UIBarButtonItemStylePlain target:self action:@selector(onTapBarButtonNext)];
        [self setNextButton:button];
        
        // ボタン(再読み込み)
        button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onTapBarButtonReload)];
        [self setReloadButton:button];
        
        [[self _viewController] setToolbarItems:@[
                                                  spacer,
                                                  [self prevButton],
                                                  spacer,
                                                  [self nextButton],
                                                  spacer,
                                                  [self reloadButton],
                                                  spacer,
                                                  ]];
    }
    return self;
}

- (void) dealloc
{
    [[self callWebView] removeObserver:self forKeyPath:@"estimatedProgress"];
    [[self callWebView] removeObserver:self forKeyPath:@"title"];
    [[self callWebView] removeObserver:self forKeyPath:@"canGoBack"];
    [[self callWebView] removeObserver:self forKeyPath:@"canGoForward"];
    [[self callWebView] removeObserver:self forKeyPath:@"loading"];
}
// 非表示
- (void) hide
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

// URL読み込み
- (void) loadURL:(NSString *)urlString
{
    [[self callRequest] setURL:[NSURL URLWithString:urlString]];
    [[self callWebViewWithRefresh:@YES] loadRequest:[self callRequest]];
}

// ボタン押下時(戻る)
- (void) onTapBarButtonPrev
{
    [CCMediaSound playButtonSound];
    
    [[self callWebView] goBack];
}

// ボタン押下時(進む)
- (void) onTapBarButtonNext
{
    [CCMediaSound playButtonSound];
    
    [[self callWebView] goForward];
}

// ボタン押下時(再読み込み)
- (void) onTapBarButtonReload
{
    [CCMediaSound playButtonSound];
    
    [[self callWebView] reload];
}



//
// observe
//
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"] == YES)
    {
        double progress = [[self callWebView] estimatedProgress];
        CFLog(@"%f", progress);
        if (progress > 0)
        {
            [[self progressView] setProgress:progress animated:YES];
            
            [[[self navigationController] navigationBar] addSubview:[self progressView]];
            
            if (progress == 1)
            {
                [[self progressView] removeFromSuperview];
            }
        }
    }
    else if ([keyPath isEqualToString:@"title"] == YES)
    {
        [[self _viewController] setTitle:[[self callWebView] title]];
    }
    else if ([keyPath isEqualToString:@"canGoBack"])
    {
        [[self prevButton] setEnabled:[[self callWebView] canGoBack]];
    }
    else if ([keyPath isEqualToString:@"canGoForward"])
    {
        [[self nextButton] setEnabled:[[self callWebView] canGoForward]];
    }
    else if ([keyPath isEqualToString:@"loading"])
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:[[self callWebView] isLoading]];
        [[self reloadButton] setEnabled:![[self callWebView] isLoading]];
    }
}



#pragma mark - singleton
//
// singleton
//

// リクエスト取得
- (NSMutableURLRequest *) callRequest
{
    if ([self _request] == nil)
    {
        [self set_request:[[NSMutableURLRequest alloc] init]];
    }
    return [self _request];
}

// WEBVIEW取得
- (WKWebView *) callWebViewWithRefresh:(NSNumber *)refresh
{
    // リフレッシュする
    if ([refresh compare:@YES] == NSOrderedSame)
    {
        if ([self _webView] != nil)
        {
            [[self _webView] removeObserver:self forKeyPath:@"estimatedProgress"];
            [[self _webView] removeObserver:self forKeyPath:@"title"];
            [[self _webView] removeObserver:self forKeyPath:@"canGoBack"];
            [[self _webView] removeObserver:self forKeyPath:@"canGoForward"];
            [[self _webView] removeObserver:self forKeyPath:@"loading"];
            [[self _webView] removeFromSuperview];
        }
        [self set_webView:nil];
    }
    
    WKWebView *webView = [self callWebView];
    
    // observe
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    
    [[self prevButton] setEnabled:NO];
    [[self nextButton] setEnabled:NO];
    
    return webView;
}

// WEBVIEW取得
- (WKWebView *)callWebView
{
    if ([self _webView] == nil)
    {
        [self set_webView:[[WKWebView alloc] initWithFrame:[[self view] bounds]]];
        [[self _webView] setNavigationDelegate:self];
        [[[self _viewController] view] addSubview:[self _webView]];
    }
    return [self _webView];
}



#pragma mark - WKNavigationDelegate
//
// WKNavigationDelegate
//

- (void) webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    WKFrameInfo *targetFrame = navigationAction.targetFrame;
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            CFLog(@"WKNavigationTypeLinkActivated::");
            // <a href="..." target="_blank"> が押されたとき
            if (targetFrame == nil)
            {
                [[self callRequest] setURL:[[navigationAction request] URL]];
                [[self callWebView] loadRequest:[self callRequest]];
            }
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            CFLog(@"WKNavigationTypeFormSubmitted::");
            
            break;
        }
        case WKNavigationTypeBackForward: {
            CFLog(@"WKNavigationTypeBackForward::");
            
            break;
        }
        case WKNavigationTypeReload: {
            CFLog(@"WKNavigationTypeReload::");
            
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            CFLog(@"WKNavigationTypeFormResubmitted::");
            
            break;
        }
        case WKNavigationTypeOther: {
            CFLog(@"WKNavigationTypeOther::");
            
            break;
        }
        default: {
            break;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler;
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);


@end
