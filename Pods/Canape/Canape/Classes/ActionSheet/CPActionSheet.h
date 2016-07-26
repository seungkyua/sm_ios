//
//  CPActionSheet.h
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
@class CPActionSheet;
@protocol CPActionSheetDelegate <NSObject>

/**
 * @brief 버튼 선택시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param actionSheet : 이벤트 발생한 actionsheet 를 리턴
 * @param buttonIndex : actionsheet에서 선택한 버튼의 인덱스를 리턴
 * @return nil
 */
- (void) actionSheet:(CPActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end



@interface CPActionSheet : UIControl
/**
 * @brief 생성시 초기화
 * @param title : 타이틀
 * @param otherButtonTitleArray : default 버튼 text의 배열
 * @param cancelButtonTitle : 가장 하단에 붙는 버튼의 text
 * @param delegate
 * @return self
 */
- (id) initWithTitle:(NSString *)title otherButtonTitleArray:(NSArray *)otherTitleArray cancelButtonTitle:(NSString *)cancelTitle delegate:(id)_delegate;

/**
 * @brief 생성시 초기화
 * @param title : 타이틀
 * @param otherButtonTitleArray : default 버튼 text의 배열
 * @param otherColorArray : 버튼 컬러 배열
 * @param cancelButtonTitle : 가장 하단에 붙는 버튼의 text
 * @param delegate
 * @return self
 */
- (id) initWithTitle:(NSString *)title otherButtonTitleArray:(NSArray *)otherTitleArray otherButtonColorArray:(NSArray *)otherColorArray cancelButtonTitle:(NSString *)cancelTitle cancelButtonColor:(UIColor *)cancelColor delegate:(id)_delegate;

/**
 * @brief 팝업이 보여야 할 상황에 호출
 * @return nil
 */
- (void) show;
@end
