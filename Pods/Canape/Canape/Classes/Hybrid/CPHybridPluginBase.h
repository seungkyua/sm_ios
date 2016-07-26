//
//  CPHybridPluginBase.h
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

#import <Foundation/Foundation.h>

@interface CPHybridPluginBase : NSObject

/**
 * @brief 콜백 함수명
 */
@property (nonatomic, strong) NSString *callback;

/**
 * @brief 플러그인 실행
 * @param method : 메소드 명
 * @param args : 인자
 */
- (void) executeWithMethod:(NSString *)method args:(NSString *)args;

/**
 * @brief 플러그인 실행
 * @param method : 메소드 명
 * @param args : 인자
 * @param callback : callback 함수명
 */
- (void) executeWithMethod:(NSString *)method args:(NSString *)args callback:(NSString *)callback;

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

/**
 * @brief data를 jsonObject로 변환, 변환에러 발생시 sendError실행
 * @param data : jsonString data
 * @return NSDictionary
 */
- (NSDictionary *) jsonObjectWithData:(NSString *)data;

/**
 * @brief argument가 NSDictionary 에 존재하는지 또 내용이 있는지 체크
 * @param checkArgArr : argument key 배열
 * @param argDic : 검색대상 NSDictionary
 * @return BOOL : 해당키가 존재하고 내용이 있으면 YES 아니면 NO를 리턴
 */
- (BOOL)argumentCheck:(NSArray *)checkArgArr argDic:(NSDictionary *)argDic;
@end
