//
//  CPHybridController.m
//  CanapeProject
//
//  Canape Software License
//  Copyright (c) 2016 BliexSoft, Inc.
//
//  Permission to use, copy, modify, and distribute this software
//  and its documentation for any purpose, without fee, and without
//  a written agreement is hereby granted, provided that the above
//  copyright notice and this and the following paragraphs appear
//  in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "CPHybridController.h"
#import "CPHybridPluginManager.h"

@interface CPHybridController ()

@end

@implementation CPHybridController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 웹뷰 생성
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_webView];
    
    // 플러그인 매니저에 웹뷰 등록
    [[CPHybridPluginManager sharedInstance] setWebView:_webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @brief 플러그인 추가
 * @param plugin : 플러그인 객체
 * @param key : key
 */
- (void) addPlugin:(CPHybridPluginBase *)plugin forKey:(NSString *)key {
    [[CPHybridPluginManager sharedInstance] addPlugin:plugin forKey:key];
}

/**
 * @brief 플러그인 삭제
 * @param plugin : 플러그인 객체
 */
- (void) removePluginForKey:(NSString *)key {
    [[CPHybridPluginManager sharedInstance] removePluginForKey:key];
}

/**
 * @brief js function을 호출해야하는 경우에 사용한다.
 * @param function : function명. ex)Canape.plugin.testFunc
 */
- (void) callJsFunction:(NSString *)function arg:(NSString *)arg{
    NSLog(@"%@%@('%@')", JS_PREFIX, function, arg);
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%@('%@')", JS_PREFIX, function, arg]];
}

- (void)viewWillAppear:(BOOL)animated {
    // Enter Background Noti 등록
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    // Enter Foreground Noti 등록
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationvDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    // Noti 삭제
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}



#pragma Notification Handler

- (void)applicationDidEnterBackground:(NSNotificationCenter *)noti {
    if (_webView.tag == 1) {
        NSLog(@"background");
        [_webView stringByEvaluatingJavaScriptFromString:JS_DEACTIVATED];
    }
}

- (void)applicationvDidBecomeActive:(NSNotificationCenter *)noti {
    if (_webView.tag == 1) {
        NSLog(@"foreground");
        [_webView stringByEvaluatingJavaScriptFromString:JS_ACTIVATED];
    }
}

@end
