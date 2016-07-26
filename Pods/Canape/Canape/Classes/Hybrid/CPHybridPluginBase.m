//
//  CPHybridPluginBase.m
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

#import "CPHybridPluginBase.h"
#import "CPHybridPluginManager.h"

@implementation CPHybridPluginBase

# pragma clang diagnostic push
# pragma clang diagnostic ignored "-Warc-performSelector-leaks"

/**
 * @brief 플러그인 실행
 * @param method : 메소드 명
 * @param args : 인자
 */
- (void) executeWithMethod:(NSString *)method args:(NSString *)args {
    [self executeWithMethod:method args:args callback:@""];
}

/**
 * @brief 플러그인 실행
 * @param method : 메소드 명
 * @param args : 인자
 * @param callback : callback 함수명
 */
- (void) executeWithMethod:(NSString *)method args:(NSString *)args callback:(NSString *)callback {
    NSLog(@"method : %@, args : %@, callback : %@", method, args, callback);

    _callback = callback;
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@:", method]);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:args];
    }else{
        [self sendError:[NSString stringWithFormat:@"[%@] method is not found!", method]];
        NSLog(@"[%@] method is not found!", method);
    }
}

# pragma clang diagnostic pop

/**
 * @brief WebView로 결과값 전송
 * @param result : 결과
 */
- (void) sendResult:(NSString *)result {
    [[CPHybridPluginManager sharedInstance] sendResult:result];
}

/**
 * @brief WebView로 결과값 전송
 * @param result : 결과
 * @param callback : callback 함수명
 */
- (void) sendResult:(NSString *)result callback:(NSString *)callback {
    [[CPHybridPluginManager sharedInstance] sendResult:result callback:callback];
}

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 */
- (void) sendError:(NSString *)error {
    [[CPHybridPluginManager sharedInstance] sendError:error];
}

/**
 * @brief WebView로 에러내용 전송
 * @param error : 에러내용
 * @param callback : callback 함수명
 */
- (void) sendError:(NSString *)error callback:(NSString *)callback {
    [[CPHybridPluginManager sharedInstance] sendError:error callback:callback];
}

- (NSDictionary *) jsonObjectWithData:(NSString *)data{
    NSDictionary *argDic = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if (!argDic) {
        NSLog(@"JSONObjectWithData error!");
        [self sendError:@"JSONObjectWithData error!"];
    }
    return argDic;
}

- (BOOL)argumentCheck:(NSArray *)checkArgArr argDic:(NSDictionary *)argDic{
    for (int i = 0 ; i < [checkArgArr count]; i++) {
        if (argDic[checkArgArr[i]] == nil || [argDic[checkArgArr[i]] isEqualToString:@""]) {
            NSLog(@"argument error!");
            [self sendError:@"argument error!"];
            return NO;
        }
    }
    return YES;
}



@end
