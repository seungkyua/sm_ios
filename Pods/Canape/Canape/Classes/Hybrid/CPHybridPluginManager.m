//
//  CPHybridPluginManager.m
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

#import "CPHybridPluginManager.h"

@interface CPHybridPluginManager () <UIWebViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *plugins;

@end

@implementation CPHybridPluginManager

static CPHybridPluginManager *sharedInstance = nil;

+ (CPHybridPluginManager *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id) init {
    self = [super init];
    
    if (self) {
        //////////////////////////
        // WebView Config Start //
        //////////////////////////
        
        UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:secretAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
        
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
        
        
        // 
        //    NSDictionary *dic = @{@"WebKitAuthorAndUserStylesEnabledPreferenceKey" : @NO,
        //                          @"WebKitDisplayImagesKey" : @NO,
        //                          @"WebKitJavaScriptEnabled" : @NO};
        //    [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
        
        /////////////////////////
        // WebView Config End //
        ////////////////////////
        
        _plugins = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void) setWebView:(UIWebView *)webView {
    _webView = webView;
    
    [_webView setDelegate:self];
}

/**
 * @brief 플러그인 추가
 * @param plugin : 플러그인 객체
 */
- (void) addPlugin:(CPHybridPluginBase *)plugin forKey:(NSString *)key {
    [_plugins setObject:plugin forKey:key];
}

/**
 * @brief 플러그인 삭제
 * @param plugin : 플러그인 객체
 */
- (void) removePluginForKey:(NSString *)key {
    [_plugins removeObjectForKey:key];
}

/**
 * @brief WebView로 결과값 전송
 * @param result : 결과
 */
- (void) sendResult:(NSString *)result {
    [self sendResult:result callback:@""];
}

/**
 * @brief WebView로 결과값 전송
 * @param result : 결과
 * @param callback : callback 함수명
 */
- (void) sendResult:(NSString *)result callback:(NSString *)callback {
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%@', '%@%@", JS_SUCCESS_PREFIX, callback, result, JS_SUCCESS_SUFFIX]];
}

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 */
- (void) sendError:(NSString *)error {
    [self sendError:error callback:@""];
}

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 * @param callback : callback 함수명
 */
- (void) sendError:(NSString *)error callback:(NSString *)callback {
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%@', '%@%@", JS_ERROR_PREFIX, callback, error, JS_ERROR_SUFFIX]];
}

#pragma UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[request URL] absoluteString];
    NSString *pluginProtocal = [requestString substringWithRange:NSMakeRange(0, PROTOCOL_PULUGIN.length)];

    if ([pluginProtocal isEqualToString:PROTOCOL_PULUGIN]) {
        // 플러그인 실행
        requestString = [requestString substringWithRange:NSMakeRange(PROTOCOL_PULUGIN.length, requestString.length - PROTOCOL_PULUGIN.length)];
        NSArray *urlSpliteArr = [requestString componentsSeparatedByString:@"&"];
        NSString *pluginName = @"";
        NSString *methodName = @"";
        NSString *args = @"";
        NSString *callbackName = @"";
        
        for (int i = 0 ; i < [urlSpliteArr count]; i++) {
            NSArray<NSString *> *protocalData = [urlSpliteArr[i] componentsSeparatedByString:@"="];

            if ([protocalData[0] isEqualToString:PROTOCOL_METHOD]) {
                NSArray *methodProtocal = [protocalData[1] componentsSeparatedByString:@"."];
                pluginName = methodProtocal[0];
                methodName = methodProtocal[1];
            }
            
            if ([protocalData[0] isEqualToString:PROTOCOL_ARGS]) {
                args = [protocalData[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            
            if ([protocalData[0] isEqualToString:PROTOCOL_CALLBACK]) {
                callbackName = protocalData[1];
            }
        }
        
        if (![pluginName isEqualToString:@""] || ![methodName isEqualToString:@""]) {
            if([_plugins objectForKey:pluginName]){
                if(![callbackName isEqualToString:@""]){
                    [[_plugins objectForKey:pluginName] executeWithMethod:methodName args:args callback:callbackName];
                }else{
                    [[_plugins objectForKey:pluginName] executeWithMethod:methodName args:args];
                }
            }else{
                [self sendError:[NSString stringWithFormat:@"[%@] plugin is not found!", pluginName]];
                NSLog(@"%@ plugin is not found", pluginName);
            }
        }else{
            [self sendError:@"METHOD is error! "];
            NSLog(@"METHOD is error! ");
        }

        return NO;
        
    }else{
        return YES;
    }
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    webView.tag = 1;
    
    [webView stringByEvaluatingJavaScriptFromString:JS_DEVICE_READY];
    [webView stringByEvaluatingJavaScriptFromString:JS_ACTIVATED];
}

@end
