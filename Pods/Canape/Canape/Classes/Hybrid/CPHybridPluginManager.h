//
//  CPHybridPluginManager.h
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

#import <UIKit/UIKit.h>
#import "CPHybridPluginBase.h"
#import "CPHybridConst.h"

@interface CPHybridPluginManager : NSObject

@property (nonatomic, strong) UIWebView *webView;

+ (id)sharedInstance;

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
 * @brief WebView로 결과값 전송
 * @param result : 결과
 */
- (void) sendResult:(NSString *)result;

/**
 * @brief WebView로 결과값 전송
 * @param result : 결과
 * @param callback : callback 함수명
 */
- (void) sendResult:(NSString *)result callback:(NSString *)callback;

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 */
- (void) sendError:(NSString *)error;

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 * @param callback : callback 함수명
 */
- (void) sendError:(NSString *)error callback:(NSString *)callback;

@end
