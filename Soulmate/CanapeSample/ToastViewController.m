//
//  ToastViewController.m
//  CanafeTest
//
//  Created by bliex on 2016. 2. 25..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ToastViewController.h"
#import <Canape/Canape.h>

@interface ToastViewController () 
@property (weak, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation ToastViewController
@synthesize testTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showToast:(id)sender {
    [CPToast showToast:@"showToast"];
}

- (IBAction)showToastDuaration:(id)sender {
    [CPToast showToast:@"showToastDuaration" duaration:1.0f];
}

- (IBAction)showToastDelegate:(id)sender {
    [CPToast showToast:@"showToastDelegate" delegate:self];
    [testTextField setText:@""];
}

- (void)didToastHideComplete{
    [testTextField setText:@"didToastHideComplete 이 호출 되었습니다."];
    NSLog(@"disSelectToastButton");
}


@end
