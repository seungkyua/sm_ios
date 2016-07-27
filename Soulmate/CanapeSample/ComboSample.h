//
//  Combo.h
//  CanapeTest
//
//  Created by HWANGIN YONG on 2016. 3. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import <Canape/Canape.h>

@interface ComboSample : CPComboBase <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *picker;

@end
