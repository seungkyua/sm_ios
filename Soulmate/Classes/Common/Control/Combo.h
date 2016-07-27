//
//  Combo.h
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "CPComboBase.h"

typedef enum {
    COMBO_TYPE_DEFAUL,
    COMBO_TYPE_DATE,    
    COMBO_TYPE_DATE_YMD,
    COMBO_TYPE_DATE_HMS,
} COMBO_TYPE;

@interface Combo : CPComboBase <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic) COMBO_TYPE comboType;

@end
