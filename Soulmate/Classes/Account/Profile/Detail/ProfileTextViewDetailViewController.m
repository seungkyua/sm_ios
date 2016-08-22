//
//  ProfileTextViewDetailViewController.m
//  Soulmate
//
//  Created by HWANGIN YONG on 2016. 8. 22..
//  Copyright © 2016년 bliex. All rights reserved.
//

#import "ProfileTextViewDetailViewController.h"

@interface ProfileTextViewDetailViewController ()

@end

@implementation ProfileTextViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([@"selfDesc" isEqualToString:_type]) {
        [_textView setText:_profile.selfDesc];
    } else if ([@"nick" isEqualToString:_type]) {
        [_textView setText:_profile.nickName];
    } else if ([@"name" isEqualToString:_type]) {
        [_textView setText:_profile.name];
    } else if ([@"university" isEqualToString:_type]) {
        [_textView setText:_profile.universityName];
    } else if ([@"graduate" isEqualToString:_type]) {
        [_textView setText:_profile.graduateSchoolName];
    } else if ([@"companyName" isEqualToString:_type]) {
        [_textView setText:_profile.companyName];
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


- (IBAction)touchBtnComplete:(id)sender {
    if ([@"selfDesc" isEqualToString:_type]) {
        _profile.selfDesc = _textView.text;
    } else if ([@"nick" isEqualToString:_type]) {
        _profile.nickName = _textView.text;
    } else if ([@"name" isEqualToString:_type]) {
        _profile.name = _textView.text;
    } else if ([@"university" isEqualToString:_type]) {
        _profile.universityName = _textView.text;
    } else if ([@"graduate" isEqualToString:_type]) {
        _profile.graduateSchoolName = _textView.text;
    } else if ([@"companyName" isEqualToString:_type]) {
        _profile.companyName = _textView.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
