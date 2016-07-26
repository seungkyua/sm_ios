//
//  CPComboBase.h
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

@class CPComboBase;

@protocol CPComboBaseDelegate <NSObject>

@optional
/**
 * @brief 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param combo : 이벤트 발생한 CPComboBase 를 리턴
 * @param value : 화면에 표시되는 값
 * @return nil
 */
- (void) combo:(CPComboBase *)combo value:(NSString *)value;

@end

@interface CPComboBase : UILabel

@property (weak) id <CPComboBaseDelegate> delegate;

/**
 * @brief TextField의 placeholder와 같은 기능
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * @brief data 의 내용 중 placeholder로 지정할 인덱스
 */
@property (nonatomic) NSInteger placeholderIndex;

/**
 * @brief 화면에 표시되는 텍스트의 색상
 */
@property (nonatomic, strong) UIColor *labelColor;

/**
 * @brief placeholder 텍스트의 색상
 */
@property (nonatomic, strong) UIColor *placeholderLabelColor;

/**
 * @brief Combo에서 사용할 데이터 목록
 */
@property (nonatomic, strong) NSMutableArray *data;

/**
 * @brief Combo Value
 */
@property (nonatomic, strong) NSString *value;

/**
 * @brief 부모 View
 */
@property (nonatomic, strong) id parent;

/**
 * @brief 초기값 세팅
 * @return nil
 */
- (void) initialize;

/**
 * @brief Label 터치 시 선택할 목록을 화면에 표시하는 시점
 * @return nil
 */
- (void) showCombo;

/**
 * @brief 선택 목록을 화면에서 삭제하는 시점
 * @return nil
 */
- (void) hideCombo;

@end
