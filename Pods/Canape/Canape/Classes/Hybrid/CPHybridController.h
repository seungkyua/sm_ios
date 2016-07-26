//
//  CPHybridController.h
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

#import "CPBaseViewController.h"
#import "CPHybridPluginBase.h"

@interface CPHybridController : CPBaseViewController

/**
 * @brief UIWebView
 */
@property (nonatomic, strong) UIWebView *webView;

/**
 * @brief 플러그인 추가
 * @param plugin : 플러그인 객체
 * @param key : key
 */
- (void) addPlugin:(CPHybridPluginBase *)plugin forKey:(NSString *)key;

/**
 * @brief 플러그인 삭제
 * @param plugin : 플러그인 객체
 */
- (void) removePluginForKey:(NSString *)key;

/**
 * @brief js function을 호출해야하는 경우에 사용한다.
 * @param function : function명. ex)Canape.plugin.testFunc
 */
- (void) callJsFunction:(NSString *)function arg:(NSString *)arg;
@end
