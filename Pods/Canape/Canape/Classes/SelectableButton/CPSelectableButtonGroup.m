//
//  CPSelectableButtonGroup.m
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

#import "CPSelectableButtonGroup.h"

@implementation CPSelectableButtonGroup

@synthesize buttonList;

- (id) init {
    self = [super init];
    
    if (self) {
        buttonList = [NSMutableArray array];
    }
    
    return self;
}

#pragma CPSelectableButtonGroup

/**
 * @brief 그룹에 버튼을 추가
 * @param button : 추가할 버튼
 * @return nil
 */
- (void) addButton:(CPSelectableButton *)button {
    button.delegate = self;
    
    [buttonList addObject:button];
}

/**
 * @brief 그룹의 선택된 버튼의 인덱스를 가져온다. (isMultiSelectionEnable:YES일 경우 선택된 마지막 인덱스를 반환한다.)
 * @return NSInteger
 */
- (NSInteger) getSelectedIndex {
    
    NSInteger index = -1;
    for (int i = 0; i < buttonList.count; i++) {
        CPSelectableButton *btn = [buttonList objectAtIndex:i];
        if (btn.isSelected) {
            index = i;
        }
    }
    
    return index;
}

/**
 * @brief 그룹의 선택된 버튼들의 인덱스를 가져온다.
 * @return NSArray
 */
- (NSArray *) getSelectedIndexes {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < buttonList.count; i++) {
        CPSelectableButton *btn = [buttonList objectAtIndex:i];
        if (btn.isSelected) {
            [arr addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    return [NSArray arrayWithArray:arr];
}

/**
 * @brief 그룹의 선택된 버튼의 값을 가져온다. (isMultiSelectionEnable:YES일 경우 선택된 마지막 버튼의 값을 반환한다.)
 * @return id
 */
- (id) getValue {
    id value;
    for (int i = 0; i < buttonList.count; i++) {
        CPSelectableButton *btn = [buttonList objectAtIndex:i];
        if (btn.isSelected) {
            value = btn.value;
        }
    }
    
    return value;
}

/**
 * @brief 그룹의 선택된 버튼들의 값을 가져온다.
 * @return NSArray
 */
- (NSArray *) getValues {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < buttonList.count; i++) {
        CPSelectableButton *btn = [buttonList objectAtIndex:i];
        if (btn.isSelected) {
            [arr addObject:btn.value];
        }
    }
    
    return [NSArray arrayWithArray:arr];
}

#pragma CPSelectableButtonDelegate

- (void) selectableButton:(CPSelectableButton *)selectableButton withValue:(id)value {
    CPSelectableButton *selectedBtn;
    int selectedIndex = -1;
    
    for (int i = 0; i < buttonList.count; i++) {
        CPSelectableButton *btn = [buttonList objectAtIndex:i];
        if (self.isMultiSelectionEnable) {
            if (btn == selectableButton) {
                btn.isSelected = !btn.isSelected;
                
                selectedIndex = i;
                selectedBtn = btn;
            }
        } else {
            if (btn == selectableButton) {
                btn.isSelected = YES;
                
                selectedIndex = i;
                selectedBtn = btn;
            } else {
                btn.isSelected = NO;
            }
        }
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectableButtonGroup:withSelectableButton:value:index:)] && selectedBtn != nil) {
        [self.delegate selectableButtonGroup:self
                        withSelectableButton:selectedBtn
                                       value:selectedBtn.value
                                       index:selectedIndex];
    }
}

@end
