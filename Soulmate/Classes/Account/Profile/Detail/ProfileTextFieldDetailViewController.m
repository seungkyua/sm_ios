//
//  ProfileTextViewDetailViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTextFieldDetailViewController.h"

@interface ProfileTextFieldDetailViewController () <UITextFieldDelegate>

@end

@implementation ProfileTextFieldDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textField.delegate = self;
    
    [_textField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([@"nick" isEqualToString:self.type]) {
        [_textField setText:self.profile.nickName];
    } else if ([@"name" isEqualToString:self.type]) {
        [_textField setText:self.profile.name];
    } else if ([@"university" isEqualToString:self.type]) {
        [_textField setText:self.profile.universityName];
    } else if ([@"graduate" isEqualToString:self.type]) {
        [_textField setText:self.profile.graduateSchoolName];
    } else if ([@"companyName" isEqualToString:self.type]) {
        [_textField setText:self.profile.companyName];
    }
    
    [self highlightBtn];
    [_textField becomeFirstResponder];
    if (self.limitBytes == 0) {
        [_labelLimit setHidden:YES];
    } else {
        [self setTextLimit];
        [_labelLimit setHidden:NO];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) highlightBtn {
    if ([_textField.text isEqualToString:@""]) {
        _btnComplete.enabled = NO;
    } else {
        _btnComplete.enabled = YES;
    }
}

- (void) setTextLimit {
    NSString *t = @"";
    t = [NSString stringWithFormat:@"%ld / %ld bytes", [_textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding], (long)self.limitBytes];
    [_labelLimit setText:t];
}

#pragma mark - UITextViewDelegate

- (void)textFieldDidChange {
    [self highlightBtn];
    [self setTextLimit];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.limitBytes > 0) {
        return [_textField.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + ([string lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - range.length) <= self.limitBytes;
    } else {
        return YES;
    }
}

#pragma mark - Event Handler

- (IBAction)touchBtnComplete:(id)sender {
    if ([@"nick" isEqualToString:self.type]) {
        self.profile.nickName = self.textField.text;
    } else if ([@"name" isEqualToString:self.type]) {
        self.profile.name = self.textField.text;
    } else if ([@"university" isEqualToString:self.type]) {
        self.profile.universityName = self.textField.text;
    } else if ([@"graduate" isEqualToString:self.type]) {
        self.profile.graduateSchoolName = self.textField.text;
    } else if ([@"companyName" isEqualToString:self.type]) {
        self.profile.companyName = self.textField.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
