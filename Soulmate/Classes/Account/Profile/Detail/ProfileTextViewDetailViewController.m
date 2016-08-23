//
//  ProfileTextViewDetailViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTextViewDetailViewController.h"

@interface ProfileTextViewDetailViewController () <UITextViewDelegate>

@end

@implementation ProfileTextViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _textView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([@"selfDesc" isEqualToString:self.type]) {
        [_textView setText:self.profile.selfDesc];
    } 
    
    [self highlightBtn];
    [_textView becomeFirstResponder];
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
    if ([_textView.text isEqualToString:@""]) {
        _btnComplete.enabled = NO;
    } else {
        _btnComplete.enabled = YES;
    }
}

- (void) setTextLimit {
    NSString *t = @"";
    t = [NSString stringWithFormat:@"%ld / %ld bytes", [_textView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding], (long)self.limitBytes];
    [_labelLimit setText:t];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self highlightBtn];
    [self setTextLimit];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.limitBytes > 0) {
        return [_textView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + ([text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - range.length) <= self.limitBytes;
    } else {
        return YES;
    }
}

#pragma mark - Event Handler

- (IBAction)touchBtnComplete:(id)sender {
    if ([@"selfDesc" isEqualToString:self.type]) {
        self.profile.selfDesc = _textView.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
