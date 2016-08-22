//
//  Combo.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "Combo.h"
#import "CommonUtil.h"
#import <Canape/Canape.h>

#define DEFAULT_HEIGHT 200

@interface Combo ()

@property (nonatomic, strong) UIControl *pickerContiner;

@end

@implementation Combo

@synthesize picker;

- (void) initialize {
    [super initialize];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height - DEFAULT_HEIGHT, DEVICE_SIZE.width, DEFAULT_HEIGHT)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.dataSource = self;
    
    _pickerContiner = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
    [_pickerContiner addTarget:self action:@selector(onModalTouch) forControlEvents:UIControlEventTouchUpInside];
    [_pickerContiner addSubview:picker];
    [_pickerContiner setHidden:YES];
    [self addSubview:_pickerContiner];
    
}

- (void) setComboType:(COMBO_TYPE)comboType {
    switch (comboType) {
        case COMBO_TYPE_DATE:
        case COMBO_TYPE_DATE_YMD:
        case COMBO_TYPE_DATE_HMS:
            if (_datePicker == nil) {
                _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height - DEFAULT_HEIGHT, DEVICE_SIZE.width, DEFAULT_HEIGHT)];
                [_datePicker setBackgroundColor:[UIColor whiteColor]];
                [_datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"ko_KR"]];
                switch (comboType) {
                    case COMBO_TYPE_DATE_YMD:
                        [_datePicker setDatePickerMode:UIDatePickerModeDate];
                        break;
                    case COMBO_TYPE_DATE_HMS:
                        [_datePicker setDatePickerMode:UIDatePickerModeTime];
                        break;
                    default:
                        break;
                }
                
                [_datePicker addTarget:self action:@selector(dateChange) forControlEvents:UIControlEventValueChanged];
                
                [picker removeFromSuperview];
                [_pickerContiner addSubview:_datePicker];
            }
            break;
            
        default:
            break;
    }
}

- (void) setData:(NSMutableArray *)data {
    [super setData:data];
    
    [picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:NO];
}

- (void) setParent:(id)parent {
    [super setParent:parent];
    
    [parent addSubview:_pickerContiner];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * Label 터치 시 호출 되는 메서드로 예제는 Picker를 화면에 표시합니다.
 */
- (void) showCombo {
    [_pickerContiner setHidden:NO];
    
    [picker selectRow:[CommonUtil findIndexByText:self.value InArray:self.data]
          inComponent:0
             animated:YES];
    [CPHelper popupView:_pickerContiner withType:POPUP_TYPE_DEFAULT];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * setValue 호출 시 호출 되는 메서드로 예제는 Picker를 화면에서 제거합니다.
 */
- (void) hideCombo {
    [_pickerContiner setHidden:YES];
}

- (void) dateChange {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat: NSLocalizedString(@"account.profile.birth.format", nil)];
    
    NSString *dateTime = [format stringFromDate:_datePicker.date];
    [self setValue:dateTime];
}

- (void) onModalTouch {
    [CPHelper closePopupView:_pickerContiner withType:POPUP_TYPE_DEFAULT];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    id rowData = [self.data objectAtIndex:row];
    if ([rowData isKindOfClass:[NSMutableDictionary class]] || [rowData isKindOfClass:[NSMutableDictionary class]]) {
        return [rowData objectForKey:@"text"];
    } else {
        return rowData;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    id rowData = [self.data objectAtIndex:row];
    if ([rowData isKindOfClass:[NSMutableDictionary class]] || [rowData isKindOfClass:[NSMutableDictionary class]]) {
        [self setValue:[rowData objectForKey:@"text"]];
        [self setSelectedData:[rowData objectForKey:@"data"]];
        
        if (_comboDelegate != nil && [_comboDelegate respondsToSelector:@selector(combo:text:data:)]) {
            [_comboDelegate combo:self text:[rowData objectForKey:@"text"] data:[rowData objectForKey:@"data"]];
        }
    } else {
        [self setValue:rowData];
        [self setSelectedData:rowData];
        
        if (_comboDelegate != nil && [_comboDelegate respondsToSelector:@selector(combo:text:data:)]) {
            [_comboDelegate combo:self text:rowData data:rowData];
        }
    }
    
}

@end
