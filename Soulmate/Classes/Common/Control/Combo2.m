//
//  Combo.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 7. 27..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "Combo2.h"
#import "SelectList.h"

@interface Combo2 () <SelectListDelegate>

@property (nonatomic, strong) SelectList *selectList;

@end

@implementation Combo2

- (void) initialize {
    [super initialize];
    
    _selectList = [[SelectList alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SIZE.width, DEVICE_SIZE.height)];
    [_selectList setDelegate:self];
    [_selectList setHidden:YES];
    
    
}

- (void) setData:(NSMutableArray *)data {
    [super setData:data];
    
    [_selectList setData:data];
}

- (void) setParent:(id)parent {
    [super setParent:parent];
    
    [parent addSubview:_selectList];
}

- (void) setMultiSelectEnable:(BOOL)multiSelectEnable {
    _multiSelectEnable = multiSelectEnable;
    
    [_selectList setMultiSelectEnable:multiSelectEnable];
}

- (void)setLimitSelectCount:(NSInteger)limitSelectCount {
    _limitSelectCount = limitSelectCount;
    
    [_selectList setLimitSelectCount:limitSelectCount];
}

- (void) setSelectedData:(NSString *)selectedData {
    _selectedData = selectedData;
    
    [_selectList setSelectedData:selectedData];
}

- (void) setSelectedDatas:(NSMutableArray *)selectedDatas {
    _selectedDatas = selectedDatas;
    
    NSString *dataText = @"";
    for (int i = 0; i < selectedDatas.count; i++) {
        if ([dataText isEqualToString:@""]) {
            dataText = [CommonUtil findTextByData:[selectedDatas objectAtIndex:i] InArray:self.data];
        } else {
            dataText = [NSString stringWithFormat:@"%@, %@", dataText, [CommonUtil findTextByData:[selectedDatas objectAtIndex:i] InArray:self.data]];
        }
    }
    
    [self setValue:dataText];
    [_selectList setSelectedWithDatas:selectedDatas];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * Label 터치 시 호출 되는 메서드로 예제는 Picker를 화면에 표시합니다.
 */
- (void) showCombo {
    [_selectList setHidden:NO];
    
    [CPHelper popupView:_selectList withType:POPUP_TYPE_CENTER];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * setValue 호출 시 호출 되는 메서드로 예제는 Picker를 화면에서 제거합니다.
 */
- (void) hideCombo {
    [_selectList setHidden:YES];
}

- (void) selectList:(SelectList *)selectList text:(NSString *)text data:(NSString *)data {
    [self setValue:text];
    [self setSelectedData:data];
    
    if (_comboDelegate != nil && [_comboDelegate respondsToSelector:@selector(combo:text:data:)]) {
        [_comboDelegate combo:self text:text data:data];
    }
}


- (void) selectList:(SelectList *)selectList datas:(NSMutableArray *)datas {
    NSString *value = @"";
    
    for (int i = 0; i < datas.count; i++) {
        NSString *text = [datas objectAtIndex:i][@"text"];
        if ([value isEqualToString:@""]) {
            value = text;
        } else {
            value = [NSString stringWithFormat:@"%@, %@", value, text];
        }
    }
    
    [self setValue:value];
    
    if (_comboDelegate != nil && [_comboDelegate respondsToSelector:@selector(combo:datas:)]) {
        [_comboDelegate combo:self datas:datas];
    }
}


@end
