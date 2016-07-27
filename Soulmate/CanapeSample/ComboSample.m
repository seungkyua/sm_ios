//
//  Combo.m
//  CanapeTest
//
//  Created by HWANGIN YONG on 2016. 3. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ComboSample.h"
#import "CanapeSampleConstants.h"

@implementation ComboSample

@synthesize picker;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initialize {
    [super initialize];
    
    self.data = [NSMutableArray arrayWithObjects:@"사과", @"파인애플", @"딸기", @"바나나", @"사과", @"파인애플", @"딸기", @"바나나", nil];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, DEVICE_SIZE.height - 300, DEVICE_SIZE.width, 300)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.dataSource = self;
    picker.hidden = YES;
    
}

- (void) setParent:(id)parent {
    [super setParent:parent];
    
    [parent addSubview:picker];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * Label 터치 시 호출 되는 메서드로 예제는 Picker를 화면에 표시합니다.
 */
- (void) showCombo {
    [picker setHidden:NO];
}

/*
 * Sub Class 에서 구현해야 할 부분 입니다.
 * setValue 호출 시 호출 되는 메서드로 예제는 Picker를 화면에서 제거합니다.
 */
- (void) hideCombo {
    [picker setHidden:YES];
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
    return [self.data objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setValue:[self.data objectAtIndex:row]];
}

@end
