//
//  CPSelectableButtonGroup.h
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

#import <Foundation/Foundation.h>
#import "CPSelectableButton.h"

@class CPSelectableButtonGroup;
@protocol CPSelectableButtonGroupDelegate <NSObject>

/**
 * @brief 버튼 선택시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param group : 이벤트 발생한 selectableButtonGroup 을 리턴
 * @param selectableButton : 이벤트 발생한 selectableButton 을 리턴
 * @param value : Group에서 선택한 버튼의 value 를 리턴
 * @param index : Group에서 선택한 버튼의 index 를 리턴
 * @return nil
 */
- (void) selectableButtonGroup:(CPSelectableButtonGroup *)group withSelectableButton:(CPSelectableButton *)selectableButton value:(id)value index:(int) index;

@end

@interface CPSelectableButtonGroup : NSObject <CPSelectableButtonDelegate>

@property (nonatomic) id <CPSelectableButtonGroupDelegate> delegate;

/**
 * @brief 그룹에 추가된 버튼 리스트
 */
@property (nonatomic, strong) NSMutableArray *buttonList;

/**
 * @brief 그룹 내 버튼들의 다중 선택 가능 여부
 */
@property (nonatomic) BOOL isMultiSelectionEnable;

/**
 * @brief 그룹에 버튼을 추가
 * @param button : 추가할 버튼
 * @return nil
 */
- (void) addButton:(CPSelectableButton *)button;

/**
 * @brief 그룹의 선택된 버튼의 인덱스를 가져온다. (isMultiSelectionEnable:NO일 경우 선택된 마지막 인덱스를 반환한다.)
 * @return NSInteger
 */
- (NSInteger) getSelectedIndex;

/**
 * @brief 그룹의 선택된 버튼들의 인덱스를 가져온다.
 * @return NSArray
 */
- (NSArray *) getSelectedIndexes;

/**
 * @brief 그룹의 선택된 버튼의 값을 가져온다. (isMultiSelectionEnable:NO일 경우 선택된 마지막 버튼의 값을 반환한다.)
 * @return id
 */
- (id) getValue;

/**
 * @brief 그룹의 선택된 버튼들의 값을 가져온다.
 * @return NSArray
 */
- (NSArray *) getValues;

@end
