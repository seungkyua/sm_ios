//
//  AutoResizeTextView.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 29..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  문자열에 따라 자동으로 높이가 변하는 TextView
//

#import <UIKit/UIKit.h>

@class AutoResizeTextView;

@protocol AutoResizeTextViewDelegate <NSObject>

@optional

/**
 * @brief TextView 크기 변경 시 호출
 * @param token : 이벤트 발생한 TextView를 리턴
 * @return nil
 */
- (void) changeHeightWithTextView:(AutoResizeTextView *)autoResizeTextView height:(double)height;

@end

@interface AutoResizeTextView : UITextView <UITextViewDelegate>

@property (nonatomic) id <AutoResizeTextViewDelegate> textViewDelegate;

@end
