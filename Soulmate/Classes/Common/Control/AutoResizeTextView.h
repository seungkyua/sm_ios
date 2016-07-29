//
//  AutoResizeTextView.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 29..
//  Copyright © 2016년 bliex. All rights reserved.
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

@interface AutoResizeTextView : UITextView

@property (nonatomic) id <AutoResizeTextViewDelegate> textViewDelegate;

@end
