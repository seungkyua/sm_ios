//
//  CPValidater.h
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
#import "CPValidationConst.h"

typedef enum {
    VALIDATION_TYPE_NOT_EMPTY,
    VALIDATION_TYPE_NUMERIC,
    VALIDATION_TYPE_PHONE_NUMBER,
    VALIDATION_TYPE_EMAIL,
    VALIDATION_TYPE_ENGLISH,
    VALIDATION_TYPE_ENGLISH_NUMERIC,
    VALIDATION_TYPE_NONE
} VALIDATION_TYPE;

@interface CPValidater : NSObject

/**
 * @brief 유효성 체크할 컨트롤
 */
@property (nonatomic, strong) UIView *targetControl;

/**
 * @brief 에러 메시지 표시할 Label
 */
@property (nonatomic, strong) UILabel *errorLabel;

/**
 * @brief 체크할 타입
 */
@property (nonatomic) VALIDATION_TYPE validationType;

/**
 * @brief 실시간으로 체크할 것인지 여부
 */
@property (nonatomic) BOOL isRealtime;

/**
 * @brief 최소 길이
 */
@property (nonatomic) int minLength;

/**
 * @brief 최대 길이
 */
@property (nonatomic) int maxLength;

/**
 * @brief 유효성 체크할 값과 에러 표시할 TextField를 설정한다.
 * @param value : 유효성 체크할 Control의 값
 * @param errorLabel : 에러 메시지 표시할 Label
 * @param validationType : 체크할 타입
 * @return void
 */
- (id) initWithControl:(UIView *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType;

/**
 * @brief 유효성 체크할 값과 에러 표시할 TextField를 설정한다.
 * @param value : 유효성 체크할 Control의 값
 * @param errorLabel : 에러 메시지 표시할 Label
 * @param validationType : 체크할 타입
 * @param isRealtime : 실시간으로 체크할 것인지 여부
 * @return void
 */
- (id) initWithControl:(UIView *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType isRealtime:(BOOL) _isRealTime;

/**
 * @brief 유효성 체크할 값과 에러 표시할 TextField를 설정한다.
 * @param value : 유효성 체크할 Control의 값
 * @param errorLabel : 에러 메시지 표시할 Label
 * @param validationType : 체크할 타입
 * @param isRealtime : 실시간으로 체크할 것인지 여부
 * @param minLength : 최소 길이
 * @param maxLength : 최대 길이
 * @return void
 */
- (id) initWithControl:(UIView *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType isRealtime:(BOOL) _isRealTime minLength:(int) _minLength maxLength:(int) _maxLength;

/**
 * @brief targetControl의 값 가져오기
 * @return NSString
 */
- (NSString *) targetValue;

/**
 * @brief 유효성 체크
 * @return 유효성 여부
 */
- (BOOL) isValid;

@end
