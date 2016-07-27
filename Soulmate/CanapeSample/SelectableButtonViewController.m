//
//  SelectableButtonViewController.m
//  CanapeSample
//
//  Created by HWANGIN YONG on 2016. 3. 31..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "SelectableButtonViewController.h"

@interface SelectableButtonViewController () <CPSelectableButtonGroupDelegate>

@end

@implementation SelectableButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CPSelectableButtonGroup *group1 = [[CPSelectableButtonGroup alloc] init];
    group1.delegate = self;
    [group1 addButton:_radio1];
    [group1 addButton:_radio2];
    [group1 addButton:_radio3];
    
    CPSelectableButtonGroup *group2 = [[CPSelectableButtonGroup alloc] init];
    group2.delegate = self;
    group2.isMultiSelectionEnable = YES;
    [group2 addButton:_checkbox1];
    [group2 addButton:_checkbox2];
    [group2 addButton:_checkbox3];
    
    CPSelectableButtonGroup *group3 = [[CPSelectableButtonGroup alloc] init];
    group3.delegate = self;
    [group3 addButton:_custom1];
    [group3 addButton:_custom2];
    [group3 addButton:_custom3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) selectableButtonGroup:(CPSelectableButtonGroup *)group withSelectableButton:(CPSelectableButton *)selectableButton value:(id)value index:(int)index {
    NSLog(@"indexes : %@, values : %@", [group getSelectedIndexes], [group getValues]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
