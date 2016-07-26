//
//  CPToken.h
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

@class CPToken;

@protocol CPTokenDelegate <NSObject>

@optional

/**
 * @brief 닫기 버튼 터치 시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param token : 이벤트 발생한 CPToken 을 리턴
 * @return nil
 */
- (void) touchCloseWithToken:(CPToken *)token;

@end

@interface CPToken : UIButton

@property (nonatomic) id <CPTokenDelegate> delegate;

/**
 * @brief 타이틀 텍스트로 토큰 버튼 생성
 * @param title : 타이틀 텍스트
 * @return CPToken
 */
+ (CPToken *) createTokenWithTitle:(NSString *)title;

@end
