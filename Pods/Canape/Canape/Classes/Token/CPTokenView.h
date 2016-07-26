//
//  CPTokenView.h
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
#import "CPTokenText.h"

@class CPTokenView;
@protocol CPTokenViewDelegate <NSObject>

@optional

/**
 * @brief TokenText의 높이 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param tokenText : 발생한 CPTokenText
 * @param height : 변경된 높이
 * @return nil
 */
- (void) tokenView:(CPTokenView *)tokenView changeHeight:(CGFloat)height;

/**
 * @brief Token이 추가되거나 삭제 되고 나서 호출
 * @param tokenText : 발생한 CPTokenText
 * @return nil
 */
- (void) tokenViewDidChange:(CPTokenView *)tokenView;

@end

@interface CPTokenView : UIView <UITableViewDataSource, UITableViewDelegate, CPTokenTextDelegate, CPTokenTextDataSource>

@property (nonatomic) id <CPTokenViewDelegate> delegate;

/**
 * @brief Header Label
 */
@property (nonatomic, strong) UILabel *headerLabel;

/**
 * @brief Header Label에 표시될 텍스트
 */
@property (nonatomic, strong) NSString *headerText;

/**
 * @brief Summary Label
 */
@property (nonatomic, strong) UILabel *summaryLabel;

/**
 * @brief 요약 문자
 */
@property (nonatomic, strong) NSString *summaryText;

/**
 * @brief TokenText를 감싸는 스크롤뷰
 */
@property (nonatomic, strong) UIScrollView *tokenTextContainer;

/**
 * @brief TokenText
 */
@property (nonatomic, strong) CPTokenText *tokenText;

/**
 * @brief 자동완성 리스트
 */
@property (nonatomic, strong) UITableView *autoCompleteTableView;

/**
 * @brief 자동완성 리스트의 데이터
 */
@property (nonatomic, strong) NSMutableArray *autoCompleteData;

/**
 * @brief 입력되는 문자로 autoCompleteData에서 일치하는 데이터의 목록
 */
@property (nonatomic, strong) NSMutableArray *autoCompleteFilterData;

/**
 * @brief TokenText의 placeholder
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * @brief TokenText의 최대 높이(그 이상이면 스크롤)
 */
@property (nonatomic) CGFloat maxTokenHeight;

/**
 * @brief 각 컨트롤간 거리
 */
@property (nonatomic) CGFloat gap;

/**
 * @brief TokenText의 Gap
 */
@property (nonatomic) CGFloat tokenGap;

/**
 * @brief 최저 높이
 */
@property (nonatomic) CGFloat minHeight;

/**
 * @brief headerLabel과 summaryLabel의 y 값
 */
@property (nonatomic) CGFloat labelTop;

/**
 * @brief 텍스트 크기
 */
@property (nonatomic) int textSize;

/**
 * @brief 요약 기능을 쓸 것인지 여부
 */
@property (nonatomic) BOOL useSummary;

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
