//
//  CPStackView.h
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
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CPStackViewLayoutAxis) {
    
    // 수직방향 배치
    CPStackViewLayoutVertical = 0,
    
    // 수평방향 배치
    CPStackViewLayoutHorizontal,
};

typedef NS_ENUM(NSInteger, CPStackViewDistribution) {
    
    // subview 의 크기대로 배치
    CPStackViewDistributionNone = 0,
    
    // stackview의 너비(or 높이)만큼 subview의 너비(or 높이)를 채워서 배치
    CPStackViewDistributionFill,
    
    // stackview의 너비(or 높이)만큼 subview의 너비(or 높이)를 채워서 배치하고
    // subview 높이(or 너비)를 균등하게 배치
    CPStackViewDistributionFillEqually,
    
};

typedef NS_ENUM(NSInteger, CPStackViewAlignment) {
    // UILayoutConstraintAxisVertical 일 때 각 subview 의 정렬 위치
    CPStackViewAlignmentLeft = 0,
    CPStackViewAlignmentCenter,
    CPStackViewAlignmentRight,
    
    // UILayoutConstraintAxisHorizontal 일 때 각 subview 의 정렬 위치
    CPStackViewAlignmentTop,
    CPStackViewAlignmentMiddle,
    CPStackViewAlignmentBottom,
    
    // 기본값(사용자가 배치한 위치대로 정렬)
    CPStackViewAlignmentNone,
};

@interface CPStackView : UIScrollView

/**
 * @brief Subview의 배치 방향(수직, 수평)
 */
@property (nonatomic) CPStackViewLayoutAxis axis;

/**
 * @brief 상하좌우 여백
 */
@property (nonatomic) UIEdgeInsets padding;

/**
 * @brief 각 Subview간의 거리
 */
@property (nonatomic) double gap;

/**
 * @brief Subview가 배치될 때 크기 변경
 */
@property (nonatomic) CPStackViewDistribution distribution;

/**
 * @brief Subview의 정렬 위치
 */
@property (nonatomic) CPStackViewAlignment alignment;

/**
 * @brief 속성 값들을 적용한 subview의 Layout 변경
 * @return void
 */
- (void) setLayout;

@end
