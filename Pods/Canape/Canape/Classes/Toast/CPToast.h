//
//  CPToast.h
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
#import "CanapeConstants.h"


// Toast 타입
typedef enum : NSUInteger {
    CPTOAST_TYPE_DEFAULT,     // 기본형
    CPTOAST_TYPE_BUTTON,      // 버튼이 있는 Toast
} CPToastType;

static const int TOAST_NUMBER_OF_NINES = 3; //0:화면 높이만큼 모든텍스트표시, 1~:해당줄라인만큼 텍스트표시
static const float TOAST_DURATION = 4.0f; //지속시간
static const float WIDTH_TOAST_PIXEL = 1070.0f; //width
static const float TOAST_FONT_SIZE = 13.0f; //font size
static const float BOTTOM_PADDING_PIXEL = 88.0f; //바닥에서 toast 까지의 간격
//static const UIColor *BACKGROUND_COLOR = [UIColor blueColor];

@protocol CPToastDelegate <NSObject>
//@optional
/**
 * @brief toast hide 완료 된 시점에서 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @return nil
 */
- (void) didToastHideComplete;
@end


@interface CPToast : UIView

@property (strong, nonatomic) NSString *text;
@property (weak) id <CPToastDelegate> delegate;



/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @return nil
 */
+ (void)showToast:(NSString *)text;

/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param delegate : show, hide 시점을 받아 처리해야 할 시
 * @return nil
 */
+ (void)showToast:(NSString *)text delegate:(id)delegate;


/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param duration : 보여질 시간 설정
 * @return nil
 */
+ (void)showToast:(NSString *)text duaration:(float)duration;

/**
 * @brief Toast Show
 * @param text : 표시할 텍스트
 * @param duration : 보여질 시간 설정
 * @param delegate : show, hide 시점을 받아 처리해야 할 시
 * @return nil
 */
+ (void)showToast:(NSString *)text duaration:(float)duration delegate:(id)delegate;


@end
