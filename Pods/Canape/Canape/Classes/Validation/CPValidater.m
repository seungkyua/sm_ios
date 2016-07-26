//
//  CPValidater.m
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

#import "CPValidater.h"

@interface CPValidater ()

@property (nonatomic, strong) NSString *checkValue;

@end

@implementation CPValidater

@synthesize checkValue;
@synthesize targetControl;
@synthesize errorLabel;
@synthesize validationType;
@synthesize isRealtime;
@synthesize minLength;
@synthesize maxLength;

/**
 * @brief 유효성 체크할 값과 에러 표시할 TextField를 설정한다.
 * @param value : 유효성 체크할 Control의 값
 * @param errorLabel : 에러 메시지 표시할 Label
 * @param validationType : 체크할 타입
 * @return void
 */
- (id) initWithControl:(UIControl *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType {
    self = [super init];
    
    targetControl = _targetControl;
    errorLabel = _errorLabel;
    validationType = _validationType;
    
    return self;
}

/**
 * @brief 유효성 체크할 Control과 에러 표시할 TextField를 설정한다.
 * @param value : 유효성 체크할 Control의 값
 * @param errorLabel : 에러 메시지 표시할 Label
 * @param validationType : 체크할 타입
 * @param isRealtime : 실시간으로 체크할 것인지 여부
 * @return void
 */
- (id) initWithControl:(UIControl *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType isRealtime:(BOOL) _isRealTime{
    
    self = [self initWithControl:_targetControl
                      errorLabel:_errorLabel
                  validationType:_validationType];
            
    isRealtime = _isRealTime;
    
    return self;
}

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
- (id) initWithControl:(UIControl *) _targetControl errorLabel:(UILabel *) _errorLabel validationType:(VALIDATION_TYPE) _validationType isRealtime:(BOOL) _isRealTime minLength:(int) _minLength maxLength:(int) _maxLength {
    
    self = [self initWithControl:_targetControl
                      errorLabel:_errorLabel
                  validationType:_validationType
                      isRealtime:_isRealTime];
    
    minLength = _minLength;
    maxLength = _maxLength;
    
    return self;
}

/**
 * @brief targetControl의 값 가져오기
 * @return NSString
 */
- (NSString *) targetValue {
    return @"";
}

/**
 * @brief 유효성 체크
 * @return 유효성 여부
 */
- (BOOL) isValid {
    BOOL result = TRUE;
    
    NSPredicate* validate;
    NSString *message;
    // 트림 처리
    checkValue = [[self targetValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ];
    
    switch (validationType) {
        // 필수값 체크
        case VALIDATION_TYPE_NOT_EMPTY:
            if (checkValue.length == 0) {
                result = FALSE;
                message = VALIDATION_MESSAGE_NOT_EMPTY;
            } else {
                result = TRUE;
            }
            break;
        
        // 숫자만 입력
        case VALIDATION_TYPE_NUMERIC:
            validate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATION_REX_NUMERIC];
            result = [validate evaluateWithObject: checkValue];
            message = VALIDATION_MESSAGE_NUMERIC;
            break;
        
        // 휴대폰 번호 체크
        case VALIDATION_TYPE_PHONE_NUMBER:
            validate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATION_REX_PHONE_NUMBER];
            result = [validate evaluateWithObject: checkValue];
            message = VALIDATION_MESSAGE_PHONE_NUMBER;
            break;
        
        // 이메일 주소 체크
        case VALIDATION_TYPE_EMAIL:
            validate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATION_REX_EMAIL];
            result = [validate evaluateWithObject: checkValue];
            message = VALIDATION_MESSAGE_EMAIL;
            break;
            
        // 영문만 입력
        case VALIDATION_TYPE_ENGLISH:
            validate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATION_REX_ENGLISH];
            result = [validate evaluateWithObject: checkValue];
            message = VALIDATION_MESSAGE_ENGLISH;
            break;
            
        // 영문, 숫자만 입력
        case VALIDATION_TYPE_ENGLISH_NUMERIC:
            validate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATION_REX_ENGLISH_NUMERIC];
            result = [validate evaluateWithObject: checkValue];
            message = VALIDATION_MESSAGE_ENGLISH_NUMERIC;
            break;
            
        default:
            break;
    }
    
    // min or max 길이 체크
    if (minLength > 0 || maxLength > 0) {
        if (minLength > 0 && maxLength > 0) {
            if (checkValue.length < minLength || checkValue.length > maxLength) {
                if (checkValue.length < minLength) {
                    message = [NSString stringWithFormat:@"%d %@", minLength, VALIDATION_MESSAGE_MIN_LENGTH];
                } else {
                    message = [NSString stringWithFormat:@"%d %@", maxLength, VALIDATION_MESSAGE_MAX_LENGTH];
                }
                result = FALSE;
            }
        } else if (maxLength == 0 && minLength > 0) {
            if (checkValue.length < minLength) {
                message = [NSString stringWithFormat:@"%d %@", minLength, VALIDATION_MESSAGE_MIN_LENGTH];
                result = FALSE;
            }
        } else if (minLength == 0 && maxLength > 0) {
            if (checkValue.length > maxLength) {
                message = [NSString stringWithFormat:@"%d %@", maxLength, VALIDATION_MESSAGE_MAX_LENGTH];
                result = FALSE;
            }
        }
    }
    
    if (!result) {
        [errorLabel setText:message];
    } else {
        [errorLabel setText:@""];
    }
    
    return result;
}

@end
