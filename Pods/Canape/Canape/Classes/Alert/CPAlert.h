//
//  CPAlert.h
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

@class CPAlert;

// 너비에 따른 경고창 타입
typedef enum{
    ALERT_TYPE_DEFAULT,     // 기본 형
    ALERT_TYPE_LARGE,       // 넓은 형
} AlertType;

@protocol CPAlertDelegate <NSObject>

//@optional
/**
 * @brief 버튼 선택시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param alert : 이벤트 발생한 CPAlert 를 리턴
 * @param buttonIndex : actionsheet에서 선택한 버튼의 인덱스를 리턴
 * @return nil
 */
- (void) alert:(CPAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CPAlert : UIControl

@property (weak) id <CPAlertDelegate> delegate;

/**
 * @brief 초기화
 * @param title : 타이틀
 * @param contentText : 내용(텍스트)
 * @param content : 내용(텍스트 대신 뷰를 넣어야 할 경우)
 * @param buttonTitlesArray : 버튼 타이틀 배열
 * @param type : 팝업의 타입 설정
 * @return nil
 */
- (id) initWithTitle:(NSString *)title contentText:(NSString *)contentText content:(id)content buttonTitlesArray:(NSArray *)buttonTitlesArray type:(AlertType)type;

/**
 * @brief 팝업이 보여야 할 상황에 호출
 * @return nil
 */
- (void) show;

@end
