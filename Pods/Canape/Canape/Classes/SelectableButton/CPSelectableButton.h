//
//  CPSelectableButton.h
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

@class CPSelectableButton;
@protocol CPSelectableButtonDelegate <NSObject>

/**
 * @brief 버튼 선택시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param selectableButton : 이벤트 발생한 selectableButton 을 리턴
 * @param value : selectableButton에서 선택한 버튼의 value 를 리턴
 * @return nil
 */
- (void) selectableButton:(CPSelectableButton *)selectableButton withValue:(id)value;

@end

@interface CPSelectableButton : UIButton

@property (nonatomic) id <CPSelectableButtonDelegate> delegate;

/**
 * @brief 버튼의 선택 설정
 */
@property (nonatomic, getter=selected) BOOL isSelected;

/**
 * @brief 선택이 되지 않았을 때의 아이콘
 */
@property (nonatomic, strong) UIImage *icon;

/**
 * @brief 선택이 되었을 때의 아이콘
 */
@property (nonatomic, strong) UIImage *selectedIcon;

/**
 * @brief 아이콘의 위치를 오른쪽으로 설정
 */
@property (nonatomic) BOOL iconOnRight;

/**
 * @brief 기본 아이콘을 사용할 경우 사각형으로 그릴지 여부
 */
@property (nonatomic) BOOL isSquareIcon;

/**
 * @brief 아이콘을 사용할지 여부
 */
@property (nonatomic) BOOL useIcon;

/**
 * @brief 버튼의 값 설정
 */
@property (nonatomic) id value;

@end
