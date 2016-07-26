//
//  CPHelper.h
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

typedef enum {
    POPUP_TYPE_DEFAULT,
    POPUP_TYPE_CENTER,
} PopupType;

@interface CPHelper : NSObject



/**
 * @brief Modal View Popup : 레이어 팝업
 * @param view
 * @param type : default / center
 * @return void
 */
+(void) popupView:(UIView *)view withType:(PopupType)type;

/**
 * @brief Close Modal View Popup
 * @param view
 * @param type : default /center
 * @return void
 */
+(void) closePopupView:(UIView *)view withType:(PopupType)type;

/**
 * @brief Drop Down View Popup : 드랍 다운 메뉴 팝업
 * @param view : 화면에 띄울 View
 * @param parentView : view 의 부모가 될 View
 * @param baseView : view 위치의 기준이 될 view(baseView 아래에 view가 붙도록 한다)
 * @return void
 */
+(void) popupDropDownView:(UIView *)view parentView:(UIView *)parentView baseView:(UIView *)baseView;

/**
 * @brief Close Drop Down View Popup : 드랍 다운 메뉴 닫기
 * @param view
 * @return void
 */
+(void) closePopupDropDownView:(UIView *)view;

/**
 * @brief hide keyboard
 * @return nil
 */
+(void) hideKeyboard;

@end
