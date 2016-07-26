//
//  CPTokenText.h
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
#import "CPToken.h"

@class CPTokenText;

@protocol CPTokenTextDataSource <NSObject>

@optional

/**
 * @brief 토큰 생성 시 어떤 형의 버튼을 쓸지 결정(Sub Class에서 기본 토큰을 쓰지 않을 경우 구현해야 될 delegate)
 * @param tokenText : 발생한 CPTokenText
 * @param index : 생성한 토큰의 인덱스
 * @return CPToken
 */
- (CPToken *)tokenText:(CPTokenText *)tokenText buttonForTokenAtIndex:(int)index;

@end

@protocol CPTokenTextDelegate <NSObject>

@optional

/**
 * @brief TokenText의 높이 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param tokenText : 발생한 CPTokenText
 * @param height : 변경된 높이
 * @return nil
 */
- (void) tokenText:(CPTokenText *)tokenText changeHeight:(CGFloat)height;

/**
 * @brief 토큰 터치 시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param tokenText : 발생한 CPTokenText
 * @param index : 터치된 토큰의 인덱스
 * @return nil
 */
- (void) tokenText:(CPTokenText *)tokenText clickedTokenAtIndex:(int)index;

/**
 * @brief TextView에 포커스 아웃 될 때 호출
 * @param tokenText : 발생한 CPTokenText
 * @return nil
 */
- (void) tokenTextDidEndEditing:(CPTokenText *)tokenText;

/**
 * @brief TextView에 포커스 인 될 때 호출
 * @param tokenText : 발생한 CPTokenText
 * @return nil
 */
- (void) tokenTextShouldBeginEditing:(CPTokenText *)tokenText;

/**
 * @brief TextView 의 텍스트 변경 시 호출
 * @param tokenText : 발생한 CPTokenText
 * @return nil
 */
- (void) tokenText:(CPTokenText *)tokenText shouldChangeText:(NSString *)text;

/**
 * @brief Token이 추가되거나 삭제 되고 나서 호출
 * @param tokenText : 발생한 CPTokenText
 * @return nil
 */
- (void) tokenTextDidChange:(CPTokenText *)tokenText;

@end

@interface CPTokenText : UIView <UITextViewDelegate, CPTokenDelegate, CPTokenTextDataSource>

@property (nonatomic) id <CPTokenTextDelegate> delegate;

@property (nonatomic) id <CPTokenTextDataSource> dataSource;

/**
 * @brief UITextView
 */
@property (nonatomic, strong) UITextView *textView;

/**
 * @brief Placeholder Text
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * @brief 생성된 토큰을 담는 배열
 */
@property (nonatomic, strong) NSMutableArray *tokenList;

/**
 * @brief 선택된 토큰 목록
 */
@property (nonatomic, strong, readonly) NSArray *selectedTokenList;

/**
 * @brief 패딩
 */
@property (nonatomic) UIEdgeInsets padding;

/**
 * @brief 토큰 간 거리
 */
@property (nonatomic) CGFloat gap;

/**
 * @brief text 사이즈
 */
@property (nonatomic) int textSize;

/**
 * @brief 라인 수
 */
@property (nonatomic) int lineCount;

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @return nil
 */
- (void) addToken:(NSString *)token;

/**
 * @brief 마지막 인덱스에 토큰 추가
 * @param tokens : 토큰 타이틀 목록
 * @return nil
 */
- (void) addTokens:(NSMutableArray *)tokens;

/**
 * @brief 특정 인덱스에 토큰 추가
 * @param token : 토큰 타이틀
 * @param index : 토큰 추가할 위치
 * @return nil
 */
- (void) insertToken:(NSString *)token atIndex:(int)index;

/**
 * @brief 마지막 인덱스의 토큰 삭제
 * @return nil
 */
- (void) removeToken;

/**
 * @brief 모든 토큰 삭제
 * @return nil
 */
- (void) removeAllTokens;

/**
 * @brief 특정 인덱스의 토큰 삭제
 * @param index : 삭제할 토큰 위치
 * @return nil
 */
- (void) deleteTokenAtIndex:(int)index;

@end
