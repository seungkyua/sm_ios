//
//  ActionSheetViewController.m
//  CanapeTest
//
//  Created by bliex on 2016. 3. 3..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ActionSheetViewController.h"
#import <Canape/Canape.h>

@interface ActionSheetViewController () <CPActionSheetDelegate>
@property (nonatomic, strong) CPActionSheet *cpActionSheet1;
@property (nonatomic, strong) CPActionSheet *cpActionSheet2;
@property (nonatomic, strong) CPActionSheet *cpActionSheet3;
@property (nonatomic, strong) CPActionSheet *cpActionSheet4;
@property (nonatomic, strong) CPActionSheet *cpActionSheet5;
@property (nonatomic, strong) CPActionSheet *cpActionSheet6;
@property (weak, nonatomic) IBOutlet UITextField *eventTextField;
@end

@implementation ActionSheetViewController
@synthesize cpActionSheet1;
@synthesize cpActionSheet2;
@synthesize cpActionSheet3;
@synthesize cpActionSheet4;
@synthesize cpActionSheet5;
@synthesize cpActionSheet6;
@synthesize eventTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cpActionSheet1 = [[CPActionSheet alloc] initWithTitle:@"Action Title" otherButtonTitleArray:@[@"btn1", @"btn2", @"btn3"] cancelButtonTitle:@"CANCEL" delegate:self]; //기본
    cpActionSheet2 = [[CPActionSheet alloc] initWithTitle:@"" otherButtonTitleArray:@[@"btn1", @"btn2", @"btn3"] cancelButtonTitle:@"CANCEL" delegate:self];//타이틀없음
    cpActionSheet3 = [[CPActionSheet alloc] initWithTitle:@"Action Title" otherButtonTitleArray:nil cancelButtonTitle:@"CANCEL" delegate:self]; //버튼없음
    cpActionSheet4 = [[CPActionSheet alloc] initWithTitle:@"Action Title" otherButtonTitleArray:@[@"btn1", @"btn2", @"btn3"] cancelButtonTitle:nil delegate:self]; //취소버튼없음
    cpActionSheet5 = [[CPActionSheet alloc] initWithTitle:@"Action Title 은 두줄까지만 표현되도록 설계되어있습니다." otherButtonTitleArray:@[@"btn1", @"btn2", @"btn3", @"btn4", @"btn5", @"btn6", @"btn7", @"btn8", @"btn9", @"btn10", @"btn11", @"btn12", @"btn13", @"btn14"] cancelButtonTitle:@"CANCEL" delegate:self];//버튼갯수 오버
    
    cpActionSheet6 = [[CPActionSheet alloc] initWithTitle:@"Action Title" otherButtonTitleArray:@[@"btn1", @"btn2", @"btn3"] otherButtonColorArray:@[[UIColor blueColor], [UIColor orangeColor], [UIColor brownColor]] cancelButtonTitle:@"취소" cancelButtonColor:[UIColor greenColor] delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet1:(id)sender {
    [cpActionSheet1 show];
}

- (IBAction)showActionSheet2:(id)sender {
    [cpActionSheet2 show];
}

- (IBAction)showActionSheet3:(id)sender {
    [cpActionSheet3 show];
}

- (IBAction)showActionSheet4:(id)sender {
    [cpActionSheet4 show];
}

- (IBAction)showActionSheet5:(id)sender {
    [cpActionSheet5 show];
}
- (IBAction)showActionSheet6:(id)sender {
    [cpActionSheet6 show];
}


- (void)actionSheet:(CPActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == cpActionSheet1) {
        [eventTextField setText:[NSString stringWithFormat:@"1 - ButtonIndex : %ld",buttonIndex]];
    }else if (actionSheet == cpActionSheet2){
        [eventTextField setText:[NSString stringWithFormat:@"2 - ButtonIndex : %ld",buttonIndex]];
    }else if (actionSheet == cpActionSheet3){
        [eventTextField setText:[NSString stringWithFormat:@"3 - ButtonIndex : %ld",buttonIndex]];
    }else if (actionSheet == cpActionSheet4){
        [eventTextField setText:[NSString stringWithFormat:@"4 - ButtonIndex : %ld",buttonIndex]];
    }else if (actionSheet == cpActionSheet5){
        [eventTextField setText:[NSString stringWithFormat:@"5 - ButtonIndex : %ld",buttonIndex]];
    }else if (actionSheet == cpActionSheet6){
        [eventTextField setText:[NSString stringWithFormat:@"6 - ButtonIndex : %ld",buttonIndex]];
    }
    NSLog(@"Selected ActionSheet Button Index : %ld", buttonIndex);
}

@end














