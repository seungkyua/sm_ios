//
//  Combo.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//
//  셀렉트 리스트가 화면 하단에 뜨는 콤보.
//  다중 컬럼 가능.
//  데이터는 디스플레이 문자열의 배열로만 받도록 되어 있음.
//  comboType에 따라 날짜 선택 콤보 가능.
//

#import "CPComboBase.h"

typedef enum {
    COMBO_TYPE_DEFAUL,
    COMBO_TYPE_DATE,    
    COMBO_TYPE_DATE_YMD,
    COMBO_TYPE_DATE_HMS,
} COMBO_TYPE;

@protocol ComboDelegate <NSObject>

@optional
/**
 * @brief 값 변경시 호출(사용하는 뷰에서 구현해야 될 delegate)
 * @param combo : 이벤트 발생한 Combo 를 리턴
 * @param text : 화면에 표시되는 값
 * @param data : data
 * @return nil
 */
- (void) combo:(CPComboBase *)combo text:(NSString *)text data:(NSString *)data;

@end

@interface Combo : CPComboBase <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak) id <ComboDelegate> comboDelegate;

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic) COMBO_TYPE comboType;
@property (nonatomic, strong) NSString *selectedData;

@end
